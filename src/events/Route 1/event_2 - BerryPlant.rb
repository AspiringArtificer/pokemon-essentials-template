event(
  id: 2,
  name: "BerryPlant",
  x: 9,
  y: 16,
  page_0: page(
    graphic: graphic(
      name: "berrytree_CHERIBERRY",
      direction: :up,
    ),
    walk_anime: false,
    step_anime: true,
    direction_fix: true,
    commands: [
      script("pbPickBerry(:CHERIBERRY, 2)"),
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