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
)