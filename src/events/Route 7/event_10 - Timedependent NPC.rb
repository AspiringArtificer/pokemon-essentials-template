event(
  id: 10,
  name: "Time-dependent NPC",
  x: 18,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: [
      *text(
        "\\bHello. This is what I say if you talk to me during the ",
        "day.",
      ),
    ],
  ),
  page_1: page(
    switch1: s(15),
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: [
      text("\\bHalt! Who goes there?"),
      text("\\bThis is what I say if you talk to me at night."),
      text("\\bI could battle you... but I won't."),
    ],
  ),
)