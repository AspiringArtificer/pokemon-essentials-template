event(
  id: 6,
  name: "Water ball",
  x: 10,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "Object ball",
    ),
    commands: [
      *text(
        "This ball contains a Pokémon caught by the ",
        "Professor.",
      ),
    ],
  ),
  page_1: page(
    switch1: s(3),
    graphic: graphic(
      name: "Object ball",
    ),
    commands: [
      text("\\bOak: So, you want Squirtle, the water Pokémon?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          script("pbAddPokemon(:SQUIRTLE, 5)"),
          control_switches(s(3), :OFF),
          control_variables(v(7), constant: 3),
          control_self_switch("A", :ON),
        ],
        choice2: [
          text("\\bOak: Choose carefully!"),
        ],
      ),
    ],
  ),
  page_2: page(
    self_switch: "A",
  ),
)