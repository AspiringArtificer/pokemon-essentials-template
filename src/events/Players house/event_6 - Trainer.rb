event(
  id: 6,
  name: "Trainer, Visual Editor, Terrain Tags",
  x: 29,
  y: 1,
  page_0: page(
    commands: [
      label("Start"),
      text("Choose a topic."),
      *show_choices(
        choices: ["About the trainer", "Map connections", "Terrain Tags", "Cancel"],
        cancellation: 4,
        choice1: [
          *text(
            "The $player global variable contains information ",
            "about the player, such as their trainer type, ID ",
            "number, name, party Pokémon and money.",
          ),
          text("This information is in class Player."),
          jump_label("Start"),
        ],
        choice2: [
          *text(
            "Map connections are how two maps are displayed ",
            "next to each other in the overworld, allowing you to ",
            "walk from one to the other.",
          ),
          *text(
            "The connections are defined in the PBS file ",
            "\"map_connections.txt\". There is a Debug feature that ",
            "makes connecting maps easier.",
          ),
          *text(
            "In the Debug menu, go to \"PBS File Editors...\" > ",
            "\"Edit map_connections.txt\". Instructions are available ",
            "within. You can move maps around with the mouse.",
          ),
          jump_label("Start"),
        ],
        choice3: [
          *text(
            "Every tile in a tileset has a terrain tag, which is a ",
            "number. This number is used to give certain tiles ",
            "special effects.",
          ),
          *text(
            "For example, ledge tiles have terrain tag 1, which ",
            "means the player jumps over them. Ledge tiles also ",
            "have a single passable direction (set separately).",
          ),
          *text(
            "Grass tiles (in which you can have wild encounters) ",
            "have terrain tag 2. Water tiles have terrain tag 6 or 7.",
          ),
          *text(
            "Terrain tag 0 means the tile has no special effect. ",
            "See the wiki for more information and a complete list ",
            "of all terrain tags and their effects.",
          ),
          *text(
            "You can only set terrain tags up to 7 via RPG Maker ",
            "XP's Database. Essentials has terrain tags with ",
            "higher numbers.",
          ),
          *text(
            "To fully set a tileset's terrain tags, open the Debug ",
            "menu and go to \"Other Editors...\" > \"Edit Terrain ",
            "Tags\".",
          ),
          jump_label("Start"),
        ],
      ),
    ],
  ),
)