event(
  id: 1,
  name: "Door",
  x: 6,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "doors8",
      pattern: 3,
    ),
  ),
  page_1: page(
    switch1: s(21),
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 38, x: 5, y: 12, direction: :up, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
      control_self_switch("A", :OFF),
    ],
  ),
)