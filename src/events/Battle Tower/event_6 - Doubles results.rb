event(
  id: 6,
  name: "Doubles results",
  x: 18,
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
              "towerdouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "towerdouble")
            )
            CODE
          ),
          text("\\PN's Battle Tower Level 50 Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "towerdoubleopen")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "towerdoubleopen")
            )
            CODE
          ),
          text("\\PN's Battle Tower Open Level Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)