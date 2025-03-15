# Battle Frontier (52)
#   Battle Factory (62)
#     Battle Factory intro corridor (63)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Battle Frontier", volume: 80),
  events: [

    event(
      id: 1,
      name: "Guide",
      x: 4,
      y: 8,
      page_0: page(
        graphic: graphic(
          name: "trainer_SCIENTIST",
          direction: :up,
        ),
        trigger: :autorun,
        commands: [
          *move_route(
            this,
            through_on,
            move_up,
            move_up,
            move_up,
            move_up,
            turn_down,
            through_off,
            skippable: true,
          ),
          *move_route(
            player,
            change_opacity(0),
            change_speed(3),
            through_on,
            move_up,
            change_opacity(255),
            move_up,
            move_up,
            move_up,
            through_off,
            skippable: true,
          ),
          wait_completion,
          label("Choice Menu"),
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
              script("pbBattleChallenge.extra.pbPrepareRentals"),
              text("\\bI'll take your party for safekeeping."),
              *text(
                "\\bThen you may choose from our selection of ",
                "Pokémon.",
              ),
              script("pbBattleChallenge.extra.pbChooseRentals"),
              text("\\bCome with me."),
              *move_route(
                this,
                through_on,
                move_up,
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                move_up,
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
              transfer_player(map: 64, x: 2, y: 9, direction: :retain, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
              exit_event_processing,
            ],
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
              script("pbBattleChallenge.extra.pbPrepareSwaps"),
              text("\\bWould you like to swap a Pokémon first?"),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  *condition(
                    script: "pbBattleChallenge.extra.pbChooseSwaps",
                    then: [
                      text("\\bOK, the Pokémon swap is complete."),
                    ],
                  ),
                ],
              ),
              text("\\bCome with me."),
              *move_route(
                this,
                through_on,
                move_up,
                move_up,
                move_up,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                change_speed(3),
                through_on,
                move_up,
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
              transfer_player(map: 64, x: 2, y: 9, direction: :retain, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
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
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       520,  521,  521,  521,  521,  521,  521,  521,  523,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       528,  529,  529,  529,  529,  529,  529,  529,  531,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       633,  641,  641,  641,  641,  641,  641,  641,  650,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,    0,  389,  390,  391, 1788,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1794, 1795,  397,  398,  399, 1796, 1794,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       536, 1802, 1803,    0,    0,    0, 1804, 1802,  539,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1808, 1809,    0,    0,    0,    0,    0, 1789, 1790,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1816, 1817, 1818,    0,    0,    0,    0, 1797, 1798,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1824, 1825, 1826,    0,    0,    0,    0, 1805, 1806,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1784, 1785,    0,    0,    0,    0,    0, 1784, 1785,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1792, 1793,    0,    0,    0,    0,    0, 1792, 1793,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1800, 1801,    0, 1245, 1246, 1247,    0, 1800, 1801,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
