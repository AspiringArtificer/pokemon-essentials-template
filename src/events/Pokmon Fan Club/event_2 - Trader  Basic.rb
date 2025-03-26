event(
  id: 2,
  name: "Trader - Basic",
  x: 2,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 06",
    ),
    commands: [
      text("\\bI'm looking for a Rattata."),
      text("\\bWant to trade it for my Haunter?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *comment(
            "The chosen Pokémon's party index goes in Game ",
            "Variable 1. A value of -1 means no Pokémon was ",
            "chosen.",
            "The chosen Pokémon's name goes in Game Variable 2.",
          ),
          *script(
            <<~'CODE'
            pbChoosePokemonForTrade(1, 2,
              :RATTATA
            )
            CODE
          ),
          *condition(
            variable: v(1),
            operation: "==",
            constant: -1,
            then: [
              text("\\bYou don't want to trade?  Aww..."),
            ],
            else: [
              text("\\bOK, let's get started."),
              *script(
                <<~'CODE'
                pbStartTrade(pbGet(1),
                  :HAUNTER, _I("HaHa"), _I("Andy")
                )
                CODE
              ),
              text("\\PN traded Rattata for Haunter!"),
              text("\\bThanks!"),
              control_self_switch("A", :ON),
            ],
          ),
        ],
        choice2: [
          text("\\bYou don't want to trade? Aww..."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "NPC 06",
    ),
    commands: [
      text("\\bThanks for trading with me!"),
    ],
  ),
)