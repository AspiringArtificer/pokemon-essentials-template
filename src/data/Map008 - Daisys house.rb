# Lappet Town (2)
#   Daisy's house (8)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Lappet Town", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 3,
      y: 9,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 2, x: 17, y: 7, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Daisy",
      x: 5,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "NPC 26",
        ),
        commands: [
          text("\\rDaisy: Hi, \\PN!"),
          *text(
            "\\rDaisy: Would you like me to groom one of your ",
            "Pokémon?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\rDaisy: Which Pokémon do you want me to groom?"),
              script("pbChooseNonEggPokemon(1, 2)"),
              *condition(
                variable: v(1),
                operation: "<",
                constant: 0,
                then: [
                  text("\\rDaisy: Oh, okay then."),
                  exit_event_processing,
                ],
              ),
              *script(
                <<~'CODE'
                pkmn = pbGetPokemon(1)
                pkmn.changeHappiness("groom")
                pkmn.beauty += 40
                CODE
              ),
              *text(
                "\\rDaisy: There! \\v[2] looks a lot happier and prettier ",
                "now!",
              ),
            ],
            choice2: [
              text("\\rDaisy: Oh, okay then."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Dr Footstep",
      x: 1,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "NPC 07",
        ),
        commands: [
          text("\\bDr. Footstep: Hi! I rate the footprints of Pokémon!"),
          text("\\bDr. Footstep: Can I rate your Pokémon for you?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *text(
                "\\bDr. Footstep: Which Pokémon do you want me to ",
                "rate?",
              ),
              script("pbChooseNonEggPokemon(1, 2)"),
              *condition(
                variable: v(1),
                operation: "<",
                constant: 0,
                then: [
                  text("\\bDr. Footstep: Maybe next time, then."),
                  exit_event_processing,
                ],
              ),
              *script(
                <<~'CODE'
                pkmn = pbGetPokemon(1)
                h = pkmn.happiness
                stage = 0
                stage = 1 if h >= 1
                stage = 2 if h >= 50
                stage = 3 if h >= 100
                stage = 4 if h >= 150
                stage = 5 if h >= 200
                stage = 6 if h >= 255
                pbSet(3, stage)
                CODE
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 0,
                then: [
                  *text(
                    "\\bDr. Footstep: By any chance, you... Are you a very ",
                    "strict person? I feel that your \\v[2] really doesn't like ",
                    "you...",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 1,
                then: [
                  *text(
                    "\\bDr. Footstep: Hmmm... Your \\v[2] may not like you ",
                    "very much.",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 2,
                then: [
                  *text(
                    "\\bDr. Footstep: The relationship is neither good nor ",
                    "bad... Your \\v[2] looks neutral.",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 3,
                then: [
                  *text(
                    "\\bDr. Footstep: Your \\v[2] is a little friendly to you... ",
                    "That's what I'm getting.",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 4,
                then: [
                  *text(
                    "\\bDr. Footstep: Your \\v[2] is friendly to you. It must be ",
                    "happy with you.",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 5,
                then: [
                  *text(
                    "\\bDr. Footstep: Your \\v[2] is quite friendly to you! You ",
                    "must be a kind person!",
                  ),
                ],
              ),
              *condition(
                variable: v(3),
                operation: "==",
                constant: 6,
                then: [
                  *text(
                    "\\bDr. Footstep: Your \\v[2] is super friendly to you! I'm ",
                    "a bit jealous!",
                  ),
                  *condition(
                    script: "!pbGetPokemon(1).hasRibbon?(:FOOTPRINT)",
                    then: [
                      text("\\bDr. Footstep: I shall reward your \\v[2] with a ribbon!"),
                      *script(
                        <<~'CODE'
                        pkmn = pbGetPokemon(1)
                        pkmn.giveRibbon(:FOOTPRINT)
                        CODE
                      ),
                      *text(
                        "\\PN received the Footprint Ribbon.",
                        "\\me[Item get]\\wtnp[20]",
                      ),
                      text("\\PN put the Footprint Ribbon on \\v[2]."),
                    ],
                  ),
                ],
              ),
            ],
            choice2: [
              text("\\bDr. Footstep: Maybe next time, then."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Effort ribbon giver",
      x: 2,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "NPC 04",
        ),
        commands: [
          *comment(
            "Looks at the total EVs of the lead Pokémon, and ",
            "rewards a ribbon to it if the total is maxed (equal to ",
            "Pokemon::EV_LIMIT, which is 510 by default).",
          ),
          *script(
            <<~'CODE'
            pkmn = $player.first_pokemon
            total = 0
            pkmn.ev.each_value { |v| total += v }
            maxed = 0
            if total >= Pokemon::EV_LIMIT
              maxed = 1
            end
            maxed = 2 if pkmn.hasRibbon?(:EFFORT)
            pbSet(1, pkmn.name)
            pbSet(2, maxed)
            CODE
          ),
          text("\\rOh?\\nYour \\v[1]..."),
          *condition(
            variable: v(2),
            operation: "==",
            constant: 2,
            then: [
              comment("Pokémon already has an Effort Ribbon."),
              text("\\rOh! Your \\v[1], that Effort Ribbon looks good on it!"),
            ],
            else: condition(
              variable: v(2),
              operation: "==",
              constant: 1,
              then: [
                *comment(
                  "Pokémon has full EVs and does not already have an ",
                  "Effort Ribbon - give it that ribbon.",
                ),
                text("\\rWent for it stupendously!"),
                text("\\rAs its reward, please give it this Effort Ribbon."),
                *script(
                  <<~'CODE'
                  pkmn = $player.first_pokemon
                  pkmn.giveRibbon(:EFFORT)
                  CODE
                ),
                *text(
                  "\\PN received the Effort Ribbon.",
                  "\\me[Item get]\\wtnp[20]",
                ),
                text("\\PN put the Effort Ribbon on \\v[1]."),
              ],
              else: [
                comment("Pokémon does not have full EVs."),
                text("\\rYou have to go for it a little harder."),
                text("\\rIf you do, I'll give your Pokémon something nice."),
              ],
            ),
          ),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Contest ribbon giver",
      x: 3,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "trainer_LADY",
        ),
        commands: [
          *comment(
            "Gives or upgrades a contest ribbon for the lead ",
            "Pokémon.",
            "The method upgradeRibbon either upgrades an ",
            "existing ribbon to the next one listed, or gives the ",
            "first ribbon if the Pokémon has none of them.",
            "Returns nil if couldn't add/upgrade a ribbon.",
          ),
          text("\\rHi! I'm the Contest Lady!"),
          text("\\rI give out contest ribbons. Do you want one?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *script(
                <<~'CODE'
                pkmn = $player.first_pokemon
                ret = pkmn.upgradeRibbon(
                  :HOENNCOOL,
                  :HOENNCOOLSUPER,
                  :HOENNCOOLHYPER,
                  :HOENNCOOLMASTER
                )
                CODE
              ),
              *script(
                <<~'CODE'
                pbSet(1, ret || :NONE)
                pbSet(2, pkmn.name)
                if ret
                  data = GameData::Ribbon.get(ret)
                  pbSet(3, data.name)
                end
                CODE
              ),
              *condition(
                script: "pbGet(1) == :NONE",
                then: [
                  *text(
                    "\\rSorry, your \\v[2] already has the highest ranked ",
                    "Cool Ribbon.",
                  ),
                ],
                else: [
                  *text(
                    "\\PN received the \\v[3].",
                    "\\me[Item get]\\wtnp[40]",
                  ),
                  text("\\PN put the \\v[3] on \\v[2]."),
                ],
              ),
            ],
            choice2: [
              text("\\rThat's your choice."),
            ],
          ),
        ],
      ),
    ),

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
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  542,  542,  542,  542,  542,  542,  542,
       424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  542,  542,  542,  542,  542,  542,  542,
       769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0, 1530, 1531,    0, 1712, 1491, 1492,    0, 1440,    0, 1504, 1505,    0,    0,    0,    0,    0,    0,    0,
      1569, 1570, 1538, 1539,    0, 1720, 1499, 1500,    0, 1448,    0, 1512, 1513,    0,    0,    0,    0,    0,    0,    0,
      1577, 1578, 1546, 1547,    0, 1728,    0,    0,    0,    0,    0, 1520, 1521,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1168, 1169, 1169, 1169, 1169, 1170,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1184, 1185, 1185, 1185, 1185, 1186,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,
      1778,    0, 1245, 1246, 1247,    0,    0,    0,    0,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1674, 2083, 2085, 1675,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1674, 2091, 2093, 1675,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
