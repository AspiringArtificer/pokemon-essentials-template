event(
  id: 2,
  name: "StrengthBoulder",
  x: 11,
  y: 7,
  page_0: page,
  page_1: page(
    switch1: s(57),
    graphic: graphic(
      name: "Object boulder",
    ),
    move_speed: 2,
    trigger: :player_touch,
    commands: [
      script("pbPushThisBoulder"),
    ],
  ),
)