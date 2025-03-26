event(
  id: 8,
  name: "Ladder up",
  x: 10,
  y: 32,
  page_0: page(
    trigger: :player_touch,
    commands: [
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 34, x: 17, y: 16, direction: :right, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)