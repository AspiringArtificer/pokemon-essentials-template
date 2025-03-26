event(
  id: 2,
  name: "Cracked ice",
  x: 26,
  y: 16,
  page_0: page(
    graphic: graphic(
      tile_id: 1320,
    ),
    through: true,
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Battle catch click")),
      control_self_switch("A", :ON),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      tile_id: 1321,
    ),
    through: true,
    trigger: :player_touch,
    commands: [
      *move_route(
        this,
        remove_graphic,
      ),
      play_se(audio(name: "Battle catch click")),
      wait(4),
      play_se(audio(name: "Battle throw")),
      change_transparent_flag(:transparent),
      wait(4),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 34, x: 20, y: 32, direction: :retain, fading: false),
      change_transparent_flag(:normal),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
      control_self_switch("A", :OFF),
    ],
  ),
)