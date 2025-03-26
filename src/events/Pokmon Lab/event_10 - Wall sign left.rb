event(
  id: 10,
  name: "Wall sign left",
  x: 6,
  y: 1,
  page_0: page(
    commands: [
      *text(
        "The event next to the Professor contains the autorun ",
        "commands.",
      ),
      *text(
        "There are two times it does something: when the ",
        "player first enters the map, and when the player has ",
        "chosen a starter.",
      ),
      *text(
        "The second time is on a higher page number. Page ",
        "numbers go in order of first to last cutscene, ",
        "including pages for pauses between them if relevant.",
      ),
    ],
  ),
)