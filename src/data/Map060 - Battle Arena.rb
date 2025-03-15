# Battle Frontier (52)
#   Battle Arena (60)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Battle Frontier", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 5,
      y: 8,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 52, x: 9, y: 23, direction: :down, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "PC",
      x: 1,
      y: 3,
      page_0: page(
        commands: condition(
          character: player,
          facing: :up,
          then: [
            script("pbPokeCenterPC"),
          ],
        ),
      ),
    ),

    event(
      id: 3,
      name: "NPC",
      x: 5,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "trainer_BLACKBELT",
        ),
        commands: [
          text("\\bWelcome to the Battle Arena."),
          text("\\bWould you like to participate in a battle?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *text(
                "\\bDo you want to take the Level 50 challenge, or the ",
                "Open Level challenge?",
              ),
              *show_choices(
                choices: ["Level 50", "Open Level", "Cancel"],
                cancellation: 3,
                choice1: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "arena",
                      7,
                      pbBattleArenaRules(false)
                    )
                    CODE
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "arenaopen",
                      7,
                      pbBattleArenaRules(true)
                    )
                    CODE
                  ),
                ],
                choice3: [
                  jump_label("End"),
                ],
              ),
              comment("Has 3 or more eligible Pokemon level 100 or less?"),
              *condition(
                script: "!pbHasEligible?(3, 100)",
                then: [
                  *text(
                    "\\bSorry, you can't participate. You need three ",
                    "different Pokémon to enter.",
                  ),
                  *text(
                    "\\bThey must be of a different species and hold ",
                    "different items.",
                  ),
                  *text(
                    "\\bCertain exotic species, as well as eggs, are ",
                    "ineligible.",
                  ),
                  jump_label("End"),
                ],
              ),
              text("\\bPlease choose the three Pokémon that will enter."),
              *condition(
                script: "!pbEntryScreen(3, 100)",
                then: [
                  jump_label("End"),
                ],
              ),
              *condition(
                script: "pbSaveScreen",
                then: [
                  text("\\bPlease come this way."),
                  script("pbBattleChallenge.start"),
                  *move_route(
                    this,
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    move_up,
                    change_opacity(0),
                    through_off,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    move_up,
                    move_up,
                    change_opacity(0),
                    through_off,
                  ),
                  wait_completion,
                  play_se(audio(name: "Door exit", volume: 80)),
                  change_tone(red: -255, green: -255, blue: -255, frames: 6),
                  wait(8),
                  transfer_player(map: 61, x: 0, y: 5, direction: :right, fading: false),
                  change_tone(red: 0, green: 0, blue: 0, frames: 6),
                ],
                else: [
                  jump_label("End"),
                ],
              ),
            ],
            choice2: [
              label("End"),
              text("\\bCome back another time."),
              script("pbBattleChallenge.pbCancel"),
              exit_event_processing,
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(28),
        graphic: graphic(
          name: "trainer_BLACKBELT",
        ),
        trigger: :autorun,
        commands: [
          comment("If Won"),
          *condition(
            script: "pbBattleChallenge.decision == 1",
            then: [
              text("\\bCongratulations for winning."),
              *condition(
                script: "$player.battle_points < Settings::MAX_BATTLE_POINTS",
                then: [
                  text("\\bPlease accept these Battle Point(s)."),
                  *script(
                    <<~'CODE'
                    rounds = pbBattleChallenge.wins / 7
                    arr = [
                      1, 1, 1, 2, 2, 2, 3, 3, 4, 4,
                      5, 6, 7, 8, 9, 10, 11, 12, 13, 14
                    ]
                    points = arr[rounds - 1] || 15
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    max = Settings::MAX_BATTLE_POINTS
                    points = [
                      max - $player.battle_points,
                      points
                    ].min
                    pbSet(1, points)
                    CODE
                  ),
                  *script(
                    <<~'CODE'
                    $player.battle_points += points
                    $stats.battle_points_won += points
                    CODE
                  ),
                  play_me(audio(name: "BP get")),
                  text("\\PN obtained \\v[1] Battle Point(s)."),
                ],
              ),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\bWould you like to record your last battle?"),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      script("pbRecordLastBattle"),
                      text("\\se[Pkmn exp full]The battle was recorded."),
                    ],
                  ),
                ],
              ),
              text("Your results will be recorded.\\wtnp[15]"),
              script("pbBattleChallenge.pbEnd"),
              text("\\bCome back another time."),
              exit_event_processing,
            ],
          ),
          comment("If Lost or Forfeited"),
          *condition(
            script: "pbBattleChallenge.decision == 2",
            then: [
              text("\\bThanks for playing."),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\bWould you like to record your last battle?"),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      script("pbRecordLastBattle"),
                      text("\\se[Pkmn exp full]The battle was recorded."),
                    ],
                  ),
                ],
              ),
              text("Your results will be recorded.\\wtnp[15]"),
              script("pbBattleChallenge.pbEnd"),
              text("\\bCome back another time."),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "pbBattleChallenge.pbResting?",
            then: [
              *text(
                "\\bWe've been waiting for you. Please come this ",
                "way.",
              ),
              script("pbBattleChallenge.pbGoOn"),
              *move_route(
                this,
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              wait_completion,
              play_se(audio(name: "Door exit", volume: 80)),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 61, x: 0, y: 5, direction: :right, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            else: [
              *text(
                "\\bExcuse me, but you didn't save before finishing ",
                "your challenge last time.",
              ),
              text("\\bSorry, but your challenge has been canceled."),
              script("pbBattleChallenge.pbEnd"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Results",
      x: 7,
      y: 3,
      page_0: page(
        commands: [
          text("Check results for which challenge?"),
          *show_choices(
            choices: ["Level 50", "Open Level", "Cancel"],
            cancellation: 3,
            choice1: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "arena")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "arena")
                )
                CODE
              ),
              text("\\PN's Battle Arena Level 50 results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice2: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "arenaopen")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "arenaopen")
                )
                CODE
              ),
              text("\\PN's Battle Arena Open Level results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Battle recorder",
      x: 9,
      y: 3,
      page_0: page(
        commands: condition(
          character: player,
          facing: :up,
          then: [
            *show_choices(
              choices: ["Play recorded battle", "Exit"],
              cancellation: 2,
              choice1: [
                *condition(
                  script: "$PokemonGlobal.lastbattle != nil",
                  then: [
                    script("pbPlayLastBattle"),
                  ],
                  else: [
                    text("There is no battle recorded."),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       392,  392,  392,  392,  392,  392,  392,  392,  392,  392,  392,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1059, 1065, 1065, 1059, 1065, 1065, 1065, 1065, 1065, 1059, 1065,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1058, 1048, 1048, 1048, 1048, 1050, 1048, 1048, 1048, 1057, 1050,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1058, 1057, 1059, 1065, 1065, 1066, 1065, 1065, 1065, 1057, 1058,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1058, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1058, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1058, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,    0,    0,  389,  390,  391,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1972,    0,  397,  398,  399,    0, 1972,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770, 1693, 1981, 1966, 1184, 1185, 1186, 1966, 1983,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1778, 1701, 1989, 1990, 1991,    0, 1989, 1990, 1991, 1725, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1709,    0,    0,    0,    0,    0,    0,    0, 1733,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1967,    0, 1965, 1859,    0, 1695,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0, 1867,    0, 1703,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
