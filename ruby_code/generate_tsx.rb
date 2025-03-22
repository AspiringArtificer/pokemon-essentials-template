require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml
require "fastimage" # needed to determine image dimensions

TILE_SIZE = 32
RUBY_DIR = __dir__ + "/"
TSX_TEMPLATE = RUBY_DIR + "tileset_template.tsx"

ROOT_DIR = RUBY_DIR + "../"
AUTOTILES_INPUT = ROOT_DIR + "src/assets/Tiled/Graphics/Autotiles/"
AUTOTILES_OUTPUT = ROOT_DIR + "src/tiled/tilesets/autotiles/"
TILESET_INPUT = ROOT_DIR + "src/assets/Graphics/Tilesets/"
TILESET_OUTPUT = ROOT_DIR + "src/tiled/tilesets/"

AUTOTILES_ASSET_DIR = "../../../assets/Tiled/Graphics/Autotiles/"
TILESET_ASSET_DIR = "../../../src/assets/Graphics/Tilesets/"

def generate_tsx(image_file, tsx_to_image_path, output_dir)
  tileset = Nokogiri::XML(File.open(TSX_TEMPLATE))
  px_dim = FastImage.size(image_file)
  tile_dim = px_dim.map { |x| x / TILE_SIZE }

  tileset.at_xpath("tileset")["name"] = File.basename(image_file, ".png")
  tileset.at_xpath("tileset")["tilecount"] = tile_dim[0] * tile_dim[1]
  tileset.at_xpath("tileset")["columns"] = tile_dim[0]

  tileset.at_xpath("tileset").at_xpath("image")["source"] = tsx_to_image_path + File.basename(image_file)
  tileset.at_xpath("tileset").at_xpath("image")["width"] = px_dim[0]
  tileset.at_xpath("tileset").at_xpath("image")["height"] = px_dim[1]

  FileUtils.mkdir_p(output_dir)
  File.write(output_dir + File.basename(image_file, ".png") + ".tsx", tileset)
end

def generate_tilesets(source_dir, image_rel, output_dir)
  image_dir = Dir.new(source_dir)
  image_dir.each_child do |image|
    puts "Processing #{image}..."
    generate_tsx(source_dir + image, image_rel, output_dir)
  end
end

generate_tilesets(TILESET_INPUT, TILESET_ASSET_DIR, TILESET_OUTPUT)
generate_tilesets(AUTOTILES_INPUT, AUTOTILES_ASSET_DIR, AUTOTILES_OUTPUT)
