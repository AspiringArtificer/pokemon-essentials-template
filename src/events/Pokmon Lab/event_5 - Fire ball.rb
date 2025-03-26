event(
  id: 5,
  name: "Fire ball",
  x: 9,
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
      text("\\bOak: So, you want Charmander, the fire Pokémon?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          script("pbAddPokemon(:CHARMANDER, 5)"),
          control_switches(s(3), :OFF),
          control_variables(v(7), constant: 2),
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