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
)