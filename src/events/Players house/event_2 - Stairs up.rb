event(
  id: 2,
  name: "Stairs up",
  x: 10,
  y: 2,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *move_route(
        player,
        through_on,
        always_on_top_on,
        turn_right,
        move_upper_right,
        through_off,
        always_on_top_off,
      ),
      wait_completion,
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 3, x: 29, y: 2, direction: :retain, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)