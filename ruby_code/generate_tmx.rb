require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml
require "nokogiri-pretty" # needed to print file with clean formatting

RUBY_DIR = __dir__ + "/"
TMS_TEMPLATE = RUBY_DIR + "map_template.tmx"

ROOT_DIR = RUBY_DIR + "../"
require_relative ROOT_DIR + "tools/eevee/rmxp/rgss" # needed to load ruby data files
require_relative ROOT_DIR + "tools/eevee/src/common"
require_relative ROOT_DIR + "tools/eevee/rmxp/rpg_dumper"

TILESETS_DATA = ROOT_DIR + "src/essentials/Data/Tilesets.rxdata"
MAPINFOS = ROOT_DIR + "src/essentials/Data/MapInfos.rxdata"

def extract_map_properties(map_data, properties)
  # eevee exporter doesn't currently support encounter_list
  if map_data.encounter_step != 30
    properties.add_child "<property name=\"encounter_step\" type=\"int\" value=\"#{map_data.encounter_step}\"/>"
  end
  properties.add_child "<property name=\"autoplay_bgm\" type=\"bool\" value=\"#{map_data.autoplay_bgm}\"/>"
  properties.add_child "<property name=\"bgm\" type=\"class\" propertytype=\"bga\">
  <properties>
   <property name=\"name\" value=\"#{map_data.bgm.name}\"/>
   <property name=\"volume\" type=\"int\" value=\"#{map_data.bgm.volume}\"/>
  </properties>
 </property>"
  properties.add_child "<property name=\"autoplay_bgs\" type=\"bool\" value=\"#{map_data.autoplay_bgs}\"/>"
  properties.add_child "<property name=\"bgs\" type=\"class\" propertytype=\"bga\">
 <properties>
  <property name=\"name\" value=\"#{map_data.bgs.name}\"/>
  <property name=\"volume\" type=\"int\" value=\"#{map_data.bgs.volume}\"/>
 </properties>
</property>"
end

def extract_map_info_properties(mapinfo, properties)
  properties.add_child "<property name=\"map_name\" value=\"#{mapinfo.name}\"/>"
  if mapinfo.parent_id != 0
    properties.add_child "<property name=\"parent_id\" type=\"int\" value=\"#{mapinfo.parent_id}\"/>"
  end
  properties.add_child "<property name=\"order\" value=\"#{mapinfo.order}\"/>"
  if mapinfo.expanded
    properties.add_child "<property name=\"expanded\" type=\"bool\" value=\"#{mapinfo.expanded}\"/>"
  end
  if mapinfo.scroll_x != 0
    properties.add_child "<property name=\"scroll_x\" type=\"int\" value=\"#{mapinfo.scroll_x}\"/>"
  end
  if mapinfo.scroll_y != 0
    properties.add_child "<property name=\"scroll_y\" type=\"int\" value=\"#{mapinfo.scroll_y}\"/>"
  end
end

def extract_events(map, map_data)
  #special tileset for events
  event_gid = 1 # using the unused id space from 1 - 47
  if map_data.events.length > 0
    map.add_child "<tileset firstgid=\"#{event_gid}\" source=\"../events/events.tsx\" />"
  end

  # add object layer for events
  events_info = "id=\"#{map["nextlayerid"]}\" name=\"events\""
  map.add_child "<objectgroup #{events_info}>"
  map["nextlayerid"] = map["nextlayerid"].to_i + 1
  object_group = map.at_xpath("objectgroup")

  map_data.events.each do |key, event|
    # Tiled places events by pixel and uses bottom-left index, rmpx places by tile with top-left index
    obj_info = "id=\"#{event.id}\" gid=\"#{event_gid}\" x=\"#{event.x * 32}\" y=\"#{(event.y + 1) * 32}\" width=\"32\" height=\"32\""
    properties = "<property name=\"name\" value=\"#{event.name}\"/>"
    object_group.add_child "<object #{obj_info}><properties>#{properties}</properties></object>"
  end
end

# generate a Tiled tmx map file based on the ruby map data files
def generate_tmx(data_file, tilesets, mapinfos, output_dir)
  # extract data
  map_data = load_rxdata(data_file)
  map_file = Nokogiri::XML(File.open(TMS_TEMPLATE))
  map = map_file.root
  id = map_data.tileset_id
  map_index = 0
  map_name = File.basename(data_file, ".rxdata")

  match = map_name.match(/^Map0*+(?<number>[0-9]++)$/)
  unless match.nil?
    map_index = match[:number].to_i
    map_name = mapinfos.fetch(map_index).name.gsub(/[^0-9A-Za-z ]/, "")
  end

  # add core map details
  map["width"] = map_data.data.xsize
  map["height"] = map_data.data.ysize
  map["nextlayerid"] = 1

  # add custom properties
  unless map.at_xpath("properties")
    map.add_child "<properties/>"
  end
  properties = map.at_xpath("properties")
  properties.add_child "<property name=\"map_index\" type=\"int\" value=\"#{map_index}\"/>"
  properties.add_child "<property name=\"full_tileset_name\" value=\"#{tilesets[id].name}\"/>"
  extract_map_info_properties(mapinfos[map_index], properties)
  extract_map_properties(map_data, properties)

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

  extract_events(map, map_data)

  # puts map_file.human
  output_file = output_dir + map_name + ".tmx"
  FileUtils.mkdir_p(output_dir)
  File.write(output_file, map_file.human)
end

# generate Tiled map files for all the Map data files in a directory
def generate_maps(source_dir, output_dir)
  tileset = load_rxdata(TILESETS_DATA)
  mapinfo = load_rxdata(MAPINFOS)
  # FileUtils doesn't properly handle relative paths
  # source_dir = File.expand_path(source_dir) + "/"
  # output_dir = File.expand_path(output_dir) + "/"

  data_dir = Dir.new(source_dir)
  data_dir.each_child do |data_file|
    if data_file.include? "Map" and not(data_file.include? "Infos")
      puts "Processing #{data_file}..."
      generate_tmx(source_dir + data_file, tileset, mapinfo, output_dir)
    end
  end
end

# generate maps for default dirs
src_data = ROOT_DIR + "src/essentials/Data/"
target_dir = ROOT_DIR + "src/tiled/maps/"
generate_maps(src_data, target_dir)
