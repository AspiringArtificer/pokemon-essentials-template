event(
  id: 4,
  name: "Contestant 1",
  x: 2,
  y: 5,
  page_0: page(
    graphic: graphic(
      direction: :up,
    ),
  ),
  page_1: page(
    switch1: s(27),
    graphic: graphic(
      name: "trainer_BUGCATCHER",
      direction: :right,
    ),
    commands: [
      *text(
        "Josh: \\bI study a lot, but that's not good enough to ",
        "win.",
      ),
    ],
  ),
)