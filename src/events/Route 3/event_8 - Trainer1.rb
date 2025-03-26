event(
  id: 8,
  name: "Trainer(1)",
  x: 9,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_HIKER",
      direction: :right,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:HIKER)"),
      script("pbNoticePlayer(get_self)"),
      text("\\bThis battle will go without a hitch!"),
      *condition(
        script: "TrainerBattle.start(:HIKER, \"Ford\")",
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
      name: "trainer_HIKER",
      direction: :right,
    ),
    commands: [
      text("\\bHow did you manage to face all three of us?"),
    ],
  ),
)