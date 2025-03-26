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
)