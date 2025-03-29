require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml
require "fastimage" # needed to determine image dimensions

TILE_SIZE = 32
RUBY_DIR = __dir__ + "/"
TSX_TEMPLATE = RUBY_DIR + "tileset_template.tsx"

ROOT_DIR = RUBY_DIR + "../../"
require_relative ROOT_DIR + "tools/eevee/rmxp/rgss" # needed to manipulate rpg data
require_relative ROOT_DIR + "tools/eevee/src/common"  # needed to load ruby data files

TILESETS_DATA = ROOT_DIR + "src/essentials/Data/Tilesets.rxdata"

AUTOTILES_INPUT = ROOT_DIR + "src/assets/Tiled/Graphics/Autotiles/"
AUTOTILES_OUTPUT = ROOT_DIR + "src/tiled/tilesets/autotiles/"
TILESET_INPUT = ROOT_DIR + "src/assets/Graphics/Tilesets/"
TILESET_OUTPUT = ROOT_DIR + "src/tiled/tilesets/"

AUTOTILES_ASSET_DIR = "../../../assets/Tiled/Graphics/Autotiles/"
TILESET_ASSET_DIR = "../../../src/assets/Graphics/Tilesets/"

def build_base_tsx_properties(tileset, image_file, tsx_to_image_path)
  px_dim = FastImage.size(image_file)
  tile_dim = px_dim.map { |x| x / TILE_SIZE }
  tileset.at_xpath("tileset")["name"] = File.basename(image_file, ".png")
  tileset.at_xpath("tileset")["tilecount"] = tile_dim[0] * tile_dim[1]
  tileset.at_xpath("tileset")["columns"] = tile_dim[0]

  tileset.at_xpath("tileset").at_xpath("image")["source"] = tsx_to_image_path + File.basename(image_file)
  tileset.at_xpath("tileset").at_xpath("image")["width"] = px_dim[0]
  tileset.at_xpath("tileset").at_xpath("image")["height"] = px_dim[1]
  tileset.at_xpath("tileset").add_child "<properties/>"
end

def build_tileset_data_properties(tileset, tileset_data)
  tileset.at_xpath("tileset")["name"] = tileset_data.name
  tileset.at_xpath("tileset").at_xpath("properties").add_child "<property name=\"tileset_data\" type=\"class\" propertytype=\"rpg_tileset\">"
  rpg_tileset = tileset.at_xpath("tileset").at_xpath("properties").xpath("//property")[0]
  rpg_tileset.add_child "<properties/>"

  rpg_tileset.at_xpath("properties").add_child "<property name=\"tileset_name\" value=\"#{tileset_data.tileset_name}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"id\" type=\"int\" value=\"#{tileset_data.id}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"name\" value=\"#{tileset_data.name}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"panorama_name\" value=\"#{tileset_data.panorama_name}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"panorama_hue\" type=\"int\" value=\"#{tileset_data.panorama_hue}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"battleback_name\" value=\"#{tileset_data.battleback_name}\"/>"

  rpg_tileset.at_xpath("properties").add_child "<property name=\"fog\" type=\"class\" propertytype=\"rpg_fog\">"
  rpg_fog = rpg_tileset.at_xpath("properties").xpath("//property")[-1]
  rpg_fog.add_child "<properties/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"name\" value=\"#{tileset_data.fog_name}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"hue\" type=\"int\" value=\"#{tileset_data.fog_hue}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"opacity\" type=\"int\" value=\"#{tileset_data.fog_opacity}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"blend_type\" type=\"int\" value=\"#{tileset_data.fog_blend_type}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"zoom\" type=\"int\" value=\"#{tileset_data.fog_zoom}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"sx\" type=\"int\" value=\"#{tileset_data.fog_sx}\"/>"
  rpg_fog.at_xpath("properties").add_child "<property name=\"sy\" type=\"int\" value=\"#{tileset_data.fog_sy}\"/>"

  rpg_tileset.at_xpath("properties").add_child "<property name=\"autotile_names\" value=\"#{tileset_data.autotile_names.join(",")}\"/>"

  rpg_tileset.at_xpath("properties").add_child "<property name=\"passages\" value=\"#{tileset_data.passages.data.join(",")}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"priorities\" value=\"#{tileset_data.priorities.data.join(",")}\"/>"
  rpg_tileset.at_xpath("properties").add_child "<property name=\"terrain_tags\" value=\"#{tileset_data.terrain_tags.data.join(",")}\"/>"
end

def generate_tsx(image_file, tilesets, tsx_to_image_path, output_dir)

  # find existing tilesets
  tileset_indices = []
  unless tilesets.nil?
    tilesets.each_with_index do |set, index|
      unless set.nil?
        if set.tileset_name == File.basename(image_file, ".png")
          tileset_indices.append(index)
        end
      end
    end
  end

  if tileset_indices.length() > 0
    tileset_indices.each do |tileset_index|
      tileset_data = tilesets[tileset_index]

      tileset = Nokogiri::XML(File.open(TSX_TEMPLATE))
      build_base_tsx_properties(tileset, image_file, tsx_to_image_path)
      build_tileset_data_properties(tileset, tileset_data)

      FileUtils.mkdir_p(output_dir)
      xsl = Nokogiri::XSLT(File.open(RUBY_DIR + "indent.xsl"))
      File.write(output_dir + File.basename(tileset_data.name.gsub(/[^0-9A-Za-z ]/, ""), ".png") + ".tsx", xsl.apply_to(tileset))
    end
  else
    tileset = Nokogiri::XML(File.open(TSX_TEMPLATE))
    build_base_tsx_properties(tileset, image_file, tsx_to_image_path)

    FileUtils.mkdir_p(output_dir)
    xsl = Nokogiri::XSLT(File.open(RUBY_DIR + "indent.xsl"))
    File.write(output_dir + File.basename(image_file, ".png") + ".tsx", xsl.apply_to(tileset))
  end
end

def generate_tilesets(source_dir, image_rel, output_dir, autotiles)
  puts "Generating tilesets..."
  tilesets = nil
  unless autotiles
    tilesets = load_rxdata(TILESETS_DATA)
  end
  image_dir = Dir.new(source_dir)
  image_dir.each_child do |image|
    puts "Generating tsx from #{image}..."
    generate_tsx(source_dir + image, tilesets, image_rel, output_dir)
  end
  puts "Finished generating tilesets.\n\n"
end

generate_tilesets(TILESET_INPUT, TILESET_ASSET_DIR, TILESET_OUTPUT, false)
generate_tilesets(AUTOTILES_INPUT, AUTOTILES_ASSET_DIR, AUTOTILES_OUTPUT, true)
