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
)