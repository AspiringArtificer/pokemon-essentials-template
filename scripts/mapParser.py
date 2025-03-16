import re
import argparse
import os
from os import listdir
from os.path import isfile, join
import yaml


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
    with open(filename, 'r') as file:
        with open("test.rb", 'w') as out:
            lines = file.readlines()
            dataBlock = False
            for line in lines:
                if dataBlock:
                    if re.search(r"\],", line):
                        dataBlock = False
                        out.write(line)
                        continue
                    numArray = [int(x)
                                for x in line.split(',') if x.strip().isdigit()]
                    if numArray:
                        for x in numArray[:-1]:
                            out.write(str(max(0, x-offset)) + ",")
                        out.write(str(max(0, numArray[-1]-offset)) + ",\n")
                    else:
                        out.write("\n")

                else:
                    out.write(line)
                    # look for start of data
                    if re.search(r"data: \[", line):
                        dataBlock = True


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
        parseMapData("src/maps/Lappet Town-data.rb", 383)
        return


if __name__ == "__main__":
    main()
