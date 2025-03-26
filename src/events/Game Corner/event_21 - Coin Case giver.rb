event(
  id: 21,
  name: "Coin Case giver",
  x: 3,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 08",
    ),
    commands: [
      text("\\rWelcome!"),
      *condition(
        script: "!$bag.has?(:COINCASE)",
        then: [
          text("\\rOh, you don't have a Coin Case? Here."),
          *condition(
            script: "pbReceiveItem(:COINCASE)",
            then: [
              *text(
                "\\rYou can exchange your coins for fabulous prizes ",
                "next door.",
              ),
            ],
            else: [
              *text(
                "\\rYou don't have any room for it. Come back when ",
                "you do.",
              ),
            ],
          ),
        ],
        else: [
          *text(
            "\\rYou can exchange your coins for fabulous prizes ",
            "next door.",
          ),
        ],
      ),
    ],
  ),
)