event(
  id: 5,
  name: "Trainer(3)",
  x: 22,
  y: 17,
  page_0: page(
    graphic: graphic(
      name: "trainer_SWIMMER2_F",
      direction: :right,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:SWIMMER2_F)"),
      script("pbNoticePlayer(get_self)"),
      *text(
        "\\rI'm a swimming trainer, just like any other",
        "trainer!",
      ),
      *condition(
        script: "TrainerBattle.start(:SWIMMER2_F, \"Ariel\")",
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
      name: "trainer_SWIMMER2_F",
      direction: :right,
    ),
    commands: [
      *text(
        "\\rJust make sure swimming trainers don't",
        "try to swim over land to get to the player when they",
        "spot them.",
      ),
    ],
  ),
)