event(
  id: 7,
  name: "Ladder down",
  x: 16,
  y: 16,
  page_0: page(
    trigger: :player_touch,
    commands: [
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 34, x: 11, y: 32, direction: :right, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)