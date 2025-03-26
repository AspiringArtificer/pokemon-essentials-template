event(
  id: 8,
  name: "Controlling event",
  x: 7,
  y: 3,
  page_0: page(
    trigger: :autorun,
    commands: [
      *move_route(
        player,
        turn_up,
        move_forward,
        move_forward,
        move_forward,
        move_forward,
        move_forward,
        move_forward,
        move_forward,
        skippable: true,
      ),
      wait_completion,
      text("\\bOak: Here, take one of these rare Pokémon."),
      control_switches(s(3), :ON),
    ],
  ),
  page_1: page(
    switch1: s(3),
  ),
  page_2: page(
    variable: v(7),
    at_least: 1,
    trigger: :autorun,
    commands: [
      text("\\bOak: Ah, you made your choice!"),
      *condition(
        variable: v(7),
        operation: "==",
        constant: 1,
        then: [
          text("\\bOak: Bulbasaur, an excellent choice!"),
        ],
        else: condition(
          variable: v(7),
          operation: "==",
          constant: 2,
          then: [
            text("\\bOak: Charmander, an excellent choice!"),
          ],
          else: [
            text("\\bOak: Squirtle, an excellent choice!"),
          ],
        ),
      ),
      *text(
        "\\bOak: If I had a grandson, he would probably want ",
        "his own Pokémon around now...",
      ),
      control_self_switch("A", :ON),
    ],
  ),
  page_3: page(
    self_switch: "A",
  ),
)