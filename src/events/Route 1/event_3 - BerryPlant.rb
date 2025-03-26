event(
  id: 3,
  name: "BerryPlant",
  x: 10,
  y: 16,
  page_0: page(
    graphic: graphic(
      name: "berrytree_ORANBERRY",
      direction: :up,
    ),
    walk_anime: false,
    step_anime: true,
    direction_fix: true,
    commands: [
      script("pbPickBerry(:ORANBERRY, 2)"),
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