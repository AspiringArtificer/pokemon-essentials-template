event(
  id: 5,
  name: "Singles results",
  x: 4,
  y: 3,
  page_0: page(
    commands: [
      text("Check results for which challenge?"),
      *show_choices(
        choices: ["Level 50", "Open Level", "Cancel"],
        cancellation: 3,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "towersingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "towersingle")
            )
            CODE
          ),
          text("\\PN's Battle Tower Level 50 Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "towersingleopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "towersingleopen")
            )
            CODE
          ),
          text("\\PN's Battle Tower Open Level Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)