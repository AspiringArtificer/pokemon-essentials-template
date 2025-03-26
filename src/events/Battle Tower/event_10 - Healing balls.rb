event(
  id: 10,
  name: "Healing balls",
  x: 7,
  y: 7,
  page_0: page(
    move_speed: 4,
    walk_anime: false,
  ),
  page_1: page(
    variable: v(6),
    at_least: 1,
    graphic: graphic(
      name: "Healing balls 1",
      direction: :left,
    ),
    walk_anime: false,
  ),
  page_2: page(
    variable: v(6),
    at_least: 2,
    graphic: graphic(
      name: "Healing balls 1",
      direction: :right,
    ),
    walk_anime: false,
  ),
  page_3: page(
    variable: v(6),
    at_least: 3,
    graphic: graphic(
      name: "Healing balls 1",
      direction: :up,
    ),
    walk_anime: false,
  ),
  page_4: page(
    variable: v(6),
    at_least: 4,
    graphic: graphic(
      name: "Healing balls 2",
      direction: :left,
    ),
    walk_anime: false,
  ),
  page_5: page(
    variable: v(6),
    at_least: 5,
    graphic: graphic(
      name: "Healing balls 2",
      direction: :right,
    ),
    walk_anime: false,
  ),
  page_6: page(
    variable: v(6),
    at_least: 6,
    graphic: graphic(
      name: "Healing balls 2",
      direction: :up,
    ),
    walk_anime: false,
  ),
)