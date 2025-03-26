event(
  id: 4,
  name: "Hole",
  x: 12,
  y: 7,
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
      transfer_player(map: 50, x: 12, y: 7, direction: :retain, fading: false),
      change_transparent_flag(:normal),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)