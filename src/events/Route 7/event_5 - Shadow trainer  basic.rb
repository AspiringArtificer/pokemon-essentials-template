event(
  id: 5,
  name: "Shadow trainer - basic",
  x: 14,
  y: 18,
  page_0: page(
    graphic: graphic(
      name: "trainer_TEAMROCKET_M",
      direction: :right,
    ),
    commands: [
      script("pbTrainerIntro(:TEAMROCKET_M)"),
      text("\\bI'm a basic trainer with a Shadow Pokémon."),
      *condition(
        script: "TrainerBattle.start(:TEAMROCKET_M, \"Grunt\", 1)",
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
      name: "trainer_TEAMROCKET_M",
      direction: :right,
    ),
    commands: [
      *text(
        "\\bDid you manage to snag my Shadow Pokémon?  ",
        "Because you can't battle me again for another ",
        "chance.",
      ),
    ],
  ),
)