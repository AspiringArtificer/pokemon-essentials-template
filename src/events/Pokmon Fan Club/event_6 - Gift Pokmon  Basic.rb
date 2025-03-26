event(
  id: 6,
  name: "Gift Pokémon - Basic",
  x: 8,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "trainer_POKEMANIAC",
    ),
    commands: [
      *text(
        "\\bMy Shuckie is a great Pokémon, but I can't train",
        "it anymore.",
      ),
      *text(
        "\\bWould you take Shuckie and raise it like it ",
        "deserves?",
      ),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *comment(
            "pbAddForeignPokemon can only add a Pokémon to ",
            "the player's party, so a space is required.",
          ),
          *condition(
            script: "pbAddForeignPokemon(:SHUCKLE, 20, _I(\"Kirk\"), _I(\"Shuckie\"))",
            then: [
              text("\\bTake good care of Shuckie!"),
              control_self_switch("A", :ON),
            ],
            else: [
              text("\\bOh, you don't have any space for it."),
            ],
          ),
        ],
        choice2: [
          text("\\bOh, that's a shame."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_POKEMANIAC",
    ),
    commands: [
      text("\\bAre you raising my Shuckie well?"),
    ],
  ),
)