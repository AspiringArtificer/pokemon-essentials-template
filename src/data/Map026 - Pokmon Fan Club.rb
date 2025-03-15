# Lerucean Town (23)
#   Pokémon Fan Club (26)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Lerucean Town", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 5,
      y: 11,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 23, x: 24, y: 18, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Trader - Basic",
      x: 2,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "NPC 06",
        ),
        commands: [
          text("\\bI'm looking for a Rattata."),
          text("\\bWant to trade it for my Haunter?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *comment(
                "The chosen Pokémon's party index goes in Game ",
                "Variable 1. A value of -1 means no Pokémon was ",
                "chosen.",
                "The chosen Pokémon's name goes in Game Variable 2.",
              ),
              *script(
                <<~'CODE'
                pbChoosePokemonForTrade(1, 2,
                  :RATTATA
                )
                CODE
              ),
              *condition(
                variable: v(1),
                operation: "==",
                constant: -1,
                then: [
                  text("\\bYou don't want to trade?  Aww..."),
                ],
                else: [
                  text("\\bOK, let's get started."),
                  *script(
                    <<~'CODE'
                    pbStartTrade(pbGet(1),
                      :HAUNTER, _I("HaHa"), _I("Andy")
                    )
                    CODE
                  ),
                  text("\\PN traded Rattata for Haunter!"),
                  text("\\bThanks!"),
                  control_self_switch("A", :ON),
                ],
              ),
            ],
            choice2: [
              text("\\bYou don't want to trade? Aww..."),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "NPC 06",
        ),
        commands: [
          text("\\bThanks for trading with me!"),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Pokémon ball - Basic",
      x: 5,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          *comment(
            "This is a straightforward example of giving a ",
            "Pokémon to the player. Its OT will be the player.",
          ),
          *condition(
            script: "pbAddPokemon(:FARFETCHD, 20)",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 4,
      name: "Gift Pokémon - Advanced",
      x: 9,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "NPC 08",
        ),
        commands: [
          *text(
            "\\rI have a rather special Bulbasaur! Its ability is",
            "something I could only dream of.",
          ),
          *text(
            "\\rI can't look after it, though. Would you like ",
            "Bulbasaur?",
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
                script: "pbAddForeignPokemon(:BULBASAUR, 10, _I(\"Dorima\"), _I(\"Sauri\"), 1)",
                then: [
                  *comment(
                    "Editing a foreign Pokémon added with this method ",
                    "can only be done afterwards. Remember to add ",
                    "\"poke.calcStats\" at the end, just in case a ",
                    "modification affects the Pokémon's stats.",
                  ),
                  *comment(
                    "The added Pokémon will always be at the end of the ",
                    "player's party, so you can use $Trainer.last_party to ",
                    "locate it.",
                  ),
                  *script(
                    <<~'CODE'
                    pkmn = $player.last_party
                    pkmn.ability_index = 2  # Hidden abil
                    pkmn.nature = :MODEST
                    pkmn.poke_ball = :CHERISHBALL
                    pkmn.shiny = true
                    pkmn.calc_stats
                    CODE
                  ),
                  text("\\rTake good care of Sauri!"),
                  control_self_switch("A", :ON),
                ],
                else: [
                  text("\\rOh, you don't have any space."),
                ],
              ),
            ],
            choice2: [
              text("\\rOh, that's a shame."),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "NPC 08",
        ),
        commands: [
          text("\\rI hope you're taking good care of my Sauri!"),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Trade - Advanced",
      x: 3,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "trainer_PSYCHIC_F",
        ),
        commands: [
          text("\\rI'm looking for a female Dragonair."),
          text("\\rWant to trade it for my Dodrio?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *comment(
                "Because there are more requirements than just ",
                "wanting the correct species, the method ",
                "pbChoosePokemonForTrade cannot be used here. ",
                "Instead, it is recreated using method ",
                "pbChooseTradeablePokemon.",
              ),
              *comment(
                "The chosen Pokémon's party index goes in Game ",
                "Variable 1. A value of -1 means no Pokémon was ",
                "chosen.",
                "The chosen Pokémon's name goes in Game Variable 2.",
              ),
              *script(
                <<~'CODE'
                pbChooseTradablePokemon(1, 2,
                  proc { |pkmn|
                    pkmn.isSpecies?(:DRAGONAIR) &&
                    pkmn.female?
                  }
                )
                CODE
              ),
              *condition(
                variable: v(1),
                operation: "==",
                constant: -1,
                then: [
                  text("\\rYou don't want to trade? Aww..."),
                ],
                else: [
                  text("\\rOK, let's get started."),
                  *comment(
                    "This trade is providing a special Dodrio with certain ",
                    "custom modifications. You should define this Pokémon ",
                    "first and modify it, and then perform the trade. This ",
                    "is because the modifications may affect the ",
                    "Pokémon's appearance (form/gender/shininess) which ",
                    "will be seen during the trade animation.",
                  ),
                  *comment(
                    "Remember to add \"pkmn.calcStats\" at the end. It ",
                    "makes sure the Pokémon's stats are correct, as some ",
                    "modifications can affect them, e.g.changing ",
                    "IVs/nature.",
                    "It doesn't hurt to have this line there anyway, even if ",
                    "you don't affect the stats after all.",
                  ),
                  *script(
                    <<~'CODE'
                    pkmn = Pokemon.new(:DODRIO,
                      pbGetPokemon(1).level
                    )
                    pkmn.item = :SMOKEBALL
                    pkmn.makeFemale
                    pkmn.ability_index = 0     # Run Away
                    pkmn.nature = :IMPISH
                    pkmn.poke_ball = :LUXURYBALL
                    pkmn.learn_move(:SURF)
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    pkmn.iv[:HP]              = 20
                    pkmn.iv[:ATTACK]          = 20
                    pkmn.iv[:DEFENSE]         = 20
                    pkmn.iv[:SPECIAL_ATTACK]  = 15
                    pkmn.iv[:SPECIAL_DEFENSE] = 15
                    pkmn.iv[:SPEED]           = 15
                    CODE
                  ),
                  script("pkmn.calc_stats"),
                  *script(
                    <<~'CODE'
                    pbStartTrade(pbGet(1), pkmn,
                      _I("Doris"), _I("Ayana"), 1
                    )
                    CODE
                  ),
                  *comment(
                    "The trade itself sets the received Pokémon's ",
                    "nickname, obtain method and OT details. These can ",
                    "only be modified after the trade, although you ",
                    "shouldn't need to do so.",
                  ),
                  text("\\PN traded Dragonair for Dodrio!"),
                  text("\\rThanks!"),
                  control_self_switch("A", :ON),
                ],
              ),
            ],
            choice2: [
              text("\\rYou don't want to trade?  Aww..."),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_PSYCHIC_F",
        ),
        commands: [
          text("\\rAre you taking good care of Doris?"),
        ],
      ),
    ),

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
    ),

    event(
      id: 7,
      name: "Gift egg",
      x: 7,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "trainer_GENTLEMAN",
        ),
        commands: [
          text("\\bOh, hi!"),
          text("\\bWould you like this Pokémon Egg?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *comment(
                "pbGenerateEgg can only add an egg to the player's ",
                "party, so a space is required.",
              ),
              *condition(
                script: "pbGenerateEgg(:TOGEPI, _I(\"Fan Club President\"))",
                then: [
                  *text(
                    "\\me[Egg get]\\PN received the Egg from the Fan Club ",
                    "President.",
                  ),
                  text("\\bTake good care of it!"),
                  control_self_switch("A", :ON),
                ],
                else: [
                  text("\\bOh, you can't carry it with you."),
                  text("\\bMake some space in your party and come back."),
                ],
              ),
            ],
            choice2: [
              text("\\bOh. Will I ever find someone to take this Egg?"),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_GENTLEMAN",
        ),
        commands: [
          text("\\bI wonder what that Egg will hatch into?"),
        ],
      ),
    ),

    event(
      id: 8,
      name: "Pokémon ball - Advanced",
      x: 6,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          *comment(
            "This is an example of giving a Pokémon which has ",
            "been modified. The Pokémon is defined separately ",
            "before being given to the player.",
          ),
          *condition(
            script: "!pbBoxesFull?",
            then: [
              *script(
                <<~'CODE'
                pkmn = Pokemon.new(:PICHU, 30)
                pkmn.item = :ZAPPLATE
                pkmn.form = 2           # Spiky-eared
                pkmn.makeFemale
                pkmn.shiny = false
                pkmn.learn_move(:VOLTTACKLE)
                pkmn.learn_move(:HELPINGHAND)
                pkmn.learn_move(:SWAGGER)
                pkmn.learn_move(:PAINSPLIT)
                pkmn.calc_stats
                CODE
              ),
              script("pbAddPokemon(pkmn)"),
              control_self_switch("A", :ON),
            ],
            else: [
              text("There's no more room for Pokémon!"),
              text("The Pokémon Boxes are full and can't accept any more!"),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       437,  438,  438,  438,  438,  438,  438,  438,  438,  438,  438,  439,  542,  542,  542,  542,  542,  542,  542,  542,
       445,  446,  446,  446,  446,  446,  446,  446,  446,  446,  446,  447,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1041, 1041, 1041, 1033, 1033, 1033, 1033, 1035, 1041, 1041, 1027,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1192, 1193, 1193, 1193, 1193, 1193, 1193, 1194, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1200, 1201, 1201, 1201, 1201, 1201, 1201, 1202, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1200, 1201, 1201, 1201, 1201, 1201, 1201, 1202, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1200, 1201, 1201, 1201, 1201, 1201, 1201, 1202, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1208, 1209, 1209, 1209, 1209, 1209, 1209, 1210, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
      1033, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024, 1024,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0, 1474,    0, 1504, 1505, 1504, 1505,    0, 1474,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1482,    0, 1512, 1513, 1512, 1513,    0, 1482,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       453,    0,    0,    0, 1520, 1521, 1520, 1521,    0,    0,    0,  455,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0, 1660, 1661,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0,    0, 1668, 1669,    0,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,
      1756,    0,    0,    0, 1658, 2131, 2133, 1659,    0,    0,    0, 1756,    0,    0,    0,    0,    0,    0,    0,    0,
      1764,    0,    0,    0, 1666, 2139, 2141, 1667,    0,    0,    0, 1764,    0,    0,    0,    0,    0,    0,    0,    0,
      1756,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1756,    0,    0,    0,    0,    0,    0,    0,    0,
      1764,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1764,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
