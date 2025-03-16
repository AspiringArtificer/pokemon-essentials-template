.PHONY: all compile decompile install backup clean dist_clean

all: compile install

compile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb import
# @echo '\033[1;33m' "Don't forget to import the battle animations from inside the game engine."
# battle animation importer is busted

install:
	./scripts/install_assets.sh

decompile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb export
	python scripts/mapParser.py decompile -i "src/data/" -o "src/maps/"

backup: decompile
	./scripts/extract_assets.sh

clean:
	./scripts/clean_data.sh

dist_clean: clean
	./scripts/uninstall_assets.sh