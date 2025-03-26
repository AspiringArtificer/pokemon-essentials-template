event(
  id: 3,
  name: "Man regular",
  x: 5,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: [
      comment("Today is not a Contest day."),
      *text(
        "\\bWe hold contests regularly in the Park. You should ",
        "give it a shot.",
      ),
    ],
  ),
  page_1: page(
    switch1: s(19),
  ),
)