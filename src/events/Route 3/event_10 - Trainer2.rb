event(
  id: 10,
  name: "Trainer(2)",
  x: 13,
  y: 17,
  page_0: page(
    graphic: graphic(
      name: "trainer_LASS",
      direction: :up,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:LASS)"),
      script("pbNoticePlayer(get_self)"),
      text("\\rGet ready for a double battle!"),
      script("setBattleRule(\"double\")"),
      *condition(
        script: "TrainerBattle.start(:LASS, \"Crissy\")",
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
      name: "trainer_LASS",
      direction: :up,
    ),
    commands: [
      *text(
        "\\rMake sure all double battle opponents have at least ",
        "2 Pokémon!",
      ),
    ],
  ),
)