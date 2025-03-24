require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml
require "nokogiri-pretty" # needed to print file with clean formatting
require "fastimage" # needed to determine image dimensions

TILE_SIZE = 32
RUBY_DIR = __dir__ + "/"
TSX_TEMPLATE = RUBY_DIR + "tileset_template.tsx"
TMS_TEMPLATE = RUBY_DIR + "map_template.tmx"

ROOT_DIR = RUBY_DIR + "../"
require_relative ROOT_DIR + "tools/eevee/rmxp/rgss" # needed to manipulate rpg data
require_relative ROOT_DIR + "tools/eevee/src/common"  # needed to load ruby data files

TILESETS_DATA = ROOT_DIR + "src/essentials/Data/Tilesets.rxdata"
MAPINFOS_DATA = ROOT_DIR + "src/essentials/Data/MapInfos.rxdata"

AUTOTILES_DIR = ROOT_DIR + "src/tiled/tilesets/autotiles/"
TILESETS_DIR = ROOT_DIR + "src/tiled/tilesets/"

def get_tileset_id(tileset_path)
  tileset = Nokogiri::XML(File.open(tileset_path))
  for property in tileset.xpath("//property")
    name = property["name"]
    if name == "id"
      return property["value"].to_i
    end
  end
  return 0
end

def get_sorted_tilesets(source_dir)
  files = Dir.foreach(source_dir).select { |x| File.file?("#{source_dir}/#{x}") }

  tilesets = []
  for file in files
    if File.extname(file) == ".tsx"
      tilesets.append(convert_tsx_to_tileset(source_dir + file))
    end
  end

  tilesets.sort! do |a, b|
    case
    when a.id == b.id
      raise IndexError.new "Tilesets #{a} and #{b} have same index=#{a.id}!"
    else
      a.id <=> b.id
    end
  end

  return tilesets
end

def convert_tsx_to_tileset(tsx_path)
  tsx = Nokogiri::XML(File.open(tsx_path)).root
  tileset = RPG::Tileset.new

  tileset.name = tsx["name"]
  tileset.id = (tsx.xpath("//property").detect { |x| x["name"] == "id" })["value"].to_i
  tileset.tileset_name = (tsx.xpath("//property").detect { |x| x["name"] == "tileset_name" })["value"]
  tileset.autotile_names = (tsx.xpath("//property").detect { |x| x["name"] == "autotile_names" })["value"].split(",", -1)
  tileset.panorama_name = (tsx.xpath("//property").detect { |x| x["name"] == "panorama_name" })["value"]
  tileset.panorama_hue = (tsx.xpath("//property").detect { |x| x["name"] == "panorama_hue" })["value"].to_i
  tileset.battleback_name = (tsx.xpath("//property").detect { |x| x["name"] == "battleback_name" })["value"]

  fog_properties = tsx.xpath("//property").detect { |x| x["name"] == "fog" }.at_xpath("properties").children
  tileset.fog_name = (fog_properties.detect { |x| x["name"] == "name" })["value"]
  tileset.fog_hue = (fog_properties.detect { |x| x["name"] == "hue" })["value"].to_i
  tileset.fog_opacity = (fog_properties.detect { |x| x["name"] == "opacity" })["value"].to_i
  tileset.fog_blend_type = (fog_properties.detect { |x| x["name"] == "blend_type" })["value"].to_i
  tileset.fog_zoom = (fog_properties.detect { |x| x["name"] == "zoom" })["value"].to_i
  tileset.fog_sx = (fog_properties.detect { |x| x["name"] == "sx" })["value"].to_i
  tileset.fog_sy = (fog_properties.detect { |x| x["name"] == "sy" })["value"].to_i

  passages = (tsx.xpath("//property").detect { |x| x["name"] == "passages" })["value"].split(",").map(&:to_i)
  priorities = (tsx.xpath("//property").detect { |x| x["name"] == "priorities" })["value"].split(",").map(&:to_i)
  terrain_tags = (tsx.xpath("//property").detect { |x| x["name"] == "terrain_tags" })["value"].split(",").map(&:to_i)

  tileset.passages = Table.new(passages.length())
  tileset.passages.data = passages
  tileset.priorities = Table.new(priorities.length())
  tileset.priorities.data = priorities
  tileset.terrain_tags = Table.new(terrain_tags.length())
  tileset.terrain_tags.data = terrain_tags
  return tileset
end

def compile_tilesets(source_dir, output_dir)
  new_tilesets = get_sorted_tilesets(source_dir)

  tilesets = []
  index = 0
  for ts in new_tilesets
    while index < ts.id
      tilesets.append(nil)
      index += 1
    end
    tilesets.append(ts)
    index += 1
  end

  FileUtils.mkdir_p(output_dir)
  save_ruby(output_dir + "Tilesets.rb", tilesets)
  save_rxdata(output_dir + "Tilesets.rxdata", tilesets)
end

def compile_maps(source_dir, output_dir)
  mapinfo = RPG::MapInfo.new

  temp_map = RPG::Map.new(1, 1)

  FileUtils.mkdir_p(output_dir)
  # save_ruby(output_dir + "MapInfos.rb", mapinfo)
  # save_ruby(output_dir + "Map001.rb", temp_map)
  # save_rxdata(output_dir + "MapInfos.rxdata", mapinfo)
  # save_rxdata(output_dir + "Map001.rxdata", temp_map)
end

def compile_all(source_dir, output_dir)
  compile_tilesets(source_dir + "tilesets/", output_dir)
  compile_maps(source_dir + "maps/", output_dir)
end

tiled_dir = ROOT_DIR + "src/tiled/"
target_dir = ROOT_DIR + "temp_build/"
compile_all(tiled_dir, target_dir)
