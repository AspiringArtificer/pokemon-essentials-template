event(
  id: 13,
  name: "Dungeon ladder",
  x: 24,
  y: 14,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *comment(
        "Set which dungeon parameters are to be used for the ",
        "next dungeon map entered. These parameters are ",
        "defined in the PBS file dungeon_parameters.txt",
      ),
      *comment(
        "You can set the following:",
        "$PokemonGlobal.dungeon_area = :forest",
        "$PokemonGlobal.dungeon_version = 42",
      ),
      script("$PokemonGlobal.dungeon_area = :cave"),
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 51, x: 0, y: 0, direction: :right, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)