event(
  id: 10,
  name: "Warp tile 1",
  x: 1,
  y: 3,
  page_0: page(
    graphic: graphic(
      tile_id: 1103,
    ),
    trigger: :player_touch,
    commands: [
      text("Choose a destination."),
      *show_choices(
        choices: ["Poké Center", "Poké Mart", "Pokémon Gym", "Day Care"],
        cancellation: 0,
        choice1: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 9, x: 7, y: 8, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice2: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 25, x: 4, y: 7, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice3: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 10, x: 6, y: 14, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice4: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 27, x: 4, y: 7, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
      *show_choices(
        choices: ["Cave", "Safari Zone", "Bug Catching Contest", "Battle Frontier"],
        cancellation: 0,
        choice1: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 49, x: 12, y: 14, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice2: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 67, x: 4, y: 7, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice3: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 29, x: 1, y: 5, direction: :right, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice4: [
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 52, x: 18, y: 16, direction: :down, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
      *show_choices(
        choices: ["Cancel"],
        cancellation: 1,
      ),
    ],
  ),
)