event(
  id: 8,
  name: "Mew",
  x: 14,
  y: 12,
  page_0: page(
    graphic: graphic(
      name: "Pokemon 09",
      hue: 180,
      pattern: 1,
    ),
    commands: [
      *comment(
        "Mew reappears after each time the Elite Four are ",
        "defeated. The command that does this is in the event ",
        "in the Hall of Fame map.",
        "Mew will not reappear if it has been caught, though. ",
        "This is why this event sets Self Switch B if it is caught, ",
        "to avoid it reappearing.",
      ),
      script("Pokemon.play_cry(:MEW)"),
      wait(15),
      control_switches(s(31), :ON),
      control_switches(s(32), :ON),
      script("WildBattle.start(:MEW, 30)"),
      control_switches(s(31), :OFF),
      control_switches(s(32), :OFF),
      *comment(
        "A battle's outcome is stored in Game Variable 1 by ",
        "default. You can change this by putting the script ",
        "\"setBattleRule(\"outcome\", 42)\" before the battle, ",
        "where 42 is the Game Variable number you want.",
      ),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 4,
        then: [
          comment("Caught."),
          control_self_switch("B", :ON),
        ],
        else: [
          control_self_switch("A", :ON),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    trigger: :parallel,
    commands: condition(
      switch: s(56),
      value: :ON,
      then: [
        control_switches(s(56), :OFF),
        control_self_switch("A", :OFF),
      ],
    ),
  ),
  page_2: page(
    self_switch: "B",
  ),
)