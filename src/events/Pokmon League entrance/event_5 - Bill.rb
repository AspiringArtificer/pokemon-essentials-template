event(
  id: 5,
  name: "Bill",
  x: 19,
  y: 15,
  page_0: page(
    graphic: graphic(
      name: "NPC 25",
      direction: :left,
    ),
    commands: [
      script("pbSet(2, pbGetStorageCreator)"),
      text("\\bBill: Hello! I'm \\v[2]."),
      text("\\bI invented the Pokémon Storage System."),
      script("$player.seen_storage_creator = true"),
      label("Choices"),
      text("\\bWhat do you want to know?"),
      *show_choices(
        choices: ["Wallpapers", "Cancel"],
        cancellation: 2,
        choice1: [
          *text(
            "\\bAll storage box wallpapers need to be listed in ",
            "class PokemonStorage, in def allWallpapers.",
          ),
          *text(
            "\\bThey correspond to box_0.png, box_1.png, etc. in ",
            "order without gaps. These images are in the folder ",
            "Graphics/Pictures/Storage.",
          ),
          *text(
            "\\bStorage wallpapers are split into two categories: ",
            "basic and special.All basic wallpapers are listed ",
            "before the special wallpapers.",
          ),
          *text(
            "\\bBasic wallpapers are always accessible, and ",
            "boxes use these wallpapers by default. Numbers 0 ",
            "to 15 inclusive are basic wallpapers.",
          ),
          *text(
            "\\bSpecial wallpapers start off locked and unavailable. ",
            "You can unlock them with pbUnlockWallpaper(id), ",
            "where id is the wallpaper's number.",
          ),
          jump_label("Choices"),
        ],
      ),
    ],
  ),
)