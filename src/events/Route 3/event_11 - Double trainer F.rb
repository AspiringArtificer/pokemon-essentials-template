event(
  id: 11,
  name: "Double trainer F",
  x: 14,
  y: 13,
  page_0: page(
    graphic: graphic(
      name: "trainer_COOLTRAINER_F",
    ),
    commands: [
      *condition(
        script: "!pbCanDoubleBattle?",
        then: [
          *text(
            "\\rYou'll need at least two Pokémon or a partner if you ",
            "want to battle us.",
          ),
          exit_event_processing,
        ],
      ),
      script("pbTrainerIntro(:COOLCOUPLE)"),
      text("\\rAh, looks like a challenging trainer. Ready, Bob?"),
      script("setBattleRule(\"double\")"),
      *condition(
        script: "TrainerBattle.start(:COOLCOUPLE, \"Alice & Bob\")",
        then: [
          control_self_switch("A", :ON),
          comment("Set the partner event's Self Switch \"A\" on."),
          script("pbSetSelfSwitch(12, \"A\", true)"),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_COOLTRAINER_F",
    ),
    commands: [
      *text(
        "\\rOur events weren't created by comments, ",
        "because we need to check how many Pokémon you ",
        "had.",
      ),
    ],
  ),
)