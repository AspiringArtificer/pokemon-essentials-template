event(
  id: 6,
  name: "Shadow trainer - repeat",
  x: 14,
  y: 19,
  page_0: page(
    graphic: graphic(
      name: "trainer_TEAMROCKET_F",
      direction: :right,
    ),
    commands: [
      script("pbTrainerIntro(:TEAMROCKET_F)"),
      *text(
        "\\rYou can battle me repeatedly, and have unlimited ",
        "attempts to snag my Shadow Pokémon.",
      ),
      *condition(
        script: "TrainerBattle.start(:TEAMROCKET_F, \"Grunt\", 1)",
        then: condition(
          script: "$player.pokedex.owned_shadow_pokemon?(:ELECTABUZZ)",
          then: [
            control_self_switch("A", :ON),
          ],
        ),
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_TEAMROCKET_F",
      direction: :right,
    ),
    commands: [
      *text(
        "\\rYou've managed to snag my Shadow Electabuzz.  ",
        "I'm not going to do anything now.",
      ),
    ],
  ),
)