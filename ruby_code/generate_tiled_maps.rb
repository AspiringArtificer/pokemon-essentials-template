require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml
require "nokogiri-pretty" # needed to print file with clean formatting

require_relative "../tools/eevee/rmxp/rgss" # needed to load ruby data files

RUBY_DIR = File.expand_path(File.dirname(__FILE__)) + "/"
TMS_TEMPLATE = RUBY_DIR + "map_template.tmx"

ROOT_DIR = RUBY_DIR + "../"
TILESETS_DATA = ROOT_DIR + "src/data/Tilesets.rb"
MAPINFOS = ROOT_DIR + "src/data/MapInfos.Local.rb"

# load a ruby file exported from rxdata by eevee
def load_ruby(export_file)
  return (RPGFactory.new).evaluate(File.read(export_file))
end

# generate a Tiled tmx map file based on the ruby map data files
def generate_tmx(data_file, tilesets, mapinfos, output_dir)
  # extract data
  map_data = load_ruby(data_file)
  map_file = Nokogiri::XML(File.open(TMS_TEMPLATE))
  map = map_file.root
  id = map_data.tileset_id
  map_index = (File.basename(data_file, ".rb").split("-")[0].split("Map")[1]).rstrip.to_i
  map_name = (File.basename(data_file, ".rb").split("-")[1]).lstrip

  # add core map details
  map["width"] = map_data.data.xsize
  map["height"] = map_data.data.ysize
  map["nextlayerid"] = 1

  # add custom properties
  unless map.at_xpath("properties")
    map.add_child "<properties/>"
  end
  properties = map.at_xpath("properties")
  properties.add_child "<property name=\"full_tileset_name\" value=\"#{tilesets[id].name}\"/>"
  properties.add_child "<property name=\"map_name\" value=\"#{mapinfos[map_index].name}\"/>"
  properties.add_child "<property name=\"map_index\" value=\"#{map_index}\"/>"
  if mapinfos[map_index].parent_id != 0
    properties.add_child "<property name=\"parent_id\" value=\"#{mapinfos[map_index].parent_id}\"/>"
  end
  properties.add_child "<property name=\"order\" value=\"#{mapinfos[map_index].order}\"/>"
  if mapinfos[map_index].expanded
    properties.add_child "<property name=\"expanded\" value=\"#{mapinfos[map_index].expanded}\"/>"
  end
  if mapinfos[map_index].scroll_x != 0
    properties.add_child "<property name=\"scroll_x\" value=\"#{mapinfos[map_index].scroll_x}\"/>"
  end
  if mapinfos[map_index].scroll_y != 0
    properties.add_child "<property name=\"scroll_y\" value=\"#{mapinfos[map_index].scroll_y}\"/>"
  end

  # global tileset index, used for index offset inside layers
  gid_index = 0

  # add tilesets
  until gid_index == 7
    unless tilesets[id].autotile_names[gid_index].to_s.strip.empty?
      map.add_child "<tileset firstgid=\"#{(gid_index + 1) * 48}\" source=\"../tilesets/autotiles/#{tilesets[id].autotile_names[gid_index]}.tsx\" />"
    end
    gid_index += 1
  end
  map.add_child "<tileset firstgid=\"#{(gid_index + 1) * 48}\" source=\"../tilesets/#{tilesets[id].tileset_name}.tsx\" />"

  # add layers
  layer_tiles = map_data.data.xsize * map_data.data.ysize
  for level in 1..map_data.data.zsize
    layer_info = "id=\"#{map["nextlayerid"]}\" name=\"z#{level}\" width=\"#{map["width"]}\" height=\"#{map["height"]}\""
    data_base = "<data encoding=\"csv\">"
    # gather tile data
    tiles = ""
    for index in (layer_tiles * (level - 1))..(layer_tiles * level - 2)
      tiles += map_data.data.data[index].to_s + ","
    end
    tiles += map_data.data.data[layer_tiles * level - 1].to_s
    map.add_child "<layer #{layer_info} > #{data_base} #{tiles} </data></layer>"
    map["nextlayerid"] = map["nextlayerid"].to_i + 1
  end

  # puts map_file.human
  output_file = output_dir + map_name + ".tmx"
  FileUtils.mkdir_p(output_dir)
  File.write(output_file, map_file.human)
end

# generate Tiled map files for all the Map data files in a directory
def generate_maps(source_dir, output_dir)
  tileset = load_ruby(TILESETS_DATA)
  mapinfo = load_ruby(MAPINFOS)
  # FileUtils doesn't properly handle relative paths
  # source_dir = File.expand_path(source_dir) + "/"
  # output_dir = File.expand_path(output_dir) + "/"

  data_dir = Dir.new(source_dir)
  data_dir.each_child do |data_file|
    if data_file.include? "Map" and data_file.include? "-"
      puts "Processing #{data_file}..."
      generate_tmx(source_dir + data_file, tileset, mapinfo, output_dir)
    end
  end
end

#generate maps for default dirs
src_data = ROOT_DIR + "src/data/"
target_dir = ROOT_DIR + "src/tiled/maps/"
generate_maps(src_data, target_dir)
