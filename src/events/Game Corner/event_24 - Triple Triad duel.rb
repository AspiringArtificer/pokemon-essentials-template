event(
  id: 24,
  name: "Triple Triad duel",
  x: 16,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "trainer_YOUNGSTER",
      direction: :left,
    ),
    commands: [
      text("\\bI'm ready to duel with you."),
      *condition(
        script: "pbCanTriadDuel?",
        then: [
          *comment(
            "The two numbers are the min and max level of the ",
            "opponent respectively. Each number can be between ",
            "0 and 9 inclusive, and the max level must be higher ",
            "than or equal to the min level.",
          ),
          script("pbTriadDuel(\"Jack\", 0, 5)"),
        ],
        else: [
          *text(
            "\\bOh, you don't have enough cards to play. You need ",
            "at least 5.",
          ),
        ],
      ),
    ],
  ),
)