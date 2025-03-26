event(
  id: 7,
  name: "Gift egg",
  x: 7,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "trainer_GENTLEMAN",
    ),
    commands: [
      text("\\bOh, hi!"),
      text("\\bWould you like this Pokémon Egg?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *comment(
            "pbGenerateEgg can only add an egg to the player's ",
            "party, so a space is required.",
          ),
          *condition(
            script: "pbGenerateEgg(:TOGEPI, _I(\"Fan Club President\"))",
            then: [
              *text(
                "\\me[Egg get]\\PN received the Egg from the Fan Club ",
                "President.",
              ),
              text("\\bTake good care of it!"),
              control_self_switch("A", :ON),
            ],
            else: [
              text("\\bOh, you can't carry it with you."),
              text("\\bMake some space in your party and come back."),
            ],
          ),
        ],
        choice2: [
          text("\\bOh. Will I ever find someone to take this Egg?"),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_GENTLEMAN",
    ),
    commands: [
      text("\\bI wonder what that Egg will hatch into?"),
    ],
  ),
)