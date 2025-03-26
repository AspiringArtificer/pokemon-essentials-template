event(
  id: 1,
  name: "Exit",
  x: 23,
  y: 18,
  page_0: page(
    trigger: :player_touch,
    commands: [
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      script("pbCaveExit"),
      transfer_player(map: 31, x: 55, y: 8, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)