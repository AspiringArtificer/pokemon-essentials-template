# Battle Frontier (52)
#   Battle Palace (58)
#     Battle Palace arena (59)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Battle Frontier", volume: 80),
  events: [

    event(
      id: 1,
      name: "Guide",
      x: 2,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "trainer_GAMBLER",
          direction: :up,
        ),
        trigger: :autorun,
        commands: [
          *move_route(
            this,
            change_opacity(0),
            through_on,
            move_up,
            change_opacity(255),
            move_up,
            move_up,
            turn_right,
            through_off,
          ),
          *move_route(
            player,
            change_speed(3),
            through_on,
            change_opacity(255),
            move_up,
            move_up,
            move_up,
            move_right,
            move_up,
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
                turn_right,
              ),
            ],
            else: [
              *move_route(
                this,
                change_opacity(0),
                through_on,
                move_up,
                change_opacity(255),
                move_up,
                move_up,
                turn_right,
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                change_opacity(255),
                move_up,
                move_up,
                move_up,
                move_right,
                move_up,
                turn_left,
                through_off,
              ),
              wait_completion,
              jump_label("Choice Menu"),
            ],
          ),
          label("Next Opponent"),
          event_location(character(2), x: 10, y: 1, direction: :down),
          script("pbBattleChallengeGraphic(get_character(2))"),
          *move_route(
            character(2),
            through_on,
            move_down,
            move_down,
            move_down,
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
                    move_right,
                    move_right,
                    move_up,
                    move_up,
                    move_up,
                    remove_graphic,
                    through_off,
                  ),
                  wait_completion,
                  *move_route(
                    player,
                    change_speed(3),
                    through_on,
                    move_left,
                    through_off,
                  ),
                  wait_completion,
                  text("\\bThanks for playing. Let me heal your party."),
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
                        player,
                        change_speed(3),
                        through_on,
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
    ),

    event(
      id: 2,
      name: "Opponent",
      x: 10,
      y: 1,
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       456,  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,  458,  542,  542,  542,  542,  542,  542,  542,
       464,  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,  466,  542,  542,  542,  542,  542,  542,  542,
       737,  745,  745,  745,  745,  745,  745,  745,  745,  745,  745,  745,  754,  542,  542,  542,  542,  542,  542,  542,
       738,  728,  728,  728, 1195, 1196, 1196, 1196, 1197,  728,  728,  728,  728,  542,  542,  542,  542,  542,  542,  542,
       738,  728,  728,  728, 1203, 1204, 1204, 1204, 1205,  728,  728,  728,  728,  542,  542,  542,  542,  542,  542,  542,
       738,  728,  728,  728, 1211, 1212, 1212, 1212, 1213,  728,  728,  728,  728,  542,  542,  542,  542,  542,  542,  542,
       738,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  728,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,    0,    0,    0,    0,    0,    0,    0,  389,  390,  391,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,  397,  398,  399,    0,    0,    0,    0,    0,    0,    0,    0,
       472,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  474,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1245, 1246, 1247,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
