event(
  id: 12,
  name: "Double trainer M",
  x: 15,
  y: 13,
  page_0: page(
    graphic: graphic(
      name: "trainer_COOLTRAINER_M",
    ),
    commands: [
      *condition(
        script: "!pbCanDoubleBattle?",
        then: [
          *text(
            "\\bYou'll need at least two Pokémon or a partner if you ",
            "want to battle us.",
          ),
          exit_event_processing,
        ],
      ),
      script("pbTrainerIntro(:COOLCOUPLE)"),
      text("\\bAh, looks like a challenging trainer. Ready, Alice?"),
      script("setBattleRule(\"double\")"),
      *condition(
        script: "TrainerBattle.start(:COOLCOUPLE, \"Alice & Bob\")",
        then: [
          control_self_switch("A", :ON),
          comment("Set the partner event's Self Switch \"A\" on."),
          script("pbSetSelfSwitch(11, \"A\", true)"),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_COOLTRAINER_M",
    ),
    commands: [
      *text(
        "\\bOur events weren't created by comments, ",
        "because we need to check how many Pokémon you ",
        "had.",
      ),
    ],
  ),
)