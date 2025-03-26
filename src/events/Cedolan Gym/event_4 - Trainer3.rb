event(
  id: 4,
  name: "Trainer(3)",
  x: 3,
  y: 8,
  page_0: page(
    graphic: graphic(
      name: "trainer_CAMPER",
      direction: :right,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:CAMPER)"),
      script("pbNoticePlayer(get_self)"),
      text("\\bBattle me now!"),
      *condition(
        script: "TrainerBattle.start(:CAMPER, \"Liam\")",
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
      name: "trainer_CAMPER",
      direction: :right,
    ),
    commands: [
      *text(
        "\\bYou're pretty hot. But not as hot as",
        "Brock!",
      ),
    ],
  ),
  page_2: page(
    switch1: s(4),
    graphic: graphic(
      name: "trainer_CAMPER",
      direction: :right,
    ),
    commands: [
      *text(
        "\\bYou're pretty hot. But not as hot as",
        "Brock!",
      ),
    ],
  ),
)