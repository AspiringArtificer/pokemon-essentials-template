event(
  id: 3,
  name: "Day Care Lady",
  x: 4,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 11",
    ),
    commands: [
      *condition(
        script: "DayCare.egg_generated?",
        then: [
          *text(
            "\\rAh, there you are! My husband was looking for ",
            "you.",
          ),
          exit_event_processing,
        ],
      ),
      control_self_switch("A", :OFF),
      *condition(
        script: "DayCare.count == 0",
        then: [
          *text(
            "\\rI'm the Day-Care Lady. We can raise Pokémon for ",
            "you.",
          ),
          text("\\rWould you like us to raise your Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *condition(
                script: "$player.pokemon_count <= 1",
                then: [
                  text("\\rOh? But you only have one Pokémon with you."),
                  *text(
                    "\\rYou can't go off without a Pokémon. Come back ",
                    "another time.",
                  ),
                  exit_event_processing,
                ],
              ),
              text("\\rWhich Pokémon should we raise for you?"),
              script("pbChooseNonEggPokemon(1, 3)"),
              *condition(
                variable: v(1),
                operation: "<",
                constant: 0,
                then: [
                  text("\\rOh, fine, then.\\nCome again."),
                  exit_event_processing,
                ],
              ),
              *condition(
                script: "!$player.has_other_able_pokemon?(pbGet(1))",
                then: [
                  *text(
                    "\\rIf you leave me that Pokémon, what are you gonna ",
                    "battle with?",
                  ),
                  text("\\rCome back another time."),
                  exit_event_processing,
                ],
              ),
              script("DayCare.deposit(pbGet(1))"),
              text("\\rFine, we'll raise your \\v[3] for a while."),
              text("\\rCome back for it later."),
              label("RaiseAnother"),
              *text(
                "\\rWe can raise two of your Pokémon. Would you like ",
                "us to raise another?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  *condition(
                    script: "$player.pokemon_count <= 1",
                    then: [
                      text("\\rOh? But you only have one Pokémon with you."),
                      *text(
                        "\\rYou can't go off without a Pokémon. Come back ",
                        "another time.",
                      ),
                      exit_event_processing,
                    ],
                  ),
                  text("\\rWhich Pokémon should we raise for you?"),
                  script("pbChooseNonEggPokemon(1, 3)"),
                  *condition(
                    variable: v(1),
                    operation: "<",
                    constant: 0,
                    then: [
                      text("\\rVery good. Come again."),
                      exit_event_processing,
                    ],
                  ),
                  *condition(
                    script: "!$player.has_other_able_pokemon?(pbGet(1))",
                    then: [
                      *text(
                        "\\rIf you leave me that Pokémon, what are you gonna ",
                        "battle with?",
                      ),
                      text("\\rCome back another time."),
                      exit_event_processing,
                    ],
                  ),
                  *condition(
                    script: "pbGetPokemon(1).cannot_store",
                    then: [
                      *text(
                        "\\rThat Pokémon looks like it would rather stay with ",
                        "you.",
                      ),
                      text("\\rCome back another time."),
                      exit_event_processing,
                    ],
                  ),
                  script("DayCare.deposit(pbGet(1))"),
                  text("\\rFine, we'll raise your \\v[3] for a while."),
                  text("\\rCome back for it later."),
                ],
                choice2: [
                  *condition(
                    self_switch: "A",
                    value: :ON,
                    then: [
                      jump_label("TakeBack"),
                    ],
                    else: [
                      text("\\rVery good. Come again."),
                    ],
                  ),
                ],
              ),
            ],
            choice2: [
              text("\\rOh, fine, then.\\nCome again."),
            ],
          ),
        ],
        else: [
          *text(
            "\\rAh, it's you! Good to see you. Now, about your ",
            "Pokémon...",
          ),
          *condition(
            script: "DayCare.get_level_gain(0, 3, 4) && pbGet(4) > 0",
            then: [
              text("\\rBy level, your \\v[3] has grown by about \\v[4]."),
            ],
          ),
          *condition(
            script: "DayCare.get_level_gain(1, 3, 4) && pbGet(4) > 0",
            then: [
              text("\\rBy level, your \\v[3] has grown by about \\v[4]."),
            ],
          ),
          *condition(
            script: "DayCare.count == 1",
            then: [
              control_self_switch("A", :ON),
              jump_label("RaiseAnother"),
            ],
            else: [
              label("TakeBack"),
              text("\\rDo you want your Pokémon back?"),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  label("TakeBackChosen"),
                  *condition(
                    script: "$player.party_full?",
                    then: [
                      *text(
                        "\\rYour Pokémon team is full. Make room, then come ",
                        "see me.",
                      ),
                      exit_event_processing,
                    ],
                  ),
                  *script(
                    <<~'CODE'
                    DayCare.choose(
                      _I("Which one do you want back?"),
                      1
                    )
                    CODE
                  ),
                  *condition(
                    variable: v(1),
                    operation: "<",
                    constant: 0,
                    then: [
                      text("\\rVery good. Come again."),
                      exit_event_processing,
                    ],
                  ),
                  script("DayCare.get_details(pbGet(1), 3, 4)"),
                  text("\\G\\rIf you want your \\v[3] back, it will cost $\\v[4]."),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      control_variables(v(5), property: :gold),
                      *condition(
                        variable: v(5),
                        operation: "<",
                        other_variable: v(4),
                        then: [
                          text("\\G\\rYou don't have enough money..."),
                          exit_event_processing,
                        ],
                      ),
                      change_gold("-=", variable: v(4)),
                      play_se(audio(name: "Mart buy item")),
                      script("DayCare.withdraw(pbGet(1))"),
                      text("\\G\\rExcellent\\nHere's your Pokémon."),
                      text("\\PN took \\v[3] back from the Day-Care Lady."),
                      *condition(
                        script: "DayCare.count == 1",
                        then: [
                          text("\\G\\rDo you want to take back the other one, too?"),
                          *show_choices(
                            choices: ["Yes", "No"],
                            cancellation: 2,
                            choice1: [
                              jump_label("TakeBackChosen"),
                            ],
                            choice2: [
                              text("\\rVery good. Come again."),
                            ],
                          ),
                        ],
                        else: [
                          text("\\rVery good. Come again."),
                        ],
                      ),
                    ],
                    choice2: [
                      text("\\rVery good. Come again."),
                    ],
                  ),
                ],
                choice2: [
                  text("\\rVery good. Come again."),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  ),
)