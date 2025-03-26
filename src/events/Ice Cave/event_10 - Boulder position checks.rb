event(
  id: 10,
  name: "Boulder position checks",
  x: 23,
  y: 13,
  page_0: page(
    trigger: :parallel,
    commands: [
      comment("Boulder to be pushed down hole is event 5."),
      *condition(
        self_switch: "A",
        value: :OFF,
        then: [
          control_variables(v(4), character: character(5), property: :map_x),
          control_variables(v(5), character: character(5), property: :map_y),
          *condition(
            variable: v(4),
            operation: "==",
            constant: 22,
            then: condition(
              variable: v(5),
              operation: "==",
              constant: 14,
              then: [
                comment("Is over hole."),
                wait(8),
                play_se(audio(name: "throw", volume: 80)),
                control_switches(s(58), :ON),
                control_self_switch("A", :ON),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
)