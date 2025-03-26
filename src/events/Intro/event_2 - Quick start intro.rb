event(
  id: 2,
  name: "Quick start intro",
  x: 0,
  y: 14,
  page_0: page(
    commands: [
      *comment(
        "This is the Debug intro, used to quickly start a game. ",
        "The player's name and trainer type are chosen ",
        "automatically.",
      ),
      script("pbChangePlayer(1)"),
      script("pbTrainerName(\"Red\")"),
      control_self_switch("A", :ON),
      *script(
        <<~'CODE'
        pbToneChangeAll(
          Tone.new(-255, -255, -255, 0),
          0
        )
        CODE
      ),
      transfer_player(map: 3, x: 25, y: 6, direction: :down, fading: false),
      *script(
        <<~'CODE'
        pbToneChangeAll(
          Tone.new(0, 0, 0, 0),
          10
        )
        CODE
      ),
      wait(10),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
)