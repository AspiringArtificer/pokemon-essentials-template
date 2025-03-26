event(
  id: 4,
  name: "Fossil combiner",
  x: 5,
  y: 3,
  page_0: page(
    graphic: graphic(
      name: "trainer_SCIENTIST",
    ),
    commands: [
      *comment(
        "The fossil combiner is from Gen 8. They take two ",
        "different fossil items and produce a Pokémon based ",
        "on the combination. This is a relatively ",
        "straightforward \"choose an item from each of two ",
        "lists, add a Pokémon based on what was chosen\".",
      ),
      *condition(
        self_switch: "B",
        value: :OFF,
        then: [
          *text(
            "\\bHello, huh! My name is Carl Ess. I can turn ",
            "combinations of partial Fossils into living, breathing ",
            "Pokémon!",
          ),
          control_self_switch("B", :ON),
        ],
      ),
      comment("================================"),
      *comment(
        "Check whether the player has at least one top fossil ",
        "and at least one bottom fossil. The result of this ",
        "check could have been stored in a Game Switch ",
        "rather than a Game Variable, because it's just \"yes or ",
        "no\", but there are no Game Switches for temporary ",
        "values and I didn't feel like makng one just for this.",
      ),
      *script(
        <<~'CODE'
        top = $bag.has?(:FOSSILIZEDBIRD) ||
              $bag.has?(:FOSSILIZEDFISH)
        btm = $bag.has?(:FOSSILIZEDDRAKE) ||
              $bag.has?(:FOSSILIZEDDINO)
        pbSet(1, (top && btm) ? 1 : 0)
        CODE
      ),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 1,
        then: [
          *comment(
            "The choice of top fossil will be stored in Game Variable ",
            "1 (1=Bird, 2=Fish, 0=Quit).",
            "The choice of bottom fossil will be stored in Game ",
            "Variable 2 (1=Drake, 2=Dino, 0=Quit).",
          ),
          control_variables(v(1), constant: 0),
          *text(
            "\\bHm? You've got some Fossils there, huh. Will you ",
            "show them to me, Carl Ess?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              label("Start choices"),
              comment("================================"),
              comment("Choose the top half."),
              *condition(
                script: "$bag.has?(:FOSSILIZEDBIRD) && $bag.has?(:FOSSILIZEDFISH)",
                then: [
                  *text(
                    "\\bWhich of your Fossils do you think stands up to the ",
                    "high standards of Carl Ess?",
                  ),
                  *show_choices(
                    choices: ["Fossilized Bird", "Fossilized Fish", "Quit"],
                    cancellation: 3,
                    choice1: [
                      control_variables(v(1), constant: 1),
                    ],
                    choice2: [
                      control_variables(v(1), constant: 2),
                    ],
                    choice3: [
                      jump_label("Quit"),
                    ],
                  ),
                ],
                else: condition(
                  script: "$bag.has?(:FOSSILIZEDBIRD)",
                  then: [
                    *text(
                      "\\bWhich of your Fossils do you think stands up to the ",
                      "high standards of Carl Ess?",
                    ),
                    *show_choices(
                      choices: ["Fossilized Bird", "Quit"],
                      cancellation: 2,
                      choice1: [
                        control_variables(v(1), constant: 1),
                      ],
                      choice2: [
                        jump_label("Quit"),
                      ],
                    ),
                  ],
                  else: [
                    *text(
                      "\\bWhich of your Fossils do you think stands up to the ",
                      "high standards of Carl Ess?",
                    ),
                    *show_choices(
                      choices: ["Fossilized Fish", "Quit"],
                      cancellation: 2,
                      choice1: [
                        control_variables(v(1), constant: 2),
                      ],
                      choice2: [
                        jump_label("Quit"),
                      ],
                    ),
                  ],
                ),
              ),
              comment("================================"),
              comment("Choose the bottom half."),
              *condition(
                script: "$bag.has?(:FOSSILIZEDDRAKE) && $bag.has?(:FOSSILIZEDDINO)",
                then: [
                  *text(
                    "\\bWhich of your Fossils do you think will pique the ",
                    "curiosity of Carl Ess?",
                  ),
                  *show_choices(
                    choices: ["Fossilized Drake", "Fossilized Dino", "Quit"],
                    cancellation: 3,
                    choice1: [
                      control_variables(v(2), constant: 1),
                    ],
                    choice2: [
                      control_variables(v(2), constant: 2),
                    ],
                    choice3: [
                      jump_label("Quit"),
                    ],
                  ),
                ],
                else: condition(
                  script: "$bag.has?(:FOSSILIZEDDRAKE)",
                  then: [
                    *text(
                      "\\bWhich of your Fossils do you think will pique the ",
                      "curiosity of Carl Ess?",
                    ),
                    *show_choices(
                      choices: ["Fossilized Drake", "Quit"],
                      cancellation: 2,
                      choice1: [
                        control_variables(v(2), constant: 1),
                      ],
                      choice2: [
                        jump_label("Quit"),
                      ],
                    ),
                  ],
                  else: [
                    *text(
                      "\\bWhich of your Fossils do you think will pique the ",
                      "curiosity of Carl Ess?",
                    ),
                    *show_choices(
                      choices: ["Fossilized Dino", "Quit"],
                      cancellation: 2,
                      choice1: [
                        control_variables(v(2), constant: 2),
                      ],
                      choice2: [
                        jump_label("Quit"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            choice2: [
              jump_label("Quit"),
            ],
          ),
        ],
        else: [
          comment("================================"),
          comment("Player doesn't have at least one fossil for each end."),
          *text(
            "\\bCome see me when you have some interesting ",
            "Fossils.",
          ),
          exit_event_processing,
        ],
      ),
      comment("================================"),
      *comment(
        "Determine which Pokémon will be revived from the ",
        "chosen fossils. Its species is stored in Game Variable ",
        "14.",
      ),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 1,
        then: condition(
          variable: v(2),
          operation: "==",
          constant: 1,
          then: [
            comment("Bird + Drake = Dracozolt"),
            *text(
              "\\bSo I should restore the Fossilized Bird and the ",
              "Fossilized Drake together, huh?",
            ),
            *show_choices(
              choices: ["Yes, please", "I want to try something else", "Quit"],
              cancellation: 3,
              choice1: [
                script("pbSet(14, :DRACOZOLT)"),
              ],
              choice2: [
                jump_label("Start choices"),
              ],
              choice3: [
                jump_label("Quit"),
              ],
            ),
          ],
          else: [
            comment("Bird + Dino = Arctozolt"),
            *text(
              "\\bSo I should restore the Fossilized Bird and the ",
              "Fossilized Dino together, huh?",
            ),
            *show_choices(
              choices: ["Yes, please", "I want to try something else", "Quit"],
              cancellation: 3,
              choice1: [
                script("pbSet(14, :ARCTOZOLT)"),
              ],
              choice2: [
                jump_label("Start choices"),
              ],
              choice3: [
                jump_label("Quit"),
              ],
            ),
          ],
        ),
        else: condition(
          variable: v(2),
          operation: "==",
          constant: 1,
          then: [
            comment("Fish + Drake = Dracovish"),
            *text(
              "\\bSo I should restore the Fossilized Fish and the ",
              "Fossilized Drake together, huh?",
            ),
            *show_choices(
              choices: ["Yes, please", "I want to try something else", "Quit"],
              cancellation: 3,
              choice1: [
                script("pbSet(14, :DRACOVISH)"),
              ],
              choice2: [
                jump_label("Start choices"),
              ],
              choice3: [
                jump_label("Quit"),
              ],
            ),
          ],
          else: [
            comment("Fish + Dino = Arctovish"),
            *text(
              "\\bSo I should restore the Fossilized Fish and the ",
              "Fossilized Dino together, huh?",
            ),
            *show_choices(
              choices: ["Yes, please", "I want to try something else", "Quit"],
              cancellation: 3,
              choice1: [
                script("pbSet(14, :ARCTOVISH)"),
              ],
              choice2: [
                jump_label("Start choices"),
              ],
              choice3: [
                jump_label("Quit"),
              ],
            ),
          ],
        ),
      ),
      comment("================================"),
      *comment(
        "Create the Pokémon from the chosen fossils, and ",
        "give it to the player.",
      ),
      *condition(
        script: "GameData::Species.exists?(pbGet(14))",
        then: [
          *comment(
            "Fossils can be combined and will make a Pokémon. ",
            "Remove the fossil items and add the Pokémon.",
          ),
          *condition(
            variable: v(1),
            operation: "==",
            constant: 1,
            then: [
              script("$bag.remove(:FOSSILIZEDBIRD)"),
            ],
            else: [
              script("$bag.remove(:FOSSILIZEDFISH)"),
            ],
          ),
          *condition(
            variable: v(2),
            operation: "==",
            constant: 1,
            then: [
              script("$bag.remove(:FOSSILIZEDDRAKE)"),
            ],
            else: [
              script("$bag.remove(:FOSSILIZEDDINO)"),
            ],
          ),
          *text(
            "\\bOK. Restoration time. Let's unravel the mystery of ",
            "these Fossils!",
          ),
          text("\\bAll right, I'll stick 'em together! Here... we... GO!"),
          wait(20),
          *text(
            "\\bObjective complete. It seems the restoration was a ",
            "great success.",
          ),
          *text(
            "\\bYes, I can see it in its eyes. This is a Pokémon that ",
            "walked the face of Essen in ancient times! Please ",
            "take and care for this Pokémon, huh.",
          ),
          *condition(
            script: "pbAddToParty(pbGet(14), 1)",
            then: [
              script("$stats.revived_fossil_count += 1"),
              control_variables(v(14), constant: 0),
              comment("Pokémon was added!"),
            ],
            else: [
              *comment(
                "The Pokémon couldn't be added to the party. Keep its ",
                "species in Game Variable 14 and turn Self Switch A ",
                "on, to let the player collect it once they have space in ",
                "their party. See page 2 of this event.",
              ),
              *text(
                "\\bOh, you don't have space in your party, huh. Make ",
                "some room and then come back here for your ",
                "Pokémon.",
              ),
              control_self_switch("A", :ON),
            ],
          ),
        ],
        else: [
          comment("The species to be revived is not defined. Do nothing."),
          control_variables(v(14), constant: 0),
          text("\\bOh. They don't seem to work together."),
        ],
      ),
      exit_event_processing,
      comment("================================"),
      label("Quit"),
      text("\\bMaybe some other time, then."),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_SCIENTIST",
    ),
    commands: [
      *text(
        "\\bHuh, have you made some room for your Pokémon ",
        "yet?",
      ),
      *condition(
        script: "pbAddToParty(pbGet(14), 1)",
        then: [
          script("$stats.revived_fossil_count += 1"),
          control_variables(v(14), constant: 0),
          control_self_switch("A", :OFF),
        ],
        else: [
          *text(
            "\\bYou haven't. Make some room and then come back ",
            "here.",
          ),
        ],
      ),
    ],
  ),
)