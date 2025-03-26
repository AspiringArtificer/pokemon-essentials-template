event(
  id: 3,
  name: "Pokémon ball - Basic",
  x: 5,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "Object ball",
    ),
    commands: [
      *comment(
        "This is a straightforward example of giving a ",
        "Pokémon to the player. Its OT will be the player.",
      ),
      *condition(
        script: "pbAddPokemon(:FARFETCHD, 20)",
        then: [
          control_self_switch("A", :ON),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
)