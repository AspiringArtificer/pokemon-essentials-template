event(
  id: 5,
  name: "Singles results",
  x: 4,
  y: 3,
  page_0: page(
    commands: [
      text("Check results for which singles challenge?"),
      *show_choices(
        choices: ["Pika Cup", "Fancy Cup", "Poké Cup"],
        cancellation: 0,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "pikacupsingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "pikacupsingle")
            )
            CODE
          ),
          text("\\PN's Battle Tower Pika Cup Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "fancycupsingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "fancycupsingle")
            )
            CODE
          ),
          text("\\PN's Battle Tower Fancy Cup Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
        choice3: [
          *script(
            <<~'CODE'
            pbSet(1,
              pbBattleChallenge.getPreviousWins(
              "pokecupsingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "pokecupsingle")
            )
            CODE
          ),
          text("\\PN's Battle Tower Poké Cup Single Battle results:"),
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
              "littlecupsingle")
            )
            pbSet(2,
              pbBattleChallenge.getMaxWins(
              "littlecupsingle")
            )
            CODE
          ),
          text("\\PN's Battle Tower Little Cup Single Battle results:"),
          text("Last win streak: \\v[1]\\nRecord win streak: \\v[2]"),
        ],
      ),
    ],
  ),
)