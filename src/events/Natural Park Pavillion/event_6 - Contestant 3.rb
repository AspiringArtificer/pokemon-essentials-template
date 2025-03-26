event(
  id: 6,
  name: "Contestant 3",
  x: 7,
  y: 6,
  page_0: page(
    graphic: graphic(
      direction: :up,
    ),
  ),
  page_1: page(
    switch1: s(27),
    graphic: graphic(
      name: "trainer_YOUNGSTER",
      direction: :up,
    ),
    commands: [
      *text(
        "Samuel: \\bI put lots of effort in, but that's not good ",
        "enough to win.",
      ),
    ],
  ),
)