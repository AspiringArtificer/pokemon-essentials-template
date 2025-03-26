event(
  id: 4,
  name: "Swimmer",
  x: 23,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_SWIMMER2_M",
    ),
    move_type: :custom,
    move_frequency: 5,
    move_route: route(
      route_script("move_random_range(2,2)"),
      skippable: true,
    ),
    commands: [
      text("\\bI'm just swimming around in this 5x5 area."),
      *text(
        "\\bMy custom autonomous movement calls a method ",
        "which makes me move randomly, but not further than ",
        "2 tiles horizontally or vertically from my initial position.",
      ),
      *text(
        "\\bOther scripts that could be called here are ",
        "move_random_UD(range) for up/down only and ",
        "move_random_LR(range) for left/right only.",
      ),
    ],
  ),
)