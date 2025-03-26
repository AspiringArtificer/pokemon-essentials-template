event(
  id: 22,
  name: "Triple Triad explainer",
  x: 13,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 08",
    ),
    commands: [
      text("\\rI'm here to explain the rules of Triple Triad."),
      label("Choices"),
      text("\\rWhich topic do you want to learn about?"),
      *show_choices(
        choices: ["Basics", "Game rules", "Prizes", "Exit"],
        cancellation: 4,
        choice1: [
          *text(
            "\\rTriple Triad is a game played with special cards ",
            "placed on a 3x3 board.",
          ),
          *text(
            "\\rEach card has 4 numbers on it, one per side.  ",
            "These numbers are so-called stats.",
          ),
          *text(
            "\\rPlayers take turns placing cards on the board. As ",
            "they do so, they try to capture and gain control of ",
            "their opponent's cards.",
          ),
          *text(
            "\\rThat's where the numbers come in. If a player ",
            "places a card with a higher number next to a card ",
            "with a lower number, the player captures that card.",
          ),
          *text(
            "\\rThus, the goal of the game is to gain control of more ",
            "cards than the other player by the end of the game.",
          ),
          jump_label("Choices"),
        ],
        choice2: [
          *text(
            "\\rThere are a number of optional game rules you can ",
            "apply to individual games.",
          ),
          *text(
            "\\rThey can affect card stats, how cards capture ",
            "each other, the scoring and the prizes.",
          ),
          jump_label("Choices"),
        ],
        choice3: [
          *text(
            "\\rWhen you win a game, you will recive 1 random ",
            "card from your opponent from their Deck.",
          ),
          *text(
            "\\rThis also works the other way around: if you lose, ",
            "you have to give your opponent one of your cards, ",
            "chosen at random.",
          ),
          *text(
            "\\rYou can change what you win or lose from a game ",
            "by using an optional game rule.",
          ),
          jump_label("Choices"),
        ],
      ),
    ],
  ),
)