event(
  id: 7,
  name: "Contestant 4",
  x: 8,
  y: 5,
  page_0: page(
    graphic: graphic(
      direction: :left,
    ),
  ),
  page_1: page(
    switch1: s(27),
    graphic: graphic(
      name: "trainer_LASS",
      direction: :left,
    ),
    commands: [
      *text(
        "Abby: \\rI try my best, but that's not good enough to ",
        "win.",
      ),
    ],
  ),
)