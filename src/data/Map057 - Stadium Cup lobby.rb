# Battle Frontier (52)
#   Battle Tower (55)
#     Stadium Cup lobby (57)
map(
  tileset_id: 20,
  autoplay_bgm: true,
  bgm: audio(name: "Battle Frontier", volume: 80),
  events: [

    event(
      id: 1,
      name: "Stairs to Battle Tower",
      x: 17,
      y: 11,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *move_route(
            player,
            through_on,
            always_on_top_on,
            turn_right,
            move_right,
            through_off,
            always_on_top_off,
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 55, x: 16, y: 11, direction: :left, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "PC",
      x: 5,
      y: 8,
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
      x: 2,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "NPC 23",
        ),
        commands: [
          *text(
            "\\rWelcome to the Battle Tower's Stadium Cup ",
            "Division.",
          ),
          text("\\rWould you like to participate in a single battle?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\rWhich Stadium Cup would you like to enter?"),
              *show_choices(
                choices: ["Pika Cup", "Fancy Cup"],
                cancellation: 0,
                choice1: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "pikacupsingle",
                      7,
                      pbPikaCupRules(false)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 15 to 20 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rCertain exotic species, as well as eggs, are ",
                        "ineligible.",
                      ),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "fancycupsingle",
                      7,
                      pbFancyCupRules(false)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 25 to 30 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rThey also must be baby Pokémon, and can't be",
                        "too tall or too heavy.",
                      ),
                      text("\\rEggs are ineligible."),
                      jump_label("End"),
                    ],
                  ),
                ],
              ),
              *show_choices(
                choices: ["Poké Cup", "Little Cup", "Cancel"],
                cancellation: 3,
                choice1: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "pokecupsingle",
                      7,
                      pbPokeCupRules(false)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 50 to 55 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rCertain exotic species, as well as eggs, are ",
                        "ineligible.",
                      ),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "littlecupsingle",
                      7,
                      pbLittleCupRules(false)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different baby Pokémon at level 5 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rThey also must be baby Pokémon that are",
                        "capable of evolving.",
                      ),
                      text("\\rEggs are ineligible."),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice3: [
                  jump_label("End"),
                ],
              ),
              text("\\rPlease choose the three Pokémon that will enter."),
              *condition(
                script: "!pbEntryScreen",
                then: [
                  jump_label("End"),
                ],
              ),
              *condition(
                script: "pbSaveScreen",
                then: [
                  text("\\rPlease come this way."),
                  script("pbBattleChallenge.start"),
                  *move_route(
                    this,
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    through_off,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    through_off,
                  ),
                  wait_completion,
                  *move_route(
                    character(8),
                    route_play_se(audio(name: "Door slide")),
                    route_wait(2),
                    turn_left,
                    route_wait(2),
                    turn_right,
                    route_wait(2),
                    turn_up,
                    route_wait(2),
                    skippable: true,
                  ),
                  wait_completion,
                  *move_route(
                    this,
                    through_on,
                    move_up,
                    change_opacity(0),
                    through_off,
                    skippable: true,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    route_wait(4),
                    move_up,
                    move_up,
                    change_opacity(0),
                    through_off,
                  ),
                  wait_completion,
                  change_transparent_flag(:transparent),
                  *move_route(
                    character(8),
                    route_wait(2),
                    turn_right,
                    route_wait(2),
                    turn_left,
                    route_wait(2),
                    turn_down,
                    route_wait(2),
                    skippable: true,
                  ),
                  wait_completion,
                  change_tone(red: -255, green: -255, blue: -255, frames: 6),
                  wait(8),
                  change_transparent_flag(:normal),
                  transfer_player(map: 56, x: 0, y: 6, direction: :right, fading: false),
                  change_tone(red: 0, green: 0, blue: 0, frames: 6),
                ],
                else: [
                  jump_label("End"),
                ],
              ),
            ],
            choice2: [
              label("End"),
              text("\\rCome back another time."),
              script("pbBattleChallenge.pbCancel"),
              exit_event_processing,
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(28),
        graphic: graphic(
          name: "NPC 23",
        ),
        trigger: :autorun,
        commands: [
          comment("If Won"),
          *condition(
            script: "pbBattleChallenge.decision == 1",
            then: [
              text("\\rCongratulations for winning."),
              *condition(
                script: "$player.battle_points < Settings::MAX_BATTLE_POINTS",
                then: [
                  text("\\rPlease accept these Battle Point(s)."),
                  *script(
                    <<~'CODE'
                    rounds = pbBattleChallenge.wins / 7
                    points = rounds
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
                  play_me(audio(name: "Item get")),
                  text("\\PN obtained \\v[1] Battle Point(s)."),
                ],
              ),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\rWould you like to record your last battle?"),
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
              text("\\rCome back another time."),
              exit_event_processing,
            ],
          ),
          comment("If Lost or Forfeited"),
          *condition(
            script: "pbBattleChallenge.decision == 2",
            then: [
              text("\\rThanks for playing."),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\rWould you like to record your last battle?"),
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
              text("\\rCome back another time."),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "pbBattleChallenge.pbResting?",
            then: [
              text("\\rWe've been waiting for you. Please come this way."),
              script("pbBattleChallenge.pbGoOn"),
              *move_route(
                this,
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                through_off,
              ),
              wait_completion,
              *move_route(
                character(8),
                route_play_se(audio(name: "Door slide")),
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_right,
                route_wait(2),
                turn_up,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
              *move_route(
                this,
                through_on,
                move_up,
                change_opacity(0),
                through_off,
                skippable: true,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                route_wait(4),
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              wait_completion,
              change_transparent_flag(:transparent),
              *move_route(
                character(8),
                route_wait(2),
                turn_right,
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_down,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              change_transparent_flag(:normal),
              transfer_player(map: 56, x: 0, y: 6, direction: :right, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            else: [
              *text(
                "\\rExcuse me, but you didn't save before finishing ",
                "your challenge last time.",
              ),
              text("\\rSorry, but your challenge has been canceled."),
              script("pbBattleChallenge.pbEnd"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Double battles NPC",
      x: 16,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "NPC 23",
        ),
        commands: [
          *text(
            "\\rWelcome to the Battle Tower's Stadium Cup ",
            "Division.",
          ),
          text("\\rWould you like to participate in a double battle?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\rWhich Stadium Cup would you like to enter?"),
              *show_choices(
                choices: ["Pika Cup", "Fancy Cup"],
                cancellation: 0,
                choice1: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "pikacupdouble",
                      7,
                      pbPikaCupRules(true)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 15 to 20 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rCertain exotic species, as well as eggs, are ",
                        "ineligible.",
                      ),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "fancycupdouble",
                      7,
                      pbFancyCupRules(true)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 25 to 30 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rThey also must be baby Pokémon, and can't be",
                        "too tall or too heavy.",
                      ),
                      text("\\rEggs are ineligible."),
                      jump_label("End"),
                    ],
                  ),
                ],
              ),
              *show_choices(
                choices: ["Poké Cup", "Little Cup", "Cancel"],
                cancellation: 3,
                choice1: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "pokecupdouble",
                      7,
                      pbPokeCupRules(true)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different Pokémon level 50 to 55 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rCertain exotic species, as well as eggs, are ",
                        "ineligible.",
                      ),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice2: [
                  *script(
                    <<~'CODE'
                    pbBattleChallenge.set(
                      "littlecupdouble",
                      7,
                      pbLittleCupRules(true)
                    )
                    CODE
                  ),
                  *condition(
                    script: "!pbHasEligible?(3, 100)",
                    then: [
                      *text(
                        "\\rSorry, you can't participate. You need three ",
                        "different baby Pokémon at level 5 to enter.",
                      ),
                      *text(
                        "\\rThey must be of a different species and hold ",
                        "different items.",
                      ),
                      *text(
                        "\\rThey also must be baby Pokémon that are",
                        "capable of evolving.",
                      ),
                      text("\\rEggs are ineligible."),
                      jump_label("End"),
                    ],
                  ),
                ],
                choice3: [
                  jump_label("End"),
                ],
              ),
              text("\\rPlease choose the Pokémon that will enter."),
              *condition(
                script: "!pbEntryScreen",
                then: [
                  jump_label("End"),
                ],
              ),
              *condition(
                script: "pbSaveScreen",
                then: [
                  text("\\rPlease come this way."),
                  script("pbBattleChallenge.start"),
                  *move_route(
                    this,
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    through_off,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    route_wait(4),
                    turn_up,
                    move_up,
                    through_off,
                  ),
                  wait_completion,
                  *move_route(
                    character(9),
                    route_play_se(audio(name: "Door slide")),
                    route_wait(2),
                    turn_left,
                    route_wait(2),
                    turn_right,
                    route_wait(2),
                    turn_up,
                    route_wait(2),
                    skippable: true,
                  ),
                  wait_completion,
                  *move_route(
                    this,
                    through_on,
                    move_up,
                    change_opacity(0),
                    through_off,
                    skippable: true,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    route_wait(4),
                    move_up,
                    move_up,
                    change_opacity(0),
                    through_off,
                  ),
                  wait_completion,
                  change_transparent_flag(:transparent),
                  *move_route(
                    character(9),
                    route_wait(2),
                    turn_right,
                    route_wait(2),
                    turn_left,
                    route_wait(2),
                    turn_down,
                    route_wait(2),
                    skippable: true,
                  ),
                  wait_completion,
                  change_tone(red: -255, green: -255, blue: -255, frames: 6),
                  wait(8),
                  change_transparent_flag(:normal),
                  transfer_player(map: 56, x: 0, y: 6, direction: :right, fading: false),
                  change_tone(red: 0, green: 0, blue: 0, frames: 6),
                ],
                else: [
                  jump_label("End"),
                ],
              ),
            ],
            choice2: [
              label("End"),
              text("\\rCome back another time."),
              script("pbBattleChallenge.pbCancel"),
              exit_event_processing,
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(28),
        graphic: graphic(
          name: "NPC 23",
        ),
        trigger: :autorun,
        commands: [
          comment("If Won"),
          *condition(
            script: "pbBattleChallenge.decision == 1",
            then: [
              text("\\rCongratulations for winning."),
              *condition(
                script: "$player.battle_points < Settings::MAX_BATTLE_POINTS",
                then: [
                  text("\\rPlease accept these Battle Point(s)."),
                  *script(
                    <<~'CODE'
                    rounds = pbBattleChallenge.wins / 7
                    points = rounds + 1
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
                  play_me(audio(name: "Item get")),
                  text("\\PN obtained \\v[1] Battle Point(s)."),
                ],
              ),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\rWould you like to record your last battle?"),
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
              text("\\rCome back another time."),
              exit_event_processing,
            ],
          ),
          comment("If Lost or Forfeited"),
          *condition(
            script: "pbBattleChallenge.decision == 2",
            then: [
              text("\\rThanks for playing."),
              *condition(
                script: "$game_temp.last_battle_record != nil",
                then: [
                  text("\\rWould you like to record your last battle?"),
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
              text("\\rCome back another time."),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "pbBattleChallenge.pbResting?",
            then: [
              text("\\rWe've been waiting for you. Please come this way."),
              script("pbBattleChallenge.pbGoOn"),
              *move_route(
                this,
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                route_wait(4),
                turn_up,
                move_up,
                through_off,
              ),
              wait_completion,
              *move_route(
                character(9),
                route_play_se(audio(name: "Door slide")),
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_right,
                route_wait(2),
                turn_up,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
              *move_route(
                this,
                through_on,
                move_up,
                change_opacity(0),
                through_off,
                skippable: true,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                route_wait(4),
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              wait_completion,
              change_transparent_flag(:transparent),
              *move_route(
                character(9),
                route_wait(2),
                turn_right,
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_down,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              change_transparent_flag(:normal),
              transfer_player(map: 56, x: 0, y: 6, direction: :right, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            else: [
              *text(
                "\\rExcuse me, but you didn't save before finishing ",
                "your challenge last time.",
              ),
              text("\\rSorry, but your challenge has been canceled."),
              script("pbBattleChallenge.pbEnd"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Singles results",
      x: 4,
      y: 3,
      page_0: page(
        commands: [
          text("Check results for which singles challenge?"),
          *show_choices(
            choices: ["Pika Cup", "Fancy Cup", "Poké Cup"],
            cancellation: 0,
            choice1: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "pikacupsingle")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "pikacupsingle")
                )
                CODE
              ),
              text("\\PN's Battle Tower Pika Cup Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice2: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "fancycupsingle")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "fancycupsingle")
                )
                CODE
              ),
              text("\\PN's Battle Tower Fancy Cup Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice3: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "pokecupsingle")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "pokecupsingle")
                )
                CODE
              ),
              text("\\PN's Battle Tower Poké Cup Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
          *show_choices(
            choices: ["Little Cup", "Cancel"],
            cancellation: 2,
            choice1: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "littlecupsingle")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "littlecupsingle")
                )
                CODE
              ),
              text("\\PN's Battle Tower Little Cup Single Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Doubles results",
      x: 18,
      y: 3,
      page_0: page(
        commands: [
          text("Check results for which doubles challenge?"),
          *show_choices(
            choices: ["Pika Cup", "Fancy Cup", "Poké Cup"],
            cancellation: 0,
            choice1: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "pikacupdouble")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "pikacupdouble")
                )
                CODE
              ),
              text("\\PN's Battle Tower Pika Cup Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice2: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "fancycupdouble")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "fancycupdouble")
                )
                CODE
              ),
              text("\\PN's Battle Tower Fancy Cup Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
            choice3: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "pokecupdouble")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "pokecupdouble")
                )
                CODE
              ),
              text("\\PN's Battle Tower Poké Cup Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
          *show_choices(
            choices: ["Little Cup", "Cancel"],
            cancellation: 2,
            choice1: [
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.getPreviousWins(
                  "littlecupdouble")
                )
                pbSet(2,
                  pbBattleChallenge.getMaxWins(
                  "littlecupdouble")
                )
                CODE
              ),
              text("\\PN's Battle Tower Little Cup Double Battle results:"),
              text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 7,
      name: "Battle recorder",
      x: 13,
      y: 8,
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
            choices: ["Stadium Cup rules", "Play recorded battle", "Cancel"],
            cancellation: 3,
            choice1: [
              label("Top"),
              text("Which heading would you like to read?"),
              *show_choices(
                choices: ["Stadium Cups", "Pika Cup", "Fancy Cup", "Poké Cup"],
                cancellation: 0,
                choice1: [
                  *text(
                    "This facility lets you conduct battles similar to Stadium ",
                    "championships.",
                  ),
                  *text(
                    "This facility holds battles for Pika Cup, Fancy Cup,",
                    "Poké Cup, and Little Cup. Each cup has its own rules ",
                    "and restrictions.",
                  ),
                  jump_label("Top"),
                ],
                choice2: [
                  text("The Pika Cup is open to Pokémon level 15 to 20."),
                  *text(
                    "Choose three Pokémon to enter.\\n",
                    "However, the total level of all three can't be higher ",
                    "than 50.",
                  ),
                  text("Also, certain exotic kinds of Pokémon may not enter."),
                  jump_label("Top"),
                ],
                choice3: [
                  text("The Fancy Cup is open to baby Pokémon level 25 to 30."),
                  *text(
                    "Choose three Pokémon to enter.\\n",
                    "However, the total level of all three can't be higher ",
                    "than 80.",
                  ),
                  *text(
                    "Also, very huge or very tall Pokémon may not enter",
                    "the Fancy Cup.",
                  ),
                  *text(
                    "The height limit is 2 meters, and the weight limit is 20",
                    "kilograms for the Fancy Cup.",
                  ),
                  jump_label("Top"),
                ],
                choice4: [
                  text("The Poké Cup is open to Pokémon level 50 to 55."),
                  *text(
                    "Choose three Pokémon to enter.\\n",
                    "However, the total level of all three can't be higher",
                    "than 155.",
                  ),
                  text("Also, certain exotic kinds of Pokémon may not enter."),
                  jump_label("Top"),
                ],
              ),
              *show_choices(
                choices: ["Little Cup", "Battle rules", "Exit"],
                cancellation: 3,
                choice1: [
                  *text(
                    "The Little Cup is open to baby Pokémon at level 5",
                    "that are capable of evolving.",
                  ),
                  *text(
                    "Choose three Pokémon to enter a single battle,",
                    "or four for a double battle.",
                  ),
                  *text(
                    "Also, in the Little Cup, moves that deal a set",
                    "amount of damage, like Dragon Rage and SonicBoom,",
                    "will always miss.",
                  ),
                  jump_label("Top"),
                ],
                choice2: [
                  text("In Stadium Cups, there are several rules to keep in mind."),
                  *text(
                    "First, two Pokémon in the same team can't be both",
                    "asleep or both frozen at the same time.",
                  ),
                  *text(
                    "Also, you can't choose two of the same kind of",
                    "Pokémon, or two Pokémon holding the same item.",
                  ),
                  *text(
                    "Finally, if a Pokémon uses Selfdestruct or Explosion to",
                    "make all remaining Pokémon faint at the same time, that",
                    "Pokémon's trainer loses.",
                  ),
                  jump_label("Top"),
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

    event(
      id: 8,
      name: "Elevator door singles",
      x: 2,
      y: 1,
      page_0: page(
        graphic: graphic(
          name: "doors9",
          pattern: 1,
        ),
      ),
    ),

    event(
      id: 9,
      name: "Elevator door doubles",
      x: 16,
      y: 1,
      page_0: page(
        graphic: graphic(
          name: "doors9",
          pattern: 1,
        ),
      ),
    ),

    event(
      id: 10,
      name: "Healing balls",
      x: 7,
      y: 7,
      page_0: page(
        move_speed: 4,
        walk_anime: false,
      ),
      page_1: page(
        variable: v(6),
        at_least: 1,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :left,
        ),
        walk_anime: false,
      ),
      page_2: page(
        variable: v(6),
        at_least: 2,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :right,
        ),
        walk_anime: false,
      ),
      page_3: page(
        variable: v(6),
        at_least: 3,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :up,
        ),
        walk_anime: false,
      ),
      page_4: page(
        variable: v(6),
        at_least: 4,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :left,
        ),
        walk_anime: false,
      ),
      page_5: page(
        variable: v(6),
        at_least: 5,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :right,
        ),
        walk_anime: false,
      ),
      page_6: page(
        variable: v(6),
        at_least: 6,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :up,
        ),
        walk_anime: false,
      ),
    ),

    event(
      id: 11,
      name: "Nurse",
      x: 9,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 16",
        ),
        commands: [
          *comment(
            "This line of code sets the player's current position as ",
            "the spot they will return to after they lose a battle ",
            "and lack out.",
            "Page 2 of this event detects when this happens, and ",
            "heals the player's Pokémon and wishes them better ",
            "luck in future.",
          ),
          script("pbSetPokemonCenter"),
          text("\\rHello, and welcome to the Pokémon Center."),
          text("\\rWe restore your tired Pokémon to full health."),
          text("\\rWould you like to rest your Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\rOK, I'll take your Pokémon for a few seconds."),
              script("$stats.poke_center_count += 1"),
              recover_all(0),
              comment("Nurse turns to face the healing machine."),
              *move_route(
                this,
                turn_left,
                route_wait(2),
              ),
              wait_completion,
              *comment(
                "Nurse places Poké Balls on the healing machine one at ",
                "a time.",
              ),
              control_variables(v(1), property: :party_members),
              control_variables(v(6), constant: 0),
              label("Place ball"),
              control_variables(v(6), "+=", constant: 1),
              play_se(audio(name: "Battle ball shake", volume: 80)),
              wait(8),
              *condition(
                variable: v(6),
                operation: "<",
                other_variable: v(1),
                then: [
                  jump_label("Place ball"),
                ],
              ),
              comment("Healing animation and ME jingle."),
              *move_route(
                character(10),
                step_anime_on,
              ),
              play_me(audio(name: "Pkmn healing")),
              wait(58),
              *comment(
                "Poké Balls are removed from healing machine, nurse ",
                "turns to face the player.",
              ),
              control_variables(v(6), constant: 0),
              script("get_character(10).pattern = 0"),
              *move_route(
                character(10),
                step_anime_off,
              ),
              *move_route(
                this,
                route_wait(15),
                turn_down,
              ),
              wait_completion,
              comment("Pokérus check."),
              *condition(
                script: "pbPokerus?",
                then: [
                  text("\\rYour Pokémon may be infected by Pokérus."),
                  *text(
                    "\\rLittle is known about the Pokérus except that they ",
                    "are microscopic life-forms that attach to Pokémon.",
                  ),
                  *text(
                    "\\rWhile infected, Pokémon are said to grow ",
                    "exceptionally well.",
                  ),
                  control_switches(s(2), :ON),
                ],
                else: [
                  text("\\rThank you for waiting."),
                  text("\\rWe've restored your Pokémon to full health."),
                  comment("Nurse bows."),
                  *move_route(
                    this,
                    change_graphic(name: "NPC 16", pattern: 1),
                    route_wait(10),
                    change_graphic(name: "NPC 16"),
                  ),
                  wait_completion,
                  text("\\rWe hope to see you again!"),
                ],
              ),
            ],
            choice2: [
              text("\\rWe hope to see you again!"),
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(1),
        graphic: graphic(
          name: "NPC 16",
        ),
        trigger: :autorun,
        commands: [
          *comment(
            "Every map you can end up in after having all your ",
            "Pokémon faint (typically Poké Centers and home) ",
            "must have an Autorun event in it like this one.",
            "This event fully heals all the player's Pokémon, says ",
            "something to that effect, and turns the \"Starting ",
            "over\" switch OFF again.",
          ),
          *comment(
            "For convenience, this can be a single page in an ",
            "NPC's event (e.g. Mom, a nurse).",
          ),
          *text(
            "\\rFirst, you should restore your Pokémon to full ",
            "health.",
          ),
          script("$stats.poke_center_count += 1"),
          recover_all(0),
          comment("Nurse turns to face the healing machine."),
          *move_route(
            this,
            turn_left,
            route_wait(2),
          ),
          wait_completion,
          *comment(
            "Nurse places Poké Balls on the healing machine one at ",
            "a time.",
          ),
          control_variables(v(1), property: :party_members),
          control_variables(v(6), constant: 0),
          label("Place ball"),
          control_variables(v(6), "+=", constant: 1),
          play_se(audio(name: "Battle ball shake", volume: 80)),
          wait(8),
          *condition(
            variable: v(6),
            operation: "<",
            other_variable: v(1),
            then: [
              jump_label("Place ball"),
            ],
          ),
          comment("Healing animation and ME jingle."),
          *move_route(
            character(10),
            step_anime_on,
          ),
          play_me(audio(name: "Pkmn healing")),
          wait(58),
          *comment(
            "Poké Balls are removed from healing machine, nurse ",
            "turns to face the player.",
          ),
          control_variables(v(6), constant: 0),
          script("get_character(10).pattern = 0"),
          *move_route(
            character(10),
            step_anime_off,
          ),
          *move_route(
            this,
            route_wait(15),
            turn_down,
          ),
          wait_completion,
          text("\\rYour Pokémon have been healed to perfect health."),
          comment("Nurse bows."),
          *move_route(
            this,
            change_graphic(name: "NPC 16", pattern: 1),
            route_wait(10),
            change_graphic(name: "NPC 16"),
          ),
          wait_completion,
          text("\\rWe hope you excel!"),
          control_switches(s(1), :OFF),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       401,  402,  403,  404,  401,  384,  394,  394,  394,  394,  394,  394,  394,  389,  401,  402,  403,  404,  401,  394,
       408,  410,  411,  412,  408,  392,  394,  394,  394,  394,  394,  394,  394,  397,  408,  410,  411,  412,  408,  394,
       467,  457,  457,  457,  457,  392,  394,  394,  394,  394,  394,  394,  394,  397,  467,  457,  457,  457,  457,  394,
       449,  449,  451,  449,  449,  392,  394,  394,  394,  394,  394,  394,  394,  397,  449,  449,  451,  449,  449,  394,
       467,  457,  458,  465,  466,  392,  394,  394,  394,  394,  394,  394,  394,  397,  467,  457,  458,  465,  466,  394,
       450,  440,  440,  440,  440,  400,  401,  401,  401,  401,  401,  401,  401,  405,  450,  440,  440,  440,  440,  394,
       450,  440,  440,  440,  440,  408,  408,  408,  408,  408,  408,  408,  408,  408,  450,  440,  440,  440,  440,  394,
       450,  440,  440,  440,  440,  449,  449,  449,  449,  467,  457,  449,  449,  449,  450,  440,  440,  440,  440,  394,
       450,  429,  430,  431,  440,  449,  449,  449,  449,  449,  449,  449,  449,  449,  450,  429,  430,  431,  440,  394,
       450,  437,  438,  439,  440,  447,  467,  457,  457,  457,  457,  457,  457,  457,  458,  437,  438,  439,  440,  394,
       450,  440,  440,  440,  440,  440,  440,  440,  429,  430,  431,  440,  440,  440,  440,  440,  440,  440,  440,  394,
       450,  440,  440,  440,  440,  440,  440,  440,  437,  438,  439,  440,  440,  440,  440,  440,  440,  440,  440,  394,
       450,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,  394,
       394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,
       394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       474,  506,    0,  504,  474,    0,    0,    0,    0,    0,    0,    0,    0,    0,  474,  506,    0,  504,  474,    0,
       498,  514,    0,  512,  498,    0,    0,    0,    0,    0,    0,    0,    0,    0,  498,  514,    0,  512,  498,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,  418,  419,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  409,  479,  485,  486,  426,  427,  487,  479,  409,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  425,  489,  493,  494,  505,  474,  495,  491,  425,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  433,  497,  498,  498,  513,  498,  498,  499,  433,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  576,  577,  578,    0,
       414,    0,  414,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  584,  585,  586,    0,
       422,    0,  422,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  592,  593,  594,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  502,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  502,    0,
         0,    0,    0,    0,  510,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  510,    0,
         0,    0,    0,    0,  518,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  518,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  526,  501,    0,    0,    0,    0,    0,  501,  503,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  534,  509,    0,    0,    0,    0,    0,  509,  511,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  542,    0,    0,    0,    0,    0,    0,    0,  519,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
