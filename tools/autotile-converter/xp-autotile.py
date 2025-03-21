from typing import Tuple, List
from PIL import Image
import sys
import os

TILE_SIZE = 32

SUBTILE_SIZE = TILE_SIZE // 2

blob_subtile_indices = [26, 27, 4, 27, 26, 5, 4, 5, 26, 27, 4, 27,
                        32, 33, 32, 33, 32, 33, 32, 33, 32, 11, 32, 11,
                        26, 5, 4, 5, 26, 27, 4, 27, 26, 5, 4, 5,
                        32, 11, 32, 11, 10, 33, 10, 33, 10, 33, 10, 33,
                        26, 27, 4, 27, 26, 5, 4, 5, 24, 25, 24, 5,
                        10, 11, 10, 11, 10, 11, 10, 11, 30, 31, 30, 31,
                        24, 25, 24, 5, 14, 15, 14, 15, 14, 15, 14, 15,
                        30, 11, 30, 11, 20, 21, 20, 11, 10, 21, 10, 11,
                        28, 29, 28, 29, 4, 29, 4, 29, 38, 39, 4, 39,
                        34, 35, 10, 35, 34, 35, 10, 35, 44, 45, 44, 45,
                        38, 5, 4, 5, 24, 29, 14, 15, 12, 13, 12, 13,
                        44, 45, 44, 45, 30, 35, 44, 45, 18, 19, 18, 11,
                        16, 17, 16, 17, 40, 41, 4, 41, 36, 37, 36, 5,
                        22, 23, 10, 23, 46, 47, 46, 47, 42, 43, 42, 43,
                        12, 17, 12, 13, 36, 41, 16, 17, 12, 17, 0, 1,
                        18, 23, 42, 43, 42, 47, 46, 47, 42, 47, 6, 7]


def copy_tile(
        source: Image,
        target: Image,
        src_offset_px: Tuple[int, int],
        tar_offset_px: Tuple[int, int],
        size: int = TILE_SIZE
):
    subtile = source.crop(
        (src_offset_px[0], src_offset_px[1], src_offset_px[0]+size, src_offset_px[1]+size))
    subtile.save("test.png")
    target.paste(subtile, (tar_offset_px[0], tar_offset_px[1]))


def copy_subtile(
        source: Image,
        target: Image,
        src_offset_px: Tuple[int, int],
        tar_offset_px: Tuple[int, int]):
    copy_tile(source, target, src_offset_px, tar_offset_px, SUBTILE_SIZE)


def main(command: str, filepath: str):
    if command == "to_tiled":
        source = Image.open(filepath)
        px_width = 3*TILE_SIZE
        px_height = 4*TILE_SIZE
        # multi-tile
        target = Image.new('RGBA', (6*TILE_SIZE, 8*TILE_SIZE))
        if source.size[1] > 32:
            # only supports blob tile
            if source.size[0] % px_width != 0:
                print("Bad height")
                return
            source = source.crop([0, 0, px_width, px_height])
            for index, subtile in enumerate(blob_subtile_indices):
                src_index = (subtile % 6*SUBTILE_SIZE, subtile//6*SUBTILE_SIZE)
                tar_index = (index % 12*SUBTILE_SIZE, index//12*SUBTILE_SIZE)
                copy_subtile(source, target, src_index, tar_index)
        # animated single tile
        else:
            for index in range(48):
                tar_index = (index % 6*TILE_SIZE, index//6*TILE_SIZE)
                copy_tile(source, target, (0, 0), tar_index, TILE_SIZE)
        target.save("output.png")
    elif command == "to_rmxp":
        source = Image.open(filepath)
        px_width = 6*TILE_SIZE
        px_height = 8*TILE_SIZE
        # only supports blob tile
        if source.size[0] != px_width or source.size[1] != px_height:
            print("Bad size")
            return
        target = Image.new('RGBA', (3*TILE_SIZE, 4*TILE_SIZE))
        for index, subtile in enumerate(blob_subtile_indices):
            tar_index = (subtile % 6*SUBTILE_SIZE, subtile//6*SUBTILE_SIZE)
            src_index = (index % 12*SUBTILE_SIZE, index//12*SUBTILE_SIZE)
            copy_subtile(source, target, src_index, tar_index)
        target.save("output.png")
    return


if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: {} command input_file".format(sys.argv[0]))
        exit(1)
    main(sys.argv[1], sys.argv[2])
