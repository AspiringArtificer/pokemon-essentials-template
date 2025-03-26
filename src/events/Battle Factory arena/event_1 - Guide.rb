event(
  id: 1,
  name: "Guide",
  x: 2,
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
        move_up,
        move_up,
        move_up,
        turn_right,
        through_off,
      ),
      *move_route(
        player,
        change_speed(3),
        change_opacity(0),
        through_on,
        move_up,
        change_opacity(255),
        move_up,
        move_up,
        move_right,
        move_up,
        move_right,
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
      event_location(character(2), x: 12, y: 1, direction: :down),
      script("pbBattleChallengeGraphic(get_character(2))"),
      *move_route(
        character(2),
        through_on,
        move_down,
        move_down,
        move_down,
        move_down,
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
          *move_route(
            character(2),
            through_on,
            move_right,
            move_right,
            move_right,
            move_up,
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
            move_left,
            through_off,
          ),
          wait_completion,
          *condition(
            script: "pbBattleChallenge.pbMatchOver?",
            then: [
              script("pbBattleChallenge.setDecision(1)"),
              play_se(audio(name: "Door exit", volume: 80)),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              script("pbBattleChallenge.pbGoToStart"),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
              exit_event_processing,
            ],
            else: [
              play_se(audio(name: "Door exit", volume: 80)),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 65, x: 4, y: 5, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
              exit_event_processing,
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
          exit_event_processing,
        ],
      ),
    ],
  ),
)