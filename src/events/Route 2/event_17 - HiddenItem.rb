event(
  id: 17,
  name: "HiddenItem",
  x: 14,
  y: 11,
  page_0: page(
    through: true,
    commands: condition(
      script: "pbItemBall(:RARECANDY)",
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