event(
  id: 15,
  name: "Item",
  x: 27,
  y: 36,
  page_0: page(
    graphic: graphic(
      name: "Object ball",
    ),
    commands: condition(
      script: "pbItemBall(:LEFTOVERS)",
      then: [
        control_self_switch("A", :ON),
      ],
    ),
  ),
  page_1: page(
    self_switch: "A",
    through: true,
  ),
)