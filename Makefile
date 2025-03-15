.PHONY: all compile decompile install backup clean dist_clean

all: compile install

compile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb import
	echo "Don't forget to import the battle animations from inside the game engine"

install:
	./scripts/install_assets.sh

decompile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb export

backup: decompile
	./scripts/extract_assets.sh

clean:
	./scripts/clean_data.sh

dist_clean: clean
	./scripts/uninstall_assets.sh