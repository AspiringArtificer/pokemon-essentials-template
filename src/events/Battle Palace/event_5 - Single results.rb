event(
  id: 5,
  name: "Single results",
  x: 5,
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
              "palacesingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "palacesingle")
            )
            CODE
          ),
          text("\\PN's Battle Palace Level 50 Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "palacesingleopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "palacesingleopen")
            )
            CODE
          ),
          text("\\PN's Battle Palace Open Level Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)