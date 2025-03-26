require "fileutils" # needed for file operations

RUBY_DIR = __dir__ + "/"

ROOT_DIR = RUBY_DIR + "../"
require_relative ROOT_DIR + "tools/eevee/rmxp/rgss" # needed to manipulate rpg data
require_relative ROOT_DIR + "tools/eevee/src/common"  # needed to load ruby data files

MAPINFOS = ROOT_DIR + "src/essentials/Data/MapInfos.rxdata"
DEFAULT_PAGE = RPG::Event::Page.new

def generate_event_file(data_file, mapinfos, output_dir)
  map_index = 0
  map_name = File.basename(data_file, ".rxdata")
  dumper = RPGDumper.new(name: "", maps: "")

  match = map_name.match(/^Map0*+(?<number>[0-9]++)$/)
  unless match.nil?
    map_index = match[:number].to_i
    map_name = mapinfos.fetch(map_index).name.gsub(/[^0-9A-Za-z ]/, "")
  end
  output_dir = output_dir + map_name + "/"

  map_data = load_rxdata(data_file)
  map_data.events.each do |key, event|
    event_name = event.name.split(",")[0].gsub(/[^0-9A-Za-z ]/, "")
    FileUtils.mkdir_p(output_dir)
    output_file = output_dir + "event_#{key} - #{event_name}.rb"
    File.write(output_file, dumper.event(event, 0))
  end
end

# generate event page files for all the Map data files in a directory
def extract_events(source_dir, output_dir)
  puts "Extracting events..."
  mapinfo = load_rxdata(MAPINFOS)

  data_dir = Dir.new(source_dir)
  data_dir.each_child do |data_file|
    if data_file.include? "Map" and not(data_file.include? "Infos")
      puts "Extracting events from #{data_file}..."
      generate_event_file(source_dir + data_file, mapinfo, output_dir)
    end
  end
  puts "Finished extracting events.\n\n"
end

# generate maps for default dirs
src_data = ROOT_DIR + "src/essentials/Data/"
target_dir = ROOT_DIR + "src/events/"
extract_events(src_data, target_dir)
