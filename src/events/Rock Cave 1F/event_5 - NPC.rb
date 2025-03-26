event(
  id: 5,
  name: "NPC",
  x: 17,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "NPC 05",
    ),
    commands: [
      text("\\bCan you push that boulder onto the switch?"),
      *condition(
        self_switch: "A",
        value: :ON,
        then: [
          text("\\bOh! The boulder has been moved onto the switch!"),
          text("\\bWell done!"),
        ],
        else: [
          text("\\bOh. The boulder is not on the switch."),
        ],
      ),
    ],
  ),
)