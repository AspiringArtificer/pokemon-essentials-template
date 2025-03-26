event(
  id: 9,
  name: "BerryPlant",
  x: 15,
  y: 18,
  page_0: page(
    graphic: graphic(
      name: "berrytree_ASPEARBERRY",
      direction: :up,
    ),
    walk_anime: false,
    step_anime: true,
    direction_fix: true,
    commands: [
      script("pbPickBerry(:ASPEARBERRY, 2)"),
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