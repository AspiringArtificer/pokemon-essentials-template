event(
  id: 5,
  name: "Old Amber",
  x: 11,
  y: 6,
  page_0: page(
    graphic: graphic(
      tile_id: 1726,
    ),
    commands: condition(
      script: "pbItemBall(:OLDAMBER)",
      then: [
        control_self_switch("A", :ON),
      ],
    ),
  ),
  page_1: page(
    self_switch: "A",
  ),
)