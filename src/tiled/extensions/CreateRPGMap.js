/* 	
	Adds an action to the File menu that lets you create a new map for RPG Maker.
	
	Requires Tiled 1.10.2+.
	This script saves your preferences for the dialog with your Project, using
	the "CreateRPGMap" prefix. You can opt out of saving preferences
	by setting useProject below to false.
	If no Project is open, preferences will not be saved.
*/

var createRPGMap = tiled.registerAction("CreateRPGMap", function(action) {
	// ============================= CONFIGURATION =============================
	let useProject = true; //set to false if you don't want to save your preferences to your Project.
	// =========================================================================
	
	if(!tiled.project || !tiled.versionLessThan || tiled.versionLessThan("1.10.2"))
		useProject = false;
	let project = useProject? tiled.project : null;
	
	// Get MapInfo
	let dialog = new Dialog("New RMXP Map...");
	dialog.newRowMode = Dialog.ManualRows;
	dialog.minimumWidth = 200;
	dialog.addHeading("Map Info", true);
	let nameInput = dialog.addTextInput("Name:");
	let mapName = "";
	nameInput.editingFinished.connect(function() {mapName = nameInput.text;});
	dialog.addNewRow();
	
	let mapIndexInput = dialog.addNumberInput("Map Index:");
	mapIndexInput.decimals = 0;
	mapIndexInput.minimum = 1;
	let mapIndex = 1;
	mapIndexInput.valueChanged.connect(function(number) {mapIndex = number});
	if(project && project.property("CreateRPGMap_MapIndex") > 0)
		mapIndexInput.value = project.property("CreateRPGMap_MapIndex");
	else
		mapIndexInput.value = 76;

	dialog.addHeading("Tileset", true);
	let tsetInput = dialog.addFilePicker("Tileset:");
	tsetInput.filter = "Tilesets (*.tsx)";
	dialog.addNewRow();
	dialog.addNewRow();

	// Get Map Size
	let mapWidthInput = dialog.addNumberInput("Map width:");
	mapWidthInput.decimals = 0;
	mapWidthInput.minimum = 1;
	let mapWidth = 1;
	mapWidthInput.valueChanged.connect(function(number) {mapWidth = number});
	if(project && project.property("CreateRPGMap_mapWidth") > 0)
		mapWidthInput.value = project.property("CreateRPGMap_mapWidth");
	dialog.addLabel("tiles");
	dialog.addNewRow();

	let mapHeightInput = dialog.addNumberInput("Map height:");
	mapHeightInput.decimals = 0;
	mapHeightInput.minimum = 1;
	let mapHeight = 1;
	mapHeightInput.valueChanged.connect(function(number) {mapHeight = number});
	if(project && project.property("CreateRPGMap_mapHeight") > 0)
		mapHeightInput.value = project.property("CreateRPGMap_mapHeight");
	dialog.addLabel("tiles");
	dialog.addNewRow();

	// File Save Dialog
	let confirmButton = dialog.addButton("Save As...");
	confirmButton.enabled = false;
	confirmButton.clicked.connect(function() {dialog.accept();});
	let tset = "";

	tsetInput.fileUrlChanged.connect(function(url) {
		if(!tiled.versionLessThan || tiled.versionLessThan("1.11.0"))
			tset = url.toString().replace(/^file:\/{3}/, (tiled.platform == 'windows')? '' : '/');
		else
			tset = tsetInput.fileName;
		if(!url || !File.exists(tset))
			confirmButton.enabled = false;
		else
			confirmButton.enabled = true;
	});
	let cancelButton = dialog.addButton("Cancel");
	cancelButton.clicked.connect(function() {dialog.reject();});
	let confirmed = dialog.exec();
	if(!confirmed) return;
	
	if(!mapName || mapName == "") {
		mapName = "Map" + mapIndex.toString();
	}

	//Generate Map
	let map = new TileMap();
	map.orientation = TileMap.Orthogonal;
	map.layerDataFormat = TileMap.CSV
	map.setSize(mapWidth, mapHeight);
	map.setTileSize(32, 32);

	var rpg_mapinfo = tiled.propertyValue("rpg_mapinfo", {name: mapName, order: mapIndex});
	var rpg_prop = tiled.propertyValue("rpg_map", {map_index: mapIndex, mapinfo: rpg_mapinfo});
	map.setProperty("rpg_properties", rpg_prop);

	// Add tilesets
	if(!File.exists(tset)) {
		tiled.warn("Non-existent tileset chosen: "+tset+". Map will not be created.");
		return;
	}
	tileset = tiled.open(tset);
	eset = FileInfo.path(tset) + "/../events/events.tsx";
	if(!File.exists(tset)) {
		tiled.warn("Missing events tileset: "+eset+". Map will not be created.");
		return;
	}
	events_set = tiled.open(eset);
	map.addTileset(events_set);
	tiled.close(events_set)
	// TODO add support for autotile tilesets instead of blank
	// need to be able to read custom property value
	bset_path = FileInfo.path(tset) + "/../blank_tileset/";
	for (let i = 0; i < 7; i++)
	{
		bset = bset_path + "blank_"+i.toString()+".tsx";
		if(!File.exists(bset)) {
			tiled.warn("Missing blank tileset: "+bset+". Map will not be created.");
			return;
		}
		blank_set = tiled.open(bset);
		map.addTileset(blank_set);
		tiled.close(blank_set);
	}
	map.addTileset(tileset);
	tiled.close(tileset);

	map.addLayer(new TileLayer("z1"));
	map.addLayer(new TileLayer("z2"));
	map.addLayer(new TileLayer("z3"));
	map.addLayer(new ObjectGroup("events"));

	// Prompt to save Map
	let saveLocation = tiled.promptSaveFile(FileInfo.path(tset)+"/../", "Tiled Map files (*.tmx *.xml)", "Save Map As");
	if(saveLocation && saveLocation != "") {
		let format = tiled.mapFormatForFile(saveLocation);
		if(!format) {
			tiled.warn("Could not find valid map format for"+FileInfo.fileName(saveLocation)+", saving in tmx format.");
			format = tiled.tilesetFormat("tmx");
		}
		format.write(map, saveLocation);
		//Save properties:
		if(project) {
			project.setProperty("CreateRPGMap_MapIndex", mapIndex+1);
			project.setProperty("CreateRPGMap_mapWidth", mapWidth);
			project.setProperty("CreateRPGMap_mapHeight", mapHeight);
		}
		tiled.open(saveLocation);
	} //else, the user cancelled. Do nothing.
});
createRPGMap.text = "New RPG Map...";

tiled.extendMenu("File", [
	{ action: "CreateRPGMap", before: "Save" },
	{ separator: true }
]);
