event(
  id: 8,
  name: "Boulder position checks",
  x: 6,
  y: 5,
  page_0: page(
    trigger: :parallel,
    commands: [
      comment("Boulder to be pushed down hole is event 6."),
      *condition(
        self_switch: "A",
        value: :OFF,
        then: [
          control_variables(v(4), character: character(6), property: :map_x),
          control_variables(v(5), character: character(6), property: :map_y),
          *condition(
            variable: v(4),
            operation: "==",
            constant: 12,
            then: condition(
              variable: v(5),
              operation: "==",
              constant: 7,
              then: [
                comment("Is over hole."),
                wait(8),
                play_se(audio(name: "Battle throw", volume: 80)),
                control_switches(s(57), :ON),
                control_self_switch("A", :ON),
              ],
            ),
          ),
        ],
      ),
      comment("Boulder to be pushed onto switch is event 7."),
      *comment(
        "There is more to this one because the boulder can be ",
        "pushed off the switch again.",
      ),
      *condition(
        self_switch: "B",
        value: :OFF,
        then: [
          control_variables(v(4), character: character(7), property: :map_x),
          control_variables(v(5), character: character(7), property: :map_y),
          *condition(
            variable: v(4),
            operation: "==",
            constant: 20,
            then: condition(
              variable: v(5),
              operation: "==",
              constant: 7,
              then: [
                comment("Is on switch."),
                wait(8),
                play_se(audio(name: "Battle ball drop", volume: 80)),
                script("pbSetSelfSwitch(5, \"A\", true)"),
                control_self_switch("B", :ON),
              ],
            ),
          ),
        ],
        else: [
          control_variables(v(4), character: character(7), property: :map_x),
          control_variables(v(5), character: character(7), property: :map_y),
          *condition(
            variable: v(4),
            operation: "!=",
            constant: 20,
            then: [
              comment("Boulder has been moved off the switch."),
              script("pbSetSelfSwitch(5, \"A\", false)"),
              control_self_switch("B", :OFF),
            ],
            else: condition(
              variable: v(5),
              operation: "!=",
              constant: 7,
              then: [
                comment("Boulder has been moved off the switch."),
                script("pbSetSelfSwitch(5, \"A\", false)"),
                control_self_switch("B", :OFF),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
)