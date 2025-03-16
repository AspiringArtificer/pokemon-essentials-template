import os
import yaml


def main():
    with open("tools/eevee/example/eevee.yaml") as stream:
        data = yaml.safe_load(stream)
        data['data_dir'] = "src/essentials/Data"
        del (data['ruby_dir'])
        data['yaml_dir'] = "src/yaml"
        data['backup_dir'] = "DataBackup"
        data['file_list'] = ["Actors.rxdata", "Animations.rxdata", "Armors.rxdata", "Classes.rxdata", "CommonEvents.rxdata", "Enemies.rxdata", "Items.rxdata",
                             "MapInfos.rxdata", "Map*.rxdata", "Skills.rxdata", "States.rxdata", "System.rxdata", "Tilesets.rxdata", "Troops.rxdata", "Weapons.rxdata"]
        data['import_only_list'] = []
        with open("eevee.yaml", "w") as file:
            yaml.dump(data, file)
    os.system("docker run -v " + os.getcwd() +
              ":/app eevee ruby /eevee/eevee.rb export")
    os.system("rm eevee.yaml")


if __name__ == "__main__":
    main()
