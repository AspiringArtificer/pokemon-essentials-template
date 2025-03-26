event(
  id: 2,
  name: "Gym Guy",
  x: 7,
  y: 12,
  page_0: page(
    graphic: graphic(
      name: "NPC 15",
    ),
    commands: [
      text("\\bThis is an example of a Pokémon Gym."),
      *text(
        "\\bThe only differences are that the trainers become ",
        "inactive when the Leader is defeated, and the ",
        "Leader gives you a Gym Badge and TM as a reward.",
      ),
    ],
  ),
)