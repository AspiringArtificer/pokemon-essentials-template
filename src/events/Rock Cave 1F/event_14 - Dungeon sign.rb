event(
  id: 14,
  name: "Dungeon sign",
  x: 24,
  y: 13,
  page_0: page(
    commands: [
      text("This ladder leads to a random dungeon."),
      *text(
        "The levels of Pokémon within are based on the levels ",
        "of Pokémon in the player's party.",
      ),
      *text(
        "This is because the dungeon map's metadata gives it ",
        "the \"ScaleWildEncounterLevels\" flag.",
      ),
    ],
  ),
)