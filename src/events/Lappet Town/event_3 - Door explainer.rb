event(
  id: 3,
  name: "Door explainer",
  x: 12,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "NPC 06",
    ),
    move_frequency: 6,
    commands: [
      *text(
        "\\bThese doors are examples of good, solid door ",
        "events.",
      ),
      *text(
        "\\bWhen the player goes outside, be sure to transfer ",
        "the player onto the door rather than next to it.  It looks ",
        "better that way.",
      ),
    ],
  ),
)