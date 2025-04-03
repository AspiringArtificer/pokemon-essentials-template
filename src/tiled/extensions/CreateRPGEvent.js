var tool = tiled.registerTool("CreateRPGEvent", {
    name: "Place RPG Event",
    icon: "CreateRPGEvent.png",

    targetLayerType: Layer.ObjectGroupType,

    mousePressed: function (button, x, y, modifiers) {
        if (button == 1) {
            this.pressed = true;
            this.x = this.tilePosition.x * this.map.tileWidth;
            this.y = (this.tilePosition.y + 1) * this.map.tileHeight;
            this.counter = 0;
        }
    },

    mouseReleased: function (button, x, y, modifiers) {
        let useProject = true;
        if (!tiled.project || !tiled.versionLessThan || tiled.versionLessThan("1.10.2"))
            useProject = false;
        let project = useProject ? tiled.project : null;

        if (!project) {
            tiled.alert("This extension needs to be run in a project!");
            this.enabled = false;
            return;
        }

        if (button == 1 && this.pressed) {
            this.pressed = false;

            // Find Events tileset
            var events = null;
            this.map.tilesets.forEach(function (tileset) {
                // pick the events tileset
                if (tileset.name == "events") {
                    events = tileset;
                    return;
                }
            });
            if (!events) {
                tiled.alert("Event tileset not found for map!");
                this.enabled = false;
                return;
            }

            // Get current Object Layer
            var objectLayer = this.map.currentLayer;
            if (objectLayer && objectLayer.isObjectLayer) {
                // Create new object
                var object = new MapObject(MapObject.Rectangle, "");
                object.x = this.x;
                object.y = this.y;
                object.width = 32;
                object.height = 32;
                object.tile = events.findTile(0);

                // Get Event Info
                let dialog = new Dialog("New RMXP Event...");
                dialog.newRowMode = Dialog.ManualRows;
                dialog.minimumWidth = 200;
                dialog.addHeading("Event Info", true);
                let nameInput = dialog.addTextInput("Name:");
                let eventName = "";
                nameInput.editingFinished.connect(function () { eventName = nameInput.text; });
                dialog.addNewRow();

                // File Save Dialog
                let confirmButton = dialog.addButton("Save");
                confirmButton.enabled = true;
                confirmButton.clicked.connect(function () {
                    if (eventName == "")
                        return;
                    else
                        dialog.accept();
                });

                let cancelButton = dialog.addButton("Cancel");
                cancelButton.clicked.connect(function () { dialog.reject(); });
                let confirmed = dialog.exec();
                if (!confirmed) return;

                // Apply Event Info and add object to layer
                object.setProperty("name", eventName);
                objectLayer.addObject(object);

                // Prompt to save event code
                let eventPath = FileInfo.path(this.map.fileName) + "/";
                if (project.property("CreateRPGMap_eventPath")) {
                    let path = project.property("CreateRPGMap_eventPath");
                    path = FileInfo.joinPaths(FileInfo.path(project.fileName) + "/../../", path);
                    path = FileInfo.cleanPath(path);
                    eventPath = path + "/";
                }
                else {
                    let path = FileInfo.path(project.fileName) + "/../";
                    path = FileInfo.cleanPath(path);
                    eventPath = path + "/";
                }

                let defaultPath = eventPath + "event_" + object.id.toString() + " - " + FileInfo.baseName(this.map.fileName) + ".rb";
                let saveLocation = tiled.promptSaveFile(defaultPath, "Ruby file (*.rb)", "Save Event As");
                if (saveLocation && saveLocation != "") {
                    // Generate the File
                    try {
                        // Tiled can't write txt file directly so using scripts
                        script_path = FileInfo.toNativeSeparators(project.extensionsPath)
                        if (tiled.platform == 'windows'){
                            script_path += "\\CreateEventSource.bat";
                        }
                        else {
                            script_path += "/CreateEventSource.sh";
                        }
                        eventProcess = new Process();
                        eventProcess.workingDirectory = FileInfo.toNativeSeparators(FileInfo.path(saveLocation));
                        sourcePath = FileInfo.baseName(saveLocation) + ".rb"
                        script_args = [sourcePath, object.id.toString(), eventName, (object.x / 32).toString(), ((object.y / 32) - 1).toString()]
                        eventProcess.exec(script_path, script_args);
                    } catch (error) {
                        tiled.warn("Error saving event source: " + error.message);
                        objectLayer.removeObject(object);
                        return;
                    }

                    tiled.log("Event saved to " + saveLocation);

                    //Save properties:
                    let rootPath = FileInfo.cleanPath(FileInfo.path(project.fileName) + "/../../");
                    eventPath = FileInfo.relativePath(rootPath, FileInfo.path(saveLocation)) + "/";
                    project.setProperty("CreateRPGMap_eventPath", eventPath);

                    object.setProperty("source_path", eventPath + FileInfo.baseName(saveLocation) + ".rb");
                }
                else {
                    objectLayer.removeObject(object);
                }
            }
        }
    },
})