event(
  id: 1,
  name: "Guide",
  x: 0,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "trainer_BLACKBELT",
      direction: :right,
    ),
    trigger: :autorun,
    commands: [
      *move_route(
        player,
        change_speed(3),
        through_on,
        change_opacity(255),
        move_right,
        through_off,
      ),
      *move_route(
        this,
        through_on,
        change_opacity(255),
        move_right,
        through_off,
      ),
      wait_completion,
      *script(
        <<~'CODE'
        pbSet(1,
          pbBattleChallenge.battleNumber
        )
        CODE
      ),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 1,
        then: [
          *move_route(
            player,
            change_speed(3),
            through_on,
            turn_right,
            move_right,
            move_right,
            through_off,
          ),
          wait_completion,
        ],
        else: [
          *move_route(
            player,
            change_speed(3),
            through_on,
            change_opacity(255),
            move_right,
            turn_up,
            through_off,
          ),
          *move_route(
            this,
            through_on,
            change_opacity(255),
            move_right,
            turn_down,
            through_off,
          ),
          wait_completion,
          jump_label("Choice Menu"),
        ],
      ),
      label("Next Opponent"),
      event_location(character(2), x: 10, y: 5, direction: :retain),
      script("pbBattleChallengeGraphic(get_character(2))"),
      *move_route(
        character(2),
        through_on,
        move_left,
        move_left,
        move_left,
        through_off,
      ),
      wait_completion,
      *script(
        <<~'CODE'
        pbSet(1,
          pbBattleChallengeBeginSpeech
        )
        CODE
      ),
      text("\\v[1]"),
      *condition(
        script: "pbBattleChallengeBattle",
        then: [
          script("pbBattleChallenge.pbAddWin"),
          *condition(
            script: "pbBattleChallenge.pbMatchOver?",
            then: [
              script("pbBattleChallenge.setDecision(1)"),
              wait(8),
              play_se(audio(name: "Door exit", volume: 80)),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              script("pbBattleChallenge.pbGoToStart"),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
              exit_event_processing,
            ],
            else: [
              *move_route(
                character(2),
                through_on,
                turn_right,
                move_right,
                move_right,
                move_right,
                remove_graphic,
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                turn_left,
                move_left,
                move_left,
                turn_up,
                through_off,
              ),
              wait_completion,
              *move_route(
                this,
                turn_down,
              ),
              text("\\bThanks for playing.  Let me heal your party."),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              recover_all(0),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
              wait(8),
              label("Choice Menu"),
              *script(
                <<~'CODE'
                pbSet(1,
                  pbBattleChallenge.battleNumber
                )
                CODE
              ),
              comment("================================"),
              *script(
                <<~'CODE'
                if $game_temp.last_battle_record.nil?
                  hide_choice(4)
                end
                CODE
              ),
              text("\\bBattle number \\v[1] is next. Are you ready?"),
              *show_choices(
                choices: ["Go on", "Rest", "Retire", "Record"],
                cancellation: 0,
                choice1: [
                  script("pbBattleChallenge.pbGoOn"),
                  *move_route(
                    this,
                    turn_right,
                  ),
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    turn_right,
                    move_right,
                    move_right,
                    through_off,
                  ),
                  jump_label("Next Opponent"),
                ],
                choice2: [
                  *text(
                    "\\bWould you like to save the game and continue ",
                    "later?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      script("pbBattleChallenge.pbRest"),
                      text("Your game has been saved."),
                      title_screen,
                      exit_event_processing,
                    ],
                    choice2: [
                      jump_label("Choice Menu"),
                    ],
                  ),
                  jump_label("Choice Menu"),
                ],
                choice3: [
                  text("\\bAre you sure you want to quit your challenge?"),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      script("pbBattleChallenge.setDecision(2)"),
                      play_se(audio(name: "Door exit", volume: 80)),
                      change_tone(red: -255, green: -255, blue: -255, frames: 6),
                      wait(8),
                      script("pbBattleChallenge.pbGoToStart"),
                      change_tone(red: 0, green: 0, blue: 0, frames: 6),
                      exit_event_processing,
                    ],
                    choice2: [
                      jump_label("Choice Menu"),
                    ],
                  ),
                ],
                choice4: [
                  text("\\bWould you like to record your last battle?"),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      script("pbRecordLastBattle"),
                      text("\\se[Pkmn exp full]The battle was recorded."),
                    ],
                  ),
                  jump_label("Choice Menu"),
                ],
              ),
            ],
          ),
        ],
        else: [
          script("pbBattleChallenge.setDecision(2)"),
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          script("pbBattleChallenge.pbGoToStart"),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ],
  ),
)