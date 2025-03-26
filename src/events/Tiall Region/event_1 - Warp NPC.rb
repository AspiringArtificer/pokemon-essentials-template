event(
  id: 1,
  name: "Warp NPC",
  x: 14,
  y: 11,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: [
      text("\\bThis is the Tiall Region."),
      text("\\bDo you want to go back to the Essen Region?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 71, x: 8, y: 5, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
        choice2: [
          text("\\bLet me know if you do."),
        ],
      ),
    ],
  ),
)