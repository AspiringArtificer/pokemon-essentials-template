event(
  id: 27,
  name: "HiddenItem",
  x: 29,
  y: 62,
  page_0: page(
    through: true,
    commands: condition(
      script: "pbItemBall(:RARECANDY, 2)",
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