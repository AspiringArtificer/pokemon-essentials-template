event(
  id: 5,
  name: "StrengthBoulder",
  x: 21,
  y: 14,
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
    switch1: s(58),
  ),
)