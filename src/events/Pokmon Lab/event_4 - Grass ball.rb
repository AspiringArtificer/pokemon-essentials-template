event(
  id: 4,
  name: "Grass ball",
  x: 8,
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
      text("\\bOak: So, you want Bulbasaur, the grass Pokémon?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          script("pbAddPokemon(:BULBASAUR, 5)"),
          control_switches(s(3), :OFF),
          control_variables(v(7), constant: 1),
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