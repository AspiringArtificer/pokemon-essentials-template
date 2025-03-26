event(
  id: 4,
  name: "Results",
  x: 7,
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
              "arena")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "arena")
            )
            CODE
          ),
          text("\\PN's Battle Arena Level 50 results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "arenaopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "arenaopen")
            )
            CODE
          ),
          text("\\PN's Battle Arena Open Level results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)