event(
  id: 6,
  name: "Single results",
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
              "factorysingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "factorysingle")
            )
            CODE
          ),
          text("\\PN's Battle Factory Level 50 Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "factorysingleopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "factorysingleopen")
            )
            CODE
          ),
          text("\\PN's Battle Factory Open Level Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)