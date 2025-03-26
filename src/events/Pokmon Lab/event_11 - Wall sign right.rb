event(
  id: 11,
  name: "Wall sign right",
  x: 7,
  y: 1,
  page_0: page(
    commands: [
      *text(
        "Game Variable 7 should store 1 if the player ",
        "chose the Grass starter, 2 if they chose the Fire ",
        "starter, and 3 if they chose the Water starter.",
      ),
      *text(
        "This information can be used later in the game, e.g. ",
        "to determine which Pokémon the rival uses, and to ",
        "detect when the player has chosen a starter at all.",
      ),
    ],
  ),
)