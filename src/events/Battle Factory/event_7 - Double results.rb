event(
  id: 7,
  name: "Double results",
  x: 11,
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
              "factorydouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "factorydouble")
            )
            CODE
          ),
          text("\\PN's Battle Factory Level 50 Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "factorydoubleopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "factorydoubleopen")
            )
            CODE
          ),
          text("\\PN's Battle Factory Open Level Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)