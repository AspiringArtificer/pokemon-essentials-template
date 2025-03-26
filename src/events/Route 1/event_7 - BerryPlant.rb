event(
  id: 7,
  name: "BerryPlant",
  x: 15,
  y: 16,
  page_0: page(
    graphic: graphic(
      name: "berrytree_PECHABERRY",
      direction: :up,
    ),
    walk_anime: false,
    step_anime: true,
    direction_fix: true,
    commands: [
      script("pbPickBerry(:PECHABERRY, 2)"),
    ],
  ),
  page_1: page(
    self_switch: "A",
    move_frequency: 2,
    walk_anime: false,
    step_anime: true,
    commands: [
      script("pbBerryPlant"),
    ],
  ),
)