event(
  id: 4,
  name: "NPC",
  x: 21,
  y: 12,
  page_0: page(
    graphic: graphic(
      name: "trainer_GENTLEMAN",
      direction: :left,
    ),
    commands: [
      text("\\bHello! I'm the Ruin Maniac!"),
      text("\\bDo you want to dig for buried treasure?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\bGrand! Let's dig into this wall."),
          *condition(
            character: player,
            facing: :right,
            then: [
              *move_route(
                player,
                move_down,
                move_right,
              ),
              *move_route(
                this,
                turn_down,
              ),
              wait_completion,
            ],
            else: [
              *move_route(
                player,
                turn_right,
              ),
              wait_completion,
            ],
          ),
          script("pbMiningGame"),
        ],
        choice2: [
          text("\\bNo? Alright then."),
        ],
      ),
      *text(
        "\\bWhen using this mining minigame, it is ",
        "recommended that you limit how often the player can ",
        "play it, to prevent them gaining lots of items for free.",
      ),
    ],
  ),
)