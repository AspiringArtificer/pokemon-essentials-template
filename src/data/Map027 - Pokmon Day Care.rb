# Lerucean Town (23)
#   Pokémon Day Care (27)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Lerucean Town", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 4,
      y: 8,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 23, x: 28, y: 10, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "PC",
      x: 5,
      y: 1,
      page_0: page(
        commands: [
          script("pbPokeCenterPC"),
        ],
      ),
    ),

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
    ),

    event(
      id: 4,
      name: "Hidden Power checker",
      x: 6,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_BIRDKEEPER",
          direction: :left,
        ),
        commands: [
          *text(
            "\\bI'll tell you what type your Pokémon's Hidden Power ",
            "will be.",
          ),
          text("\\bMy own hidden power lets me do that."),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              script("pbChooseNonEggPokemon(1, 3)"),
              *condition(
                variable: v(1),
                operation: ">=",
                constant: 0,
                then: [
                  *comment(
                    "The below scripts check whether the chosen Pokémon ",
                    "knows or is able to learn Hidden Power (by level ",
                    "up/TM/Move Tutor).",
                    "Game Variable 2 will contain the name of Hidden ",
                    "Power's type if it is learnable, or \"\" if it can't be ",
                    "learned.",
                  ),
                  *script(
                    <<~'CODE'
                    move = :HIDDENPOWER
                    pkmn = pbGetPokemon(1)
                    data = pkmn.species_data
                    compatible = false
                    if pkmn.hasMove?(move) ||
                       pkmn.compatible_with_move?(move)
                      compatible = true
                    end
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    # Check level-up moves
                    if !compatible
                      lvm = pkmn.getMoveList
                      if lvm.any? { |m| m[1] == move }
                        compatible = true
                      end
                    end
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    # Get type's name
                    if compatible
                      type = pbHiddenPower(pkmn)[0]
                      nm = GameData::Type.get(type).name
                      pbSet(2, nm)
                    else
                      pbSet(2, "")
                    end
                    CODE
                  ),
                  *condition(
                    script: "pbGet(2) == \"\"",
                    then: [
                      *text(
                        "\\bOh, no. This Pokémon can't learn the move Hidden ",
                        "Power in the first place.",
                      ),
                    ],
                    else: condition(
                      script: "pbGetPokemon(1).hasMove?(:HIDDENPOWER)",
                      then: [
                        text("\\bThis Pokémon's Hidden Power is the \\v[2] type."),
                      ],
                      else: [
                        *text(
                          "\\bIf this Pokémon were to learn Hidden Power, the ",
                          "move's type would be \\v[2].",
                        ),
                      ],
                    ),
                  ),
                ],
                else: [
                  comment("No Pokémon was chosen."),
                  jump_label("Cancel"),
                ],
              ),
            ],
            choice2: [
              label("Cancel"),
              *text(
                "\\bIf you want to know, ask me, and I'll activate my ",
                "hidden power for you.",
              ),
            ],
          ),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       432,  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,  434,  542,  542,  542,  542,  542,  542,  542,  542,
       440,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  442,  542,  542,  542,  542,  542,  542,  542,  542,
      1037, 1045, 1045, 1045, 1077, 1069, 1071, 1077, 1077, 1077, 1077, 1063,  542,  542,  542,  542,  542,  542,  542,  542,
      1055, 1054, 1054, 1054, 1060, 1192, 1193, 1193, 1193, 1193, 1194, 1060,  542,  542,  542,  542,  542,  542,  542,  542,
      1069, 1060, 1060, 1060, 1060, 1200, 1201, 1201, 1201, 1201, 1202, 1060,  542,  542,  542,  542,  542,  542,  542,  542,
      1069, 1060, 1060, 1060, 1060, 1200, 1201, 1201, 1201, 1201, 1202, 1060,  542,  542,  542,  542,  542,  542,  542,  542,
      1069, 1060, 1060, 1060, 1060, 1208, 1209, 1209, 1209, 1209, 1210, 1060,  542,  542,  542,  542,  542,  542,  542,  542,
      1069, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060, 1060,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,  389,  390,  391,    0, 1693,    0,    0, 1493, 1493,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  397,  398,  399, 2162, 1701,    0,    0, 1501, 1501,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       448,    0,    0,    0, 2170, 1709,    0,    0,    0,    0,    0,  450,    0,    0,    0,    0,    0,    0,    0,    0,
      2177, 2177, 2177, 2177, 2178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1756,    0,    0,    0,    0,    0, 1671, 2131, 2133, 1671,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1764,    0,    0,    0,    0,    0, 1671, 2139, 2141, 1671,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1756,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1756,    0,    0,    0,    0,    0,    0,    0,    0,
      1764,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0,    0, 1764,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
