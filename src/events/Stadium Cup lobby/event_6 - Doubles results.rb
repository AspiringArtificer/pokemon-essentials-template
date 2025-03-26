event(
  id: 6,
  name: "Doubles results",
  x: 18,
  y: 3,
  page_0: page(
    commands: [
      text("Check results for which doubles challenge?"),
      *show_choices(
        choices: ["Pika Cup", "Fancy Cup", "Poké Cup"],
        cancellation: 0,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "pikacupdouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "pikacupdouble")
            )
            CODE
          ),
          text("\\PN's Battle Tower Pika Cup Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "fancycupdouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "fancycupdouble")
            )
            CODE
          ),
          text("\\PN's Battle Tower Fancy Cup Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice3: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "pokecupdouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "pokecupdouble")
            )
            CODE
          ),
          text("\\PN's Battle Tower Poké Cup Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
      *show_choices(
        choices: ["Little Cup", "Cancel"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "littlecupdouble")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "littlecupdouble")
            )
            CODE
          ),
          text("\\PN's Battle Tower Little Cup Double Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)