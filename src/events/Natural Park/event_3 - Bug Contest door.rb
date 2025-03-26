event(
  id: 3,
  name: "Bug Contest door",
  x: 7,
  y: 24,
  page_0: page(
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 29, x: 11, y: 5, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)