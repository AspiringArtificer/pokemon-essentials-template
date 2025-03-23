.PHONY: all setup compile decompile install backup clean dist_clean

all: compile install

setup:
	bundle config set --local path './.gem'
	bundle install

compile:
	docker run -v ${PWD}:/app eevee ruby /eevee/eevee.rb import
# @echo '\033[1;33m' "Don't forget to import the battle animations from inside the game engine."
# battle animation importer is busted

install:
	./scripts/install_assets.sh

decompile:
	./scripts/convert_autotiles.sh
	bundle exec ruby tools/eevee/eevee.rb export
	bundle exec ruby ruby_code/extract_events.rb
	bundle exec ruby ruby_code/generate_tsx.rb
	bundle exec ruby ruby_code/generate_tmx.rb

backup: decompile
	./scripts/extract_assets.sh

clean:
	./scripts/clean_data.sh

dist_clean: clean
	./scripts/uninstall_assets.sh