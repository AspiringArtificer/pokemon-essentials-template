event(
  id: 16,
  name: "Item",
  x: 24,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "Object ball",
    ),
    commands: condition(
      script: "pbItemBall(:GREATBALL)",
      then: [
        control_self_switch("A", :ON),
      ],
    ),
  ),
  page_1: page(
    self_switch: "A",
  ),
)