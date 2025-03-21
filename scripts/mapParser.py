import re
import argparse
import os
from os import listdir
from os.path import isfile, join
import yaml


class RMXPMapTable:
    def __init__(self):
        self.data = [[]]
        self.autotilesets = []
        self.autotiles = []
        self.x = 0
        self.y = 0
        self.z = 0

    def __init__(self, sizeVector, dataMatrix):
        self.data = [[]]
        self.autotilesets = []
        self.autotiles = []
        self.x = sizeVector[0]
        self.y = sizeVector[1]
        self.z = sizeVector[2]
        self.organizeData(dataMatrix)
        self.findAutoTiles()

    def organizeData(self, dataMatrix):
        self.data = [[]]
        zIndex = 0
        for index, row in enumerate(dataMatrix):
            if index > 0 and index % self.y == 0:
                zIndex += 1
                self.data.append([])
            self.data[zIndex].append(row)

    def findAutoTiles(self):
        for layer in self.data:
            for row in layer:
                for tile in row:
                    if 0 < tile < 383:
                        set = tile // 48
                        tile_index = tile % 48
                        if tile_index not in self.autotiles:
                            self.autotiles.append(tile_index)
                        if set not in self.autotilesets:
                            self.autotilesets.append(set)


class RMXPMap:
    def __init__(self):
        self.table = RMXPMapTable()
        self.tileset_id = 1


def getMapName(filename):
    pattern = r"\-\s\w.*\.rb"
    match = re.search(pattern, filename)
    mapName = match.group()
    mapName = re.sub(r"\.rb", "", mapName)
    mapName = re.sub(r"\-\s", "", mapName)
    return mapName


def printMapFile(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
        for line in lines:
            print(line)


def parseMapFile(filename):
    mapInfo = []
    mapEvents = []
    mapData = []
    with open(filename, 'r') as file:
        lines = file.readlines()
        eventDepth = 0
        dataDepth = 0
        for line in lines:

            # parse event lines
            if eventDepth == -1:
                mapEvents.append(line)
                if re.search(r"\[", line):
                    eventDepth = 1
                    continue
            if eventDepth > 0:
                mapEvents.append(line)
                for character in line:
                    if character == "[":
                        eventDepth += 1
                    elif character == "]":
                        eventDepth -= 1
                continue

            # parse data lines
            if dataDepth == -1:
                mapData.append(line)
                if re.search(r"\(", line):
                    dataDepth = 1
                    continue
            if dataDepth > 0:
                mapData.append(line)
                for character in line:
                    if character == "(":
                        dataDepth += 1
                    elif character == ")":
                        dataDepth -= 1
                continue

            # look for start of events
            if re.search(r"events:", line):
                mapEvents.append(line)
                if not re.search(r"\[", line):
                    eventDepth = -1
                else:
                    eventDepth = 1
                continue

            # look for start of data
            if re.search(r"data:", line):
                mapData.append(line)
                if not re.search(r"\(", line):
                    dataDepth = -1
                else:
                    dataDepth = 1
                continue

            # store other map info
            mapInfo.append(line)
    return mapInfo, mapEvents, mapData


def extractMapInfo(inputFile, outputPath):
    map = getMapName(inputFile)
    mapTuple = parseMapFile(inputFile)

    with open(outputPath+map+"-info.rb", 'w') as file:
        for line in mapTuple[0]:
            file.write(line)

    with open(outputPath+map+"-events.rb", 'w') as file:
        file.write("map(\n")
        for line in mapTuple[1]:
            file.write(line)
        file.write(")\n")

    with open(outputPath+map+"-data.rb", 'w') as file:
        file.write("map(\n")
        for line in mapTuple[2]:
            file.write(line)
        file.write(")\n")


def parseMapData(filename, offset):
    dataArray = []
    sizeVector = [0, 0, 0]
    with open(filename, 'r') as file:
        lines = file.readlines()
        dataBlock = False
        for line in lines:
            if dataBlock:
                # extract data
                if re.search(r"\],", line):
                    dataBlock = False
                    continue
                temp = [int(x)
                        for x in line.split(',') if x.strip().isdigit()]
                if temp:
                    dataArray.append(temp)
            else:
                # look for map sizes
                match = re.search(r"x: \d+,", line)
                if match:
                    sizeVector[0] = int(
                        re.search(r"\d+", match.group(0)).group(0))
                match = re.search(r"y: \d+,", line)
                if match:
                    sizeVector[1] = int(
                        re.search(r"\d+", match.group(0)).group(0))
                match = re.search(r"z: \d+,", line)
                if match:
                    sizeVector[2] = int(
                        re.search(r"\d+", match.group(0)).group(0))
                # look for start of data
                if re.search(r"data: \[", line):
                    dataBlock = True
    return RMXPMapTable(sizeVector, dataArray)


def main():
    parser = argparse.ArgumentParser(description="Process some arguments.")
    parser.add_argument("action", type=str, help="path to the eevee map files")
    parser.add_argument("-i", "--inputPath", type=str,
                        help="path to the eevee map files")
    parser.add_argument("-o", "--outputPath", type=str,
                        help="path to output the extracted info")
    args = parser.parse_args()

    if args.action == "decompile":

        if not args.inputPath:
            print("inputPath required for decompile")
            return
        if not args.outputPath:
            print("outputPath required for decompile")
            return

        print("\nDecompiling eevee map files...")
        eeveeFiles = [f for f in listdir(
            args.inputPath) if isfile(join(args.inputPath, f))]

        for file in eeveeFiles:
            if re.search(r"Map\d{3}", file):
                print("processing " + file + "...")
                extractMapInfo(args.inputPath + file, args.outputPath)
        return

    if args.action == "test":
        town = "src/maps/Lappet Town-data.rb"
        house = "src/maps/Players house-data.rb"
        at = "src/maps/AutoTile-data.rb"
        mapData = parseMapData(at, 0)
        print(mapData.x, mapData.y, mapData.z)
        print(mapData.autotilesets)
        mapData.autotiles.sort()
        print(mapData.autotiles)
        # print(mapData.data[2])
        return


if __name__ == "__main__":
    main()
