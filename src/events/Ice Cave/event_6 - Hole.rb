event(
  id: 6,
  name: "Hole",
  x: 22,
  y: 14,
  page_0: page(
    through: true,
    trigger: :player_touch,
    commands: [
      wait(4),
      play_se(audio(name: "Player fall", volume: 80)),
      change_transparent_flag(:transparent),
      wait(4),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 34, x: 16, y: 30, direction: :retain, fading: false),
      change_transparent_flag(:normal),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)