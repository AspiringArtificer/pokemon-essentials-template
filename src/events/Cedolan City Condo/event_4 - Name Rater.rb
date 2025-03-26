event(
  id: 4,
  name: "Name Rater",
  x: 10,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "NPC 10",
    ),
    commands: [
      text("\\bHello, hello!\\nI am the official Name Rater!"),
      text("\\bWant me to rate the nicknames of your Pokémon?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\bWhich Pokémon's nickname should I critique?"),
          *comment(
            "Opens a screen for choosing a Pokémon. The index ",
            "is stored in Game Variable 1, and the name in Game ",
            "Variable 3.",
          ),
          script("pbChoosePokemon(1, 3)"),
          *comment(
            "If Game Variable 1 is less than 0, it means the player ",
            "has canceled choosing a Pokémon.",
          ),
          *condition(
            variable: v(1),
            operation: "<",
            constant: 0,
            then: [
              text("\\bI see.\\nDo come visit again."),
              exit_event_processing,
            ],
          ),
          comment("Check for eggs."),
          *condition(
            script: "pbGetPokemon(1).egg?",
            then: [
              text("\\bNow, now... That is merely an Egg!"),
              exit_event_processing,
            ],
          ),
          comment("Check for Shadow Pokémon."),
          *condition(
            script: "pbGetPokemon(1).shadowPokemon?",
            then: [
              text("\\bI wouldn't dare critique a Shadow Pokémon's name!"),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "pbGetPokemon(1).foreign?($player)",
            then: [
              text("\\bHmmm... \\v[3] it is!"),
              *text(
                "\\bThis is a magnificent nickname! It is impeccably ",
                "beyond reproach!",
              ),
              *text(
                "\\bYou'll do well to cherish your \\v[3] now and ",
                "beyond.",
              ),
              exit_event_processing,
            ],
          ),
          text("\\b\\v[3], is it?\\nThat is a decent nickname!"),
          text("\\bBut, would you like me to give it a nicer name?"),
          text("\\bHow about it?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\bAh, good. Then, what shall the new nickname be?"),
              *script(
                <<~'CODE'
                pkmn = pbGetPokemon(1)
                species = pkmn.speciesName
                pbSet(4, species)
                pbTextEntry(
                  _I("{1}'s nickname?", species),
                  0, Pokemon::MAX_NAME_SIZE, 5
                )
                CODE
              ),
              *condition(
                script: "pbGet(5) == pbGet(3) || (pbGet(5) == \"\" && pbGet(3) == pbGet(4))",
                then: [
                  comment("The Pokémon's nickname wasn't changed."),
                  *text(
                    "\\bI see. You're right, there's no need to change this ",
                    "Pokémon's nickname.",
                  ),
                  text("\\bIt already had a superb name!"),
                ],
                else: condition(
                  script: "pbGet(5) == \"\" || pbGet(5) == pbGet(4)",
                  then: [
                    comment("Resets the Pokémon's nickname to the species name."),
                    *script(
                      <<~'CODE'
                      pkmn = pbGetPokemon(1)
                      pkmn.name = nil
                      pbSet(3, pkmn.name)
                      CODE
                    ),
                    *text(
                      "\\bDone! From now on, this Pokémon shall be known",
                      "as \\v[3]!",
                    ),
                    *text(
                      "\\bIt looks no different from before, and yet, this is ",
                      "vastly superior!",
                    ),
                    text("\\bHow fortunate for you!"),
                  ],
                  else: [
                    *comment(
                      "Retrieves the Pokémon whose party index is stored in ",
                      "Game Variable 1, and changes its name to the name ",
                      "stored in Game Variable 5.",
                    ),
                    *script(
                      <<~'CODE'
                      pkmn = pbGetPokemon(1)
                      pkmn.name = pbGet(5)
                      CODE
                    ),
                    *text(
                      "\\bDone! From now on, this Pokémon shall be known",
                      "as \\v[5]!",
                    ),
                    *text(
                      "\\bIt is a better name than before!\\nHow fortunate for ",
                      "you!",
                    ),
                  ],
                ),
              ),
            ],
            choice2: [
              text("\\bI see.\\nDo come visit again."),
            ],
          ),
        ],
        choice2: [
          text("\\bI see.\\nDo come visit again."),
        ],
      ),
    ],
  ),
)