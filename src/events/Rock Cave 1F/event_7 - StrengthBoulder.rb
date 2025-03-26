event(
  id: 7,
  name: "StrengthBoulder",
  x: 19,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "Object boulder",
    ),
    move_speed: 2,
    trigger: :player_touch,
    commands: [
      script("pbPushThisBoulder"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "Object boulder",
    ),
    move_speed: 2,
  ),
)