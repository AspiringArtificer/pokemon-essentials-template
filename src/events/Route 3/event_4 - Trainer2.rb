event(
  id: 4,
  name: "Trainer(2)",
  x: 5,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_YOUNGSTER",
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:YOUNGSTER)"),
      script("pbNoticePlayer(get_self)"),
      text("\\bHi! I like shorts! They're comfy and easy to wear!"),
      *condition(
        script: "TrainerBattle.start(:YOUNGSTER, \"Ben\")",
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
      name: "trainer_YOUNGSTER",
    ),
    commands: [
      text("\\bYou can't get a trainer event simpler than me!"),
    ],
  ),
)