.PHONY: all compile decompile install backup clean dist_clean

all: compile install

compile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb import
	echo "Don't forget to import the battle animations from inside the game engine"

decompile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb export

install:
	./scripts/install_assets.sh

backup:
	./scripts/extract_assets.sh

clean:
	./scripts/clean_data.sh

dist_clean: clean
	pushd ${PWD}/src/essentials
	ls
	popd