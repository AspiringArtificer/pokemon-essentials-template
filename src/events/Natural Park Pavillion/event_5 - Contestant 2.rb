event(
  id: 5,
  name: "Contestant 2",
  x: 3,
  y: 6,
  page_0: page(
    graphic: graphic(
      direction: :up,
    ),
  ),
  page_1: page(
    switch1: s(27),
    graphic: graphic(
      name: "trainer_CAMPER",
      direction: :up,
    ),
    commands: [
      *text(
        "Barry: \\bI work a lot, but that's not good enough to ",
        "win.",
      ),
    ],
  ),
)