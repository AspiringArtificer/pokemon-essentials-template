event(
  id: 1,
  name: "Exit",
  x: 2,
  y: 6,
  page_0: page(
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      *condition(
        variable: v(10),
        operation: "==",
        constant: 5,
        then: [
          transfer_player(map: 18, x: 6, y: 1, direction: :retain, fading: false),
        ],
        else: condition(
          variable: v(10),
          operation: "==",
          constant: 4,
          then: [
            transfer_player(map: 17, x: 6, y: 1, direction: :retain, fading: false),
          ],
          else: condition(
            variable: v(10),
            operation: "==",
            constant: 3,
            then: [
              transfer_player(map: 16, x: 6, y: 1, direction: :retain, fading: false),
            ],
            else: condition(
              variable: v(10),
              operation: "==",
              constant: 2,
              then: [
                transfer_player(map: 15, x: 6, y: 1, direction: :retain, fading: false),
              ],
              else: [
                transfer_player(map: 14, x: 6, y: 1, direction: :retain, fading: false),
              ],
            ),
          ),
        ),
      ),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
)