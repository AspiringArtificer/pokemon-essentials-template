event(
  id: 6,
  name: "Stats judge",
  x: 8,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 10",
    ),
    commands: [
      *text(
        "\\bIf you'd like, I could judge the intriguing potential of ",
        "your Pokémon.",
      ),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\bWhich Pokémon would you like me to judge?"),
          script("pbChooseNonEggPokemon(1, 2)"),
          *condition(
            variable: v(1),
            operation: "<",
            constant: 0,
            then: [
              text("\\b...Oh? You don't need me to judge. I get it."),
              exit_event_processing,
            ],
          ),
          *comment(
            "Say something depending on the total number of IVs ",
            "the Pokémon has.",
          ),
          *script(
            <<~'CODE'
            ivs = pbGetPokemon(1).calcIV
            total = 0
            ivs.each_value { |v| total += v }
            pbSet(2, total)
            CODE
          ),
          text("\\bI see, I see..."),
          *condition(
            variable: v(1),
            operation: ">",
            constant: 150,
            then: [
              text("\\bThis Pokémon's potential is outstanding overall."),
            ],
            else: condition(
              variable: v(1),
              operation: ">",
              constant: 120,
              then: [
                *text(
                  "\\bThis Pokémon's potential is relatively superior ",
                  "overall.",
                ),
              ],
              else: condition(
                variable: v(1),
                operation: ">",
                constant: 90,
                then: [
                  text("\\bThis Pokémon's potential is above average overall."),
                ],
                else: [
                  text("\\bThis Pokémon's potential is decent overall."),
                ],
              ),
            ),
          ),
          text("\\bThat's my determination, and it's final."),
          *comment(
            "Find out which stat(s) have the highest value, and ",
            "show a message about each of them.",
          ),
          *script(
            <<~'CODE'
            pkmn = pbGetPokemon(1)
            ivs  = pkmn.calcIV
            best = []
            val  = -1
            CODE
          ),
          *script(
            <<~'CODE'
            [:HP, :ATTACK, :DEFENSE,
             :SPECIAL_ATTACK, :SPECIAL_DEFENSE,
             :SPEED].each do |s|
              if ivs[s] > val
                best = [s]
                val  = ivs[s]
              elsif ivs[s] == val
                best.push(s)
              end
            end
            CODE
          ),
          *script(
            <<~'CODE'
            pbSet(2, best)
            pbSet(3, val)
            data = GameData::Stat.get(best[0])
            pbSet(4, data.name)
            pbSet(5, best.length - 1)
            CODE
          ),
          *text(
            "\\bIncidentally, I would say the best potential lies in its ",
            "\\v[4] stat.",
          ),
          *repeat(
            commands: [
              *condition(
                variable: v(5),
                operation: ">",
                constant: 0,
                then: [
                  *script(
                    <<~'CODE'
                    best = pbGet(2)
                    best[0] = nil
                    best.compact!
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    num = {
                      :HP              => 0,
                      :ATTACK          => 1,
                      :DEFENSE         => 2,
                      :SPEED           => 3,
                      :SPECIAL_ATTACK  => 4,
                      :SPECIAL_DEFENSE => 5
                    }[best[0]]
                    pbSet(4, num)
                    CODE
                  ),
                  control_variables(v(5), "-=", constant: 1),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 1,
                    then: [
                      text("\\bAnd its Attack stat is also good."),
                    ],
                    else: condition(
                      variable: v(4),
                      operation: "==",
                      constant: 2,
                      then: [
                        text("\\bI see, its Defense stat is also good."),
                      ],
                      else: condition(
                        variable: v(4),
                        operation: "==",
                        constant: 3,
                        then: [
                          text("\\bWell, its Speed stat is also good."),
                        ],
                        else: condition(
                          variable: v(4),
                          operation: "==",
                          constant: 4,
                          then: [
                            text("\\bIts Special Attack stat is equally good."),
                          ],
                          else: condition(
                            variable: v(4),
                            operation: "==",
                            constant: 5,
                            then: [
                              text("\\bIts Special Defense stat is good as well."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                else: [
                  break_loop,
                ],
              ),
            ],
          ),
          *comment(
            "Show a message depending on the value of the ",
            "highest stat IV.",
          ),
          *condition(
            variable: v(3),
            operation: ">",
            constant: 30,
            then: [
              *text(
                "\\bIt can't be better in that regard. That's how I judged ",
                "it.",
              ),
            ],
            else: condition(
              variable: v(3),
              operation: ">",
              constant: 25,
              then: [
                text("\\bIt's fantastic in that regard. That's how I judged it."),
              ],
              else: condition(
                variable: v(3),
                operation: ">",
                constant: 15,
                then: [
                  text("\\bIt's very good in that regard. That's how I judged it."),
                ],
                else: [
                  *text(
                    "\\bIt's rather decent in that regard. That's how I judged ",
                    "it.",
                  ),
                ],
              ),
            ),
          ),
        ],
        choice2: [
          text("\\b...Oh? You don't need me to judge. I get it."),
        ],
      ),
    ],
  ),
)