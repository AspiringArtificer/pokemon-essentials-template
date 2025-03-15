# Battle Frontier (52)
#   Battle Palace (58)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Battle Frontier", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 7,
      y: 8,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 52, x: 8, y: 9, direction: :down, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "PC",
      x: 7,
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
      name: "Single battles NPC",
      x: 3,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "trainer_GAMBLER",
        ),
        commands: [
          text("\\bWelcome to the Battle Palace."),
          text("\\bWould you like to participate in a single battle?"),
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
                      "palacesingle",
                      7,
                      pbBattlePalaceRules(false, false)
                    )
                    CODE
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "palacesingleopen",
                      7,
                      pbBattlePalaceRules(false, true)
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
                  transfer_player(map: 59, x: 2, y: 8, direction: :retain, fading: false),
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
          name: "trainer_GAMBLER",
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
                    points = 3 + ((rounds + 1) / 2)
                    points = 15 if points > 15
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
              transfer_player(map: 59, x: 2, y: 8, direction: :retain, fading: false),
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
      name: "Double battles NPC",
      x: 11,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "trainer_GAMBLER",
        ),
        commands: [
          text("\\bWelcome to the Battle Palace."),
          text("\\bWould you like to participate in a double battle?"),
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
                      "palacedouble",
                      7,
                      pbBattlePalaceRules(true, false)
                    )
                    CODE
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "palacedoubleopen",
                      7,
                      pbBattlePalaceRules(true, true)
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
              text("\\bPlease choose the four Pokémon that will enter."),
              *condition(
                script: "!pbEntryScreen(4, 100)",
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
                  transfer_player(map: 59, x: 2, y: 8, direction: :retain, fading: false),
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
          name: "trainer_GAMBLER",
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
                    points = 4 + ((rounds + 1) / 2)
                    points = 15 if points > 15
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
              transfer_player(map: 59, x: 2, y: 8, direction: :retain, fading: false),
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
      id: 5,
      name: "Single results",
      x: 5,
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
                  "palacesingle")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "palacesingle")
                )
                CODE
              ),
              text("\\PN's Battle Palace Level 50 Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice2: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "palacesingleopen")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "palacesingleopen")
                )
                CODE
              ),
              text("\\PN's Battle Palace Open Level Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Doubles results",
      x: 13,
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
                  "palacedouble")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "palacedouble")
                )
                CODE
              ),
              text("\\PN's Battle Palace Level 50 Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice2: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "palacedoubleopen")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "palacedoubleopen")
                )
                CODE
              ),
              text("\\PN's Battle Palace Open Level Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 7,
      name: "Battle recorder",
      x: 8,
      y: 3,
      page_0: page(
        commands: [
          *condition(
            character: player,
            facing: :up,
            else: [
              exit_event_processing,
            ],
          ),
          *show_choices(
            choices: ["Battle Palace rules", "Play recorded battle", "Cancel"],
            cancellation: 3,
            choice1: [
              label("Top"),
              text("Which heading do you want to read?"),
              *show_choices(
                choices: ["Battle basics", "Pokémon nature", "Pokémon moves", "Underpowered"],
                cancellation: 0,
                choice1: [
                  *text(
                    "In the Battle Palace, Pokémon are required to think by ",
                    "themselves.",
                  ),
                  *text(
                    "Unlike in the wild, Pokémon that live with people ",
                    "behave differently depending on their nature.",
                  ),
                  jump_label("Choices"),
                ],
                choice2: [
                  *text(
                    "Depending on its nature, a Pokémon may prefer to ",
                    "attack no matter what.",
                  ),
                  *text(
                    "Another Pokémon may prefer to protect itself from ",
                    "harm.",
                  ),
                  *text(
                    "Yet another may enjoy vexing or confounding its ",
                    "foes.",
                  ),
                  *text(
                    "A Pokémon's nature determines which moves it is ",
                    "good at using, and which moves it has trouble using.",
                  ),
                  jump_label("Choices"),
                ],
                choice3: [
                  *text(
                    "There are offensive moves that deal direct damage ",
                    "on the foe.",
                  ),
                  *text(
                    "There are defensive moves that are used to prepare ",
                    "for enemy attacks or used to heal HP and so on.",
                  ),
                  *text(
                    "And there are other somewhat-odd moves that may ",
                    "enfeeble the foe with status problems including ",
                    "poison and paralysis.",
                  ),
                  *text(
                    "Pokémon will consider using moves in these three ",
                    "categories.",
                  ),
                  jump_label("Choices"),
                ],
                choice4: [
                  *text(
                    "When not taking commands from its Trainer, a ",
                    "Pokémon may be unable to effectively use certain ",
                    "kinds of moves.",
                  ),
                  *text(
                    "A Pokémon is not good at using any move that it ",
                    "dislikes.",
                  ),
                  *text(
                    "If a Pokémon only knows moves that don't conform ",
                    "to its nature, it will often be unable to live up to its ",
                    "potential.",
                  ),
                  jump_label("Choices"),
                ],
              ),
              *show_choices(
                choices: ["When in danger", "Exit"],
                cancellation: 2,
                choice1: [
                  *text(
                    "Depending on its nature, a Pokémon may start using ",
                    "moves that don't match its nature when it is in ",
                    "trouble.",
                  ),
                  *text(
                    "If a Pokémon begins behaving oddly in a pinch, watch ",
                    "it carefully.",
                  ),
                  jump_label("Choices"),
                ],
              ),
            ],
            choice2: [
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

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       456,  457,  457,  457,  457,  457,  458,  459,  456,  457,  457,  457,  457,  457,  458,  542,  542,  542,  542,  542,
       464,  465,  465,  465,  465,  465,  466,  467,  464,  465,  465,  465,  465,  465,  466,  542,  542,  542,  542,  542,
       737,  737,  755,  745,  745,  737,  737,  475,  737,  737,  755,  745,  745,  737,  737,  542,  542,  542,  542,  542,
       738,  737,  737,  739,  737,  737,  738,  483,  738,  737,  737,  739,  737,  737,  738,  542,  542,  542,  542,  542,
       738,  753,  745,  746,  753,  745,  746,  735,  737,  755,  745,  746,  753,  745,  746,  542,  542,  542,  542,  542,
       738,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  542,  542,  542,  542,  542,
       738,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  542,  542,  542,  542,  542,
       738,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,  389,  390,  391,    0,    0,    0,    0,    0,  389,  390,  391,    0,    0,    0,    0,    0,    0,    0,
         0, 2008,  397,  398,  399, 2008,    0,    0,    0, 2008,  397,  398,  399, 2008,    0,    0,    0,    0,    0,    0,
       472, 2017, 2003,    0, 2001, 2019,  474, 1693,  472, 2017, 2003,    0, 2001, 2019,  474,    0,    0,    0,    0,    0,
         0, 2025, 2027,    0, 2025, 2027,    0, 1701, 1725, 2025, 2027,    0, 2025, 2027,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0, 1709, 1733,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1859,    0,    0, 1695,    0,    0,    0,    0, 1859,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1867,    0,    0, 1703,    0,    0,    0,    0, 1867,    0,    0,    0,    0,    0,    0,
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
