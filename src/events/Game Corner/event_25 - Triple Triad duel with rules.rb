event(
  id: 25,
  name: "Triple Triad duel with rules",
  x: 16,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "trainer_LASS",
      direction: :left,
    ),
    commands: [
      text("\\rReady for a real rule duel?"),
      *condition(
        script: "pbCanTriadDuel?",
        then: [
          *comment(
            "This duel includes certain battle rules. See the wiki ",
            "for details of what rules can be applied.",
          ),
          *script(
            <<~'CODE'
            pbTriadDuel("Alice", 0, 5,
              ["countunplayed",
              "samewins",
              "elements",
              "direct"]
            )
            CODE
          ),
        ],
        else: [
          *text(
            "\\rOh, you don't have enough cards to play. You need ",
            "at least 5.",
          ),
        ],
      ),
    ],
  ),
)