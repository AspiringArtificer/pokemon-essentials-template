event(
  id: 1,
  name: "Exit south",
  x: 12,
  y: 15,
  page_0: page(
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      script("pbCaveExit"),
      transfer_player(map: 47, x: 46, y: 11, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)