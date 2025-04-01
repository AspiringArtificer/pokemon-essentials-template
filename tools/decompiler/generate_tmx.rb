require "fileutils" # needed for file operations
require "nokogiri" # needed to parse/edit xml

RUBY_DIR = __dir__ + "/"
TMS_TEMPLATE = RUBY_DIR + "map_template.tmx"

ROOT_DIR = RUBY_DIR + "../../"
require_relative ROOT_DIR + "tools/eevee/rmxp/rgss" # needed to manipulate rpg data
require_relative ROOT_DIR + "tools/eevee/src/common"  # needed to load ruby data files

TILESETS_DATA = ROOT_DIR + "src/essentials/Data/Tilesets.rxdata"
MAPINFOS = ROOT_DIR + "src/essentials/Data/MapInfos.rxdata"
EVENT_GID = 1

def setup_core_info(map, data_file, map_data, mapinfos)
  map_index = 0
  map_name = File.basename(data_file, ".rxdata")

  match = map_name.match(/^Map0*+(?<number>[0-9]++)$/)
  unless match.nil?
    map_index = match[:number].to_i
    map_name = mapinfos.fetch(map_index).name.gsub(/[^0-9A-Za-z ]/, "")
  end

  map["width"] = map_data.data.xsize
  map["height"] = map_data.data.ysize
  map["nextlayerid"] = 1

  # add custom properties
  unless map.at_xpath("properties")
    map.add_child "<properties/>"
  end

  properties = map.at_xpath("properties")
  properties.add_child "<property name=\"rpg_properties\" type=\"class\" propertytype=\"rpg_map\"/>"
  properties.at_xpath("property").add_child "<properties/>"
  rpg_properties = properties.at_xpath("property").at_xpath("properties")

  rpg_properties.add_child "<property name=\"map_index\" type=\"int\" value=\"#{map_index}\"/>"

  return map_name, map_index
end

def extract_map_properties(map_data, properties)
  # TODO add encounter_list?
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
  properties.add_child "<property name=\"mapinfo\" type=\"class\" propertytype=\"rpg_mapinfo\"/>"
  rpg_mapinfo = properties.xpath("//property")[-1]
  rpg_mapinfo.add_child "<properties/>"

  rpg_mapinfo.at_xpath("properties").add_child "<property name=\"name\" value=\"#{mapinfo.name}\"/>"
  rpg_mapinfo.at_xpath("properties").add_child "<property name=\"order\" type=\"int\" value=\"#{mapinfo.order}\"/>"
  if mapinfo.parent_id != 0
    rpg_mapinfo.at_xpath("properties").add_child "<property name=\"parent_id\" type=\"int\" value=\"#{mapinfo.parent_id}\"/>"
  end
  if mapinfo.expanded
    rpg_mapinfo.at_xpath("properties").add_child "<property name=\"expanded\" type=\"bool\" value=\"#{mapinfo.expanded}\"/>"
  end
  if mapinfo.scroll_x != 0
    rpg_mapinfo.at_xpath("properties").add_child "<property name=\"scroll_x\" type=\"int\" value=\"#{mapinfo.scroll_x}\"/>"
  end
  if mapinfo.scroll_y != 0
    rpg_mapinfo.at_xpath("properties").add_child "<property name=\"scroll_y\" type=\"int\" value=\"#{mapinfo.scroll_y}\"/>"
  end
end

def extract_tilesets(map, tileset)
  # global tileset index, used for index offset inside layers
  gid_index = 0

  #special tileset for events
  map.add_child "<tileset firstgid=\"#{EVENT_GID}\" source=\"../events/events.tsx\" />"

  # add tilesets
  until gid_index == 7
    unless tileset.autotile_names[gid_index].to_s.strip.empty?
      map.add_child "<tileset firstgid=\"#{(gid_index + 1) * 48 + 1}\" source=\"../tilesets/autotiles/#{tileset.autotile_names[gid_index]}.tsx\" />"
    else
      # needed to force tileset alignment
      map.add_child "<tileset firstgid=\"#{(gid_index + 1) * 48 + 1}\" source=\"../blank_tileset/blank_#{gid_index}.tsx\" />"
    end
    gid_index += 1
  end
  map.add_child "<tileset firstgid=\"#{(gid_index + 1) * 48 + 1}\" source=\"../tilesets/#{tileset.name.gsub(/[^0-9A-Za-z ]/, "")}.tsx\" />"
end

def extract_layers(map, map_data)

  # To play nice with Tiled, we need to align tileset gids with their size.
  # Because of this, we need to increment every nonzero tile index
  map_data.data.data = map_data.data.data.map { |x| x == 0 ? 0 : x + 1 }

  # add layers
  layer_tiles = map_data.data.xsize * map_data.data.ysize
  for level in 1..map_data.data.zsize
    layer_info = "id=\"#{map["nextlayerid"]}\" name=\"z#{level}\" width=\"#{map["width"]}\" height=\"#{map["height"]}\""
    tiles = map_data.data.data.slice((layer_tiles * (level - 1)), layer_tiles).join(",")
    map.add_child "<layer #{layer_info} > <data encoding=\"csv\"> #{tiles} </data></layer>"
    map["nextlayerid"] = map["nextlayerid"].to_i + 1
  end
end

def extract_events(map, map_data)

  # add object layer for events
  events_info = "id=\"#{map["nextlayerid"]}\" name=\"events\""
  map.add_child "<objectgroup #{events_info}>"
  map["nextlayerid"] = map["nextlayerid"].to_i + 1
  object_group = map.at_xpath("objectgroup")

  map_data.events.each do |key, event|
    # Tiled places events by pixel and uses bottom-left index, rmpx places by tile with top-left index
    obj_info = "id=\"#{event.id}\" gid=\"#{EVENT_GID}\" x=\"#{event.x * 32}\" y=\"#{(event.y + 1) * 32}\" width=\"32\" height=\"32\""
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

  # add core map details
  map_name, map_index = setup_core_info(map, data_file, map_data, mapinfos)

  rpg_properties = map.at_xpath("properties").at_xpath("property").at_xpath("properties")
  extract_map_info_properties(mapinfos[map_index], rpg_properties)
  extract_map_properties(map_data, rpg_properties)
  sorted_nodes = rpg_properties.children.sort_by { |x| x.attr("name") }
  rpg_properties.children = Nokogiri::XML::NodeSet.new(map.document, sorted_nodes)
  extract_tilesets(map, tilesets[map_data.tileset_id])
  extract_layers(map, map_data)
  extract_events(map, map_data)

  output_file = output_dir + map_name + ".tmx"
  FileUtils.mkdir_p(output_dir)
  xsl = Nokogiri::XSLT(File.open(RUBY_DIR + "indent.xsl"))
  File.write(output_file, xsl.apply_to(map_file))
end

# generate Tiled map files for all the Map data files in a directory
def generate_maps(source_dir, output_dir)
  puts "Generating maps..."
  tileset = load_rxdata(TILESETS_DATA)
  mapinfo = load_rxdata(MAPINFOS)

  data_dir = Dir.new(source_dir)
  data_dir.each_child do |data_file|
    if data_file.include? "Map" and not(data_file.include? "Infos")
      puts "Generating tmx from #{data_file}..."
      generate_tmx(source_dir + data_file, tileset, mapinfo, output_dir)
    end
  end
  puts "Finished generating maps.\n\n"
end

# generate maps for default dirs
src_data = ROOT_DIR + "src/essentials/Data/"
target_dir = ROOT_DIR + "src/tiled/maps/"
generate_maps(src_data, target_dir)
