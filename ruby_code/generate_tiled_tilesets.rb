require "fileutils"
require "nokogiri"
require "fastimage"

TILE_SIZE = 32

TSX_TEMPLATE = "tileset_template.tsx"

AUTOTILES_INPUT = "../src/assets/Tiled/Graphics/Autotiles/"
AUTOTILES_ASSET_DIR = "../../../assets/Tiled/Graphics/Autotiles/"
AUTOTILES_OUTPUT = "../src/tiled/tilesets/autotiles/"

TILESET_INPUT = "../src/assets/Graphics/Tilesets/"
TILESET_ASSET_DIR = "../../../src/assets/Graphics/Tilesets/"
TILESET_OUTPUT = "../src/tiled/tilesets/"

def generate_tsx(source_dir, image_rel, output_dir)
  image_dir = Dir.new(source_dir)
  image_dir.each_child do |image|
    puts "Processing #{image}..."

    tileset = Nokogiri::XML(File.open(TSX_TEMPLATE))
    px_dim = FastImage.size(source_dir + image)
    tile_dim = px_dim.map { |x| x / TILE_SIZE }

    tileset.at_xpath("tileset")["name"] = File.basename(image, ".png")
    tileset.at_xpath("tileset")["tilecount"] = tile_dim[0] * tile_dim[1]
    tileset.at_xpath("tileset")["columns"] = tile_dim[0]

    tileset.at_xpath("tileset").at_xpath("image")["source"] = image_rel + image
    tileset.at_xpath("tileset").at_xpath("image")["width"] = px_dim[0]
    tileset.at_xpath("tileset").at_xpath("image")["height"] = px_dim[1]

    FileUtils.mkdir_p(output_dir)
    File.write(output_dir + File.basename(image, ".png") + ".tsx", tileset)
  end
end

generate_tsx(TILESET_INPUT, TILESET_ASSET_DIR, TILESET_OUTPUT)
generate_tsx(AUTOTILES_INPUT, AUTOTILES_ASSET_DIR, AUTOTILES_OUTPUT)
