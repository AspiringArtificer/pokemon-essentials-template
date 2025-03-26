event(
  id: 27,
  name: "Triple Triad duel with prize",
  x: 16,
  y: 8,
  page_0: page(
    graphic: graphic(
      name: "trainer_COOLTRAINER_F",
      direction: :left,
    ),
    commands: [
      text("\\rIf you win, I'll give you an Arceus card!"),
      *condition(
        script: "pbCanTriadDuel?",
        then: [
          *comment(
            "This duel has a prize card defined, which the player ",
            "gets if they win (ignoring any rule which affects ",
            "prizes).  If the player draws or loses, however, the ",
            "rules apply normally.",
          ),
          *script(
            <<~'CODE'
            pbTriadDuel("Sophie", 0, 5, nil, nil,
              :ARCEUS
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