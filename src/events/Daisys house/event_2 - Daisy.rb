event(
  id: 2,
  name: "Daisy",
  x: 5,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 26",
    ),
    commands: [
      text("\\rDaisy: Hi, \\PN!"),
      *text(
        "\\rDaisy: Would you like me to groom one of your ",
        "Pokémon?",
      ),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\rDaisy: Which Pokémon do you want me to groom?"),
          script("pbChooseNonEggPokemon(1, 2)"),
          *condition(
            variable: v(1),
            operation: "<",
            constant: 0,
            then: [
              text("\\rDaisy: Oh, okay then."),
              exit_event_processing,
            ],
          ),
          *script(
            <<~'CODE'
            pkmn = pbGetPokemon(1)
            pkmn.changeHappiness("groom")
            pkmn.beauty += 40
            CODE
          ),
          *text(
            "\\rDaisy: There! \\v[2] looks a lot happier and prettier ",
            "now!",
          ),
        ],
        choice2: [
          text("\\rDaisy: Oh, okay then."),
        ],
      ),
    ],
  ),
)