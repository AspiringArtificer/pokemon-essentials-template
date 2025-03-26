event(
  id: 23,
  name: "Triple Triad card shop",
  x: 14,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      label("Shop Start"),
      text("\\bWelcome to the Triad Card Shop."),
      label("Choices"),
      *show_choices(
        choices: ["Buy Cards", "Sell Cards", "Information", "Exit"],
        cancellation: 4,
        choice1: [
          script("pbBuyTriads"),
          text("\\bAnything else I can do for you?"),
          jump_label("Choices"),
        ],
        choice2: [
          script("pbSellTriads"),
          text("\\bAnything else I can do for you?"),
          jump_label("Choices"),
        ],
        choice3: [
          *text(
            "\\bHere is where you can purchase new cards for ",
            "Triple Triad duels.",
          ),
          *text(
            "\\bThe selection grows as you catch and find new ",
            "Pokémon, so check often.",
          ),
          *text(
            "\\bAnd, of course, stronger Pokémon cards cost more ",
            "than weaker cards.",
          ),
          *text(
            "\\bYou don't have to use this shop in your game. It's ",
            "just an example of how the player could gain Triple ",
            "Triad cards. You could implement other ways.",
          ),
          jump_label("Shop Start"),
        ],
        choice4: [
          text("\\bPlease come again."),
        ],
      ),
    ],
  ),
)