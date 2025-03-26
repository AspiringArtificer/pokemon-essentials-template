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
)