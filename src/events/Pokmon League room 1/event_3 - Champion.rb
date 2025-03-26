event(
  id: 3,
  name: "Champion",
  x: 6,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "trainer_CHAMPION",
    ),
    commands: [
      script("pbTrainerIntro(:CHAMPION)"),
      *text(
        "\\bEverything in here uses a temporary switch to ",
        "decide what to do, rather than a Self Switch, ",
        "because it all needs to reset each time you enter.",
      ),
      *condition(
        script: "TrainerBattle.start(:CHAMPION, \"Blue\")",
        then: [
          script("setTempSwitchOn(\"A\")"),
          comment("Open door."),
          script("get_character(1).setTempSwitchOn(\"A\")"),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    switch1: s(21),
    graphic: graphic(
      name: "trainer_CHAMPION",
    ),
    commands: [
      text("\\bYou beat me! Go on to the Hall of Fame."),
    ],
  ),
)