# Cedolan City (7)
#   Cedolan City Condo (12)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Cedolan City", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 6,
      y: 10,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 22, y: 28, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Move Deleter",
      x: 6,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "trainer_ENGINEER",
        ),
        commands: [
          text("\\bUh...\\nOh, yes, I'm the Move Deleter."),
          text("\\bI can make Pokémon forget their moves."),
          text("\\bWould you like me to do that?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              label("ChoosePokemon"),
              text("\\bWhich Pokémon should forget a move?"),
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
                  *text(
                    "\\bCome again if there are moves that need to be ",
                    "forgotten.",
                  ),
                ],
                else: [
                  *condition(
                    script: "pbGetPokemon(1).egg?",
                    then: [
                      text("\\bWhat? No Egg should know any moves."),
                      exit_event_processing,
                    ],
                  ),
                  *condition(
                    script: "pbGetPokemon(1).shadowPokemon?",
                    then: [
                      *text(
                        "\\bWhat? I can't make a Shadow Pokémon forget a ",
                        "move.",
                      ),
                      exit_event_processing,
                    ],
                  ),
                  *condition(
                    script: "pbGetPokemon(1).numMoves == 1",
                    then: [
                      text("\\b\\v[3] seems to know only one move..."),
                      exit_event_processing,
                    ],
                  ),
                  text("\\bWhich move should be forgotten?"),
                  script("pbChooseMove(pbGetPokemon(1), 2, 4)"),
                  *condition(
                    variable: v(2),
                    operation: "<",
                    constant: 0,
                    then: [
                      jump_label("ChoosePokemon"),
                    ],
                    else: [
                      text("\\bHm! \\v[3]'s \\v[4]? That move should be forgotten?"),
                      *show_choices(
                        choices: ["Yes", "No"],
                        cancellation: 2,
                        choice1: [
                          play_me(audio(name: "Forget move")),
                          wait(40),
                          *script(
                            <<~'CODE'
                            pkmn = pbGetPokemon(1)
                            pkmn.forget_move_at_index(pbGet(2))
                            CODE
                          ),
                          text("\\bIt worked to perfection!"),
                          text("\\b\\v[3] has forgotten \\v[4] completely."),
                        ],
                        choice2: [
                          *text(
                            "\\bCome again if there are moves that need to be ",
                            "forgotten.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
            choice2: [
              *text(
                "\\bCome again if there are moves that need to be ",
                "forgotten.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Move Relearner",
      x: 5,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 06",
        ),
        commands: [
          *condition(
            script: "isTempSwitchOff?(\"A\")",
            then: [
              text("\\bI'm the Pokémon Move Maniac."),
              *text(
                "\\bI know every single move that Pokémon learn ",
                "growing up.",
              ),
              text("\\bI'm also a collector of Heart Scales."),
              *text(
                "\\bIf you bring me one, I'll teach a move to one of your ",
                "Pokémon.",
              ),
              script("setTempSwitchOn(\"A\")"),
            ],
          ),
          *condition(
            script: "$bag.has?(:HEARTSCALE)",
            then: [
              *text(
                "\\bOh! That's it! That's an honest to goodness Heart ",
                "Scale!",
              ),
              *text(
                "\\bLet me guess, you want me to teach one of your ",
                "Pokémon a move?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  label("ChoosePokemon"),
                  text("\\bWhich Pokémon needs tutoring?"),
                  *script(
                    <<~'CODE'
                    pbChoosePokemon(1, 3,
                      proc { |pkmn|
                        pkmn.can_relearn_move?
                      },
                      true
                    )
                    CODE
                  ),
                  *comment(
                    "If Game Variable 1 is less than 0, it means the player ",
                    "has canceled choosing a Pokémon.",
                  ),
                  *condition(
                    variable: v(1),
                    operation: "<",
                    constant: 0,
                    then: [
                      *text(
                        "\\bIf your Pokémon need to learn a move, come back ",
                        "with a Heart Scale.",
                      ),
                    ],
                    else: [
                      *condition(
                        script: "pbGetPokemon(1).egg?",
                        then: [
                          *text(
                            "\\bHunh? There isn't a single move that I can teach an ",
                            "Egg.",
                          ),
                          jump_label("ChoosePokemon"),
                        ],
                      ),
                      *condition(
                        script: "pbGetPokemon(1).shadowPokemon?",
                        then: [
                          *text(
                            "\\bNo way, I don't want to go near a Shadow ",
                            "Pokémon.",
                          ),
                          jump_label("ChoosePokemon"),
                        ],
                      ),
                      *condition(
                        script: "!pbGetPokemon(1).can_relearn_move?",
                        then: [
                          text("\\bSorry..."),
                          *text(
                            "\\bIt doesn't appear as if I have any move I can teach ",
                            "to your \\v[3].",
                          ),
                          jump_label("ChoosePokemon"),
                        ],
                      ),
                      text("\\bWhich move should I teach to your \\v[3]?"),
                      *condition(
                        script: "pbRelearnMoveScreen(pbGetPokemon(1))",
                        then: [
                          script("$bag.remove(:HEARTSCALE)"),
                          text("\\PN handed over one Heart Scale in exchange."),
                          *text(
                            "\\bIf your Pokémon need to learn a move, come back ",
                            "with a Heart Scale.",
                          ),
                        ],
                        else: [
                          *text(
                            "\\bIf your Pokémon need to learn a move, come back ",
                            "with a Heart Scale.",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                choice2: [
                  *text(
                    "\\bIf your Pokémon need to learn a move, come back ",
                    "with a Heart Scale.",
                  ),
                ],
              ),
            ],
            else: [
              *text(
                "\\bIf your Pokémon need to learn a move, come back ",
                "with a Heart Scale.",
              ),
            ],
          ),
        ],
      ),
    ),

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
    ),

    event(
      id: 5,
      name: "Move Tutor",
      x: 2,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 11",
        ),
        commands: [
          text("\\rHello! I'm a Move Tutor!"),
          *text(
            "\\rI can teach a special and powerful move to your ",
            "Pokémon.",
          ),
          label("Start"),
          text("\\rWhich special move would you like me to teach?"),
          *show_choices(
            choices: ["Frenzy Plant", "Blast Burn", "Hydro Cannon", "Exit"],
            cancellation: 4,
            choice1: [
              *condition(
                script: "pbMoveTutorChoose(:FRENZYPLANT)",
                then: [
                  *text(
                    "\\rWould you like me to teach another Pokémon a ",
                    "special move?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      jump_label("Start"),
                    ],
                  ),
                ],
                else: [
                  jump_label("Start"),
                ],
              ),
            ],
            choice2: [
              *condition(
                script: "pbMoveTutorChoose(:BLASTBURN)",
                then: [
                  *text(
                    "\\rWould you like me to teach another Pokémon a ",
                    "special move?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      jump_label("Start"),
                    ],
                  ),
                ],
                else: [
                  jump_label("Start"),
                ],
              ),
            ],
            choice3: [
              *condition(
                script: "pbMoveTutorChoose(:HYDROCANNON)",
                then: [
                  *text(
                    "\\rWould you like me to teach another Pokémon a ",
                    "special move?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      jump_label("Start"),
                    ],
                  ),
                ],
                else: [
                  jump_label("Start"),
                ],
              ),
            ],
          ),
          text("\\rCome back any time!"),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       558,  558,  558,  558,  558,  541,  542,  543,  558,  558,  558,  558,  558,  542,  542,  542,  542,  542,  542,  542,
       566,  566,  566,  566,  566,  549,  542,  551,  566,  566,  566,  566,  566,  542,  542,  542,  542,  542,  542,  542,
       673,  673,  673,  673,  673,  549,  542,  551,  673,  673,  673,  673,  673,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  664,  664,  664,  549,  542,  551,  664,  664,  664,  664,  664,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  664,  664,  667,  549,  542,  551,  664,  664,  664,  664,  667,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  664,  673,  674,  557,  558,  559,  664,  664,  664,  673,  674,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  673,  673,  674,  565,  566,  567,  664,  664,  673,  673,  674,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  689,  681,  682,  664,  664,  664,  664,  664,  689,  681,  682,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  542,  542,  542,  542,  542,  542,  542,
       673,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  664,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

      1766, 1534, 1535, 1534, 1535,    0,    0,    0, 1766, 1441, 1442,    0, 1766,    0,    0,    0,    0,    0,    0,    0,
      1774, 1542, 1543, 1542, 1543,    0,    0,    0, 1774, 1449, 1450,    0, 1774,    0,    0,    0,    0,    0,    0,    0,
      1782, 1550, 1551, 1550, 1551,    0,    0,    0, 1782,    0,    0,    0, 1782,    0,    0,    0,    0,    0,    0,    0,
         0, 1662, 2101, 1662,    0,    0,    0,    0,    0, 1662, 2101, 1662,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 2108, 2109, 2110,    0,    0,    0,    0,    0, 2108, 2109, 2110,    0,    0,    0,    0,    0,    0,    0,    0,
      1662, 2116, 2117, 2118, 1662,    0, 1459,    0, 1662, 2116, 2117, 2118, 1662,    0,    0,    0,    0,    0,    0,    0,
         0, 2124, 2125, 2126,    0,    0, 1467,    0,    0, 2124, 2125, 2126,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1662,    0, 1662,    0,    0,    0,    0,    0, 1662,    0, 1662,    0,    0,    0,    0,    0,    0,    0,    0,
      1771,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1771,    0,    0,    0,    0,    0,    0,    0,
      1779,    0,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0, 1779,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 2100,    0, 2102,    0,    0,    0,    0,    0, 2100,    0, 2102,    0,    0,    0,    0,    0,    0,    0,    0,
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
