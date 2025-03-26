event(
  id: 9,
  name: "Trainer(1)",
  x: 11,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_FISHERMAN",
      direction: :left,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:FISHERMAN)"),
      script("pbNoticePlayer(get_self)"),
      text("\\bI'll get my tackle out for you!"),
      *condition(
        script: "TrainerBattle.start(:FISHERMAN, \"Andrew\")",
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
      name: "trainer_FISHERMAN",
      direction: :left,
    ),
    commands: [
      *text(
        "\\bI don't understand why my Magikarp couldn't beat ",
        "you.",
      ),
    ],
  ),
)