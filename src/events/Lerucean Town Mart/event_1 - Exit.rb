event(
  id: 1,
  name: "Exit",
  x: 4,
  y: 8,
  page_0: page(
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 23, x: 16, y: 14, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)