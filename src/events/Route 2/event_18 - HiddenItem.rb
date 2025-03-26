event(
  id: 18,
  name: "HiddenItem",
  x: 25,
  y: 12,
  page_0: page(
    through: true,
    commands: condition(
      script: "pbItemBall(:POTION)",
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