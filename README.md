# Pokemon Essentials Template (PET) Project

## Overview
This repo was created as a place to build out a template for developing games with pokemon-essentials. Since essentials is based on the outdate RMXP project struture, it's very difficult to develop with it using modern sensibilities around version control, modularity, and encapsulation of project elements. This template aims to remedy these issues.

The project has following goals:
* Enable development with full version control of all assets
* Maintain all binary elements as de-compiled source files
* Ensure cross-platform compatibility where possible
* Use only open-source tools, ideally build from source in-situ
* Minimize or eliminate the use of RMXP

## Repo Setup
TBD

Ruby setup:
bundle config set --local path .gem
bundle install

### Submodules
src/essentials -- This points to a fork of the pokemon-essentials Github project. It contains the core scripts used by the game engine to run the game.

src/assets -- This points to a private repo containing the various assets from Pokemon Essentials v21.1 that can't be stored in the public pokemon-essentials repo

tools/eevee -- This points to a fork of the eevee Github project. This tool is used to extract rxdata files into .rb files that can be version controlled and are human readable.

## Development
TBD
