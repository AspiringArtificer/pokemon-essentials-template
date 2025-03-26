event(
  id: 1,
  name: "Exit",
  x: 7,
  y: 10,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *comment(
        "This command makes the fossil reviver finish reviving ",
        "a Pokémon.",
      ),
      control_switches(s(13), :OFF),
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 7, x: 35, y: 28, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)