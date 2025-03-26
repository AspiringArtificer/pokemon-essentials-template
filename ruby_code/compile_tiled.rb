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
  puts "Compiling Tilesets..."
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
  # save_ruby(output_dir + "Tilesets.rb", tilesets)
  puts "Saving " + output_dir + "Tilesets.rxdata..."
  save_rxdata(output_dir + "Tilesets.rxdata", tilesets)
  puts "Tilesets compilation complete.\n\n"
end

def get_maps_and_info(source_dir, events_dir)
  files = Dir.foreach(source_dir).select { |x| File.file?("#{source_dir}/#{x}") }

  maps = []
  mapinfos = {}
  for file in files
    if File.extname(file) == ".tmx"
      map, mapinfo, map_index = convert_tmx_to_map_data(source_dir + file, events_dir + File.basename(file, ".tmx") + "/")
      maps.append(map)
      mapinfos[map_index] = mapinfo
    end
  end

  return maps, mapinfos
end

def generate_mapinfo(tmx)
  mapinfo = RPG::MapInfo.new

  mapinfo_properties = tmx.xpath("//property").detect { |x| x["name"] == "mapinfo" }.at_xpath("properties").children

  mapinfo.name = (mapinfo_properties.detect { |x| x["name"] == "name" })["value"]
  mapinfo.order = (mapinfo_properties.detect { |x| x["name"] == "order" })["value"].to_i
  parent_id = mapinfo_properties.detect { |x| x["name"] == "parent_id" }
  if parent_id
    mapinfo.parent_id = parent_id["value"].to_i
  end
  expanded = mapinfo_properties.detect { |x| x["name"] == "expanded" }
  if expanded
    mapinfo.expanded = expanded["value"] == "true"
  end
  scroll_x = mapinfo_properties.detect { |x| x["name"] == "scroll_x" }
  if scroll_x
    mapinfo.scroll_x = scroll_x["value"].to_i
  end
  scroll_y = mapinfo_properties.detect { |x| x["name"] == "scroll_y" }
  if scroll_y
    mapinfo.scroll_y = scroll_y["value"].to_i
  end
  return mapinfo
end

def generate_map_table(tmx, width, height)
  layers = tmx.xpath("//layer")

  map_table = Table.new(width, height, layers.length())

  data = []
  for layer in layers
    tiles = layer.at_xpath("data").text.split(",").map(&:to_i)
    data.push(*(tiles.map { |x| x == 0 ? 0 : x - 1 }))
  end

  map_table.data = data

  return map_table
end

def generate_map_events(tmx, events_dir)
  events_hash = {}
  tmx_events_array = tmx.xpath("//objectgroup").detect { |x| x["name"] == "events" }.children

  if File.directory?(events_dir)
    files = Dir.foreach(events_dir).select { |x| File.file?("#{events_dir}/#{x}") }
    for file in files
      event = load_ruby(events_dir + file)

      tmx_event = tmx_events_array.detect { |x| x["id"].to_i == event.id }
      unless tmx_event
        mapinfo_properties = tmx.xpath("//property").detect { |x| x["name"] == "mapinfo" }.at_xpath("properties").children
        map_name = (mapinfo_properties.detect { |x| x["name"] == "name" })["value"]
        raise IndexError.new "#{map_name} doesn't contain event id=#{event.id}"
      end

      # tmx coordinates take precedence
      event.x = tmx_event["x"].to_i / 32
      event.y = (tmx_event["y"].to_i / 32) - 1
      tmx_event_name = tmx_event.at_xpath("properties").children.detect { |x| x["name"] == "name" }["value"]
      # names affect event functionality so keep the rb one, but put a warning on mismatch
      if event.name != tmx_event_name
        puts "Warning: event names don't match, tmx=#{tmx_event_name}, rb=#{event.name}"
      end

      events_hash[event.id] = event
    end
  end

  return events_hash
end

def convert_tmx_to_map_data(tmx_path, events_dir)
  tmx = Nokogiri::XML(File.open(tmx_path)).root
  map = RPG::Map.new(tmx["width"].to_i, tmx["height"].to_i)
  map_folder = File.dirname(tmx_path) + "/"

  tileset_file = map_folder + tmx.xpath("//tileset")[-1]["source"]
  tsx = Nokogiri::XML(File.open(tileset_file)).root

  map.tileset_id = tsx.xpath("//property").detect { |x| x["name"] == "id" }["value"].to_i
  map.autoplay_bgm = tmx.xpath("//property").detect { |x| x["name"] == "autoplay_bgm" }["value"] == "true"
  map.autoplay_bgs = tmx.xpath("//property").detect { |x| x["name"] == "autoplay_bgs" }["value"] == "true"
  # TODO add encounter_list?
  encounter_step = tmx.xpath("//property").detect { |x| x["name"] == "encounter_step" }
  if encounter_step
    map.encounter_step = encounter_step["value"].to_i
  end

  bgm_object = tsx.xpath("//property").detect { |x| x["name"] == "bgm" }
  if bgm_object
    bgm_properties = bgm_object.at_xpath("properties").children
    bgm_name = bgm_properties.detect { |x| x["name"] == "name" }
    if bgm_name
      map.bgm.name = bgm_name["value"]
    end
    bgm_volume = bgm_properties.detect { |x| x["name"] == "volume" }
    if bgm_volume
      map.bgm.volume = bgm_volume["value"].to_i
    end
    bgm_pitch = bgm_properties.detect { |x| x["name"] == "pitch" }
    if bgm_pitch
      map.bgm.pitch = bgm_pitch["value"].to_i
    end
  end

  bgs_object = tsx.xpath("//property").detect { |x| x["name"] == "bgs" }
  if bgs_object
    bgs_properties = bgs_object.at_xpath("properties").children
    bgs_name = bgs_properties.detect { |x| x["name"] == "name" }
    if bgs_name
      map.bgs.name = bgs_name["value"]
    end
    bgs_volume = bgs_properties.detect { |x| x["name"] == "volume" }
    if bgs_volume
      map.bgs.volume = bgs_volume["value"].to_i
    end
    bgs_pitch = bgs_properties.detect { |x| x["name"] == "pitch" }
    if bgs_pitch
      map.bgs.pitch = bgs_pitch["value"].to_i
    end
  end

  map.data = generate_map_table(tmx, map.width, map.height)
  map.events = generate_map_events(tmx, events_dir)

  tmx_map_index = tmx.xpath("//property").detect { |x| x["name"] == "map_index" }
  unless tmx_map_index
    raise IndexError.new "#{File.basename(tmx)} doesn't contain a map_index!"
  end
  map_index = tmx_map_index["value"].to_i

  return map, generate_mapinfo(tmx), map_index
end

def compile_maps(maps_dir, events_dir, output_dir)
  puts "Compiling Maps..."
  maps, mapinfos = get_maps_and_info(maps_dir, events_dir)

  FileUtils.mkdir_p(output_dir)
  puts "Saving " + output_dir + "MapInfos.rxdata..."
  # save_ruby(output_dir + "MapInfos.rb", mapinfos.sort.to_h)
  save_rxdata(output_dir + "MapInfos.rxdata", mapinfos.sort.to_h)

  maps.each_with_index do |map, index|
    map_index = mapinfos.keys[index]
    puts "Saving #{mapinfos.values[index].name} to #{output_dir}Map#{map_index.to_s.rjust(3, "0")}.rxdata..."
    # save_ruby(output_dir + "Map#{map_index.to_s.rjust(3, "0")}.rb", map, name: "Map#{map_index.to_s.rjust(3, "0")}.rb", maps: mapinfos)
    save_rxdata(output_dir + "Map#{map_index.to_s.rjust(3, "0")}.rxdata", map)
  end
  puts "Maps compilation complete.\n\n"
end

def compile_all(tiled_dir, events_dir, output_dir)
  compile_tilesets(tiled_dir + "tilesets/", output_dir)
  compile_maps(tiled_dir + "maps/", events_dir, output_dir)
end

tiled_dir = ROOT_DIR + "src/tiled/"
events_dir = ROOT_DIR + "src/events/"
target_dir = ROOT_DIR + "src/essentials/Data/"
compile_all(tiled_dir, events_dir, target_dir)
