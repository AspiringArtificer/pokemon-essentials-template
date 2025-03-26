event(
  id: 6,
  name: "StrengthBoulder",
  x: 12,
  y: 9,
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
    switch1: s(57),
  ),
)