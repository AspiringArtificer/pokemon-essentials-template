event(
  id: 7,
  name: "Trainer(1)",
  x: 10,
  y: 13,
  page_0: page(
    graphic: graphic(
      name: "trainer_BEAUTY",
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:BEAUTY)"),
      script("pbNoticePlayer(get_self)"),
      text("\\rI've brought my own special backdrop!"),
      *script(
        <<~'CODE'
        setBattleRule(
          "backdrop", "champion1"
        )
        CODE
      ),
      *condition(
        script: "TrainerBattle.start(:BEAUTY, \"Bridget\")",
        then: [
          control_self_switch("A", :ON),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_BEAUTY",
    ),
    commands: [
      *text(
        "\\rIf exactly 2 trainers notice you at the same time, ",
        "they become a double battle.",
      ),
      *text(
        "\\rHere, though, 3 trainers noticed you at once, so I ",
        "battled you by myself. Then the 2 remaining trainers ",
        "noticing you at the same time became a double battle.",
      ),
      *text(
        "\\rI battled you first because my event's ID number (7) ",
        "comes before the Hiker's and Fisherman's event ID ",
        "numbers (8 and 9).",
      ),
    ],
  ),
)