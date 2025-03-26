event(
  id: 4,
  name: "Deliveryman",
  x: 3,
  y: 6,
  page_0: page(
    graphic: graphic(
      direction: :right,
    ),
  ),
  page_1: page(
    switch1: s(30),
    graphic: graphic(
      name: "NPC 01",
      direction: :right,
    ),
    commands: [
      *condition(
        script: "pbNextMysteryGiftID > 0",
        then: [
          text("\\bHello. You must be \\PN."),
          text("\\bI've received a gift for you.\\nHere you go!"),
          *script(
            <<~'CODE'
            id = pbNextMysteryGiftID
            pbReceiveMysteryGift(id)
            CODE
          ),
        ],
        else: [
          text("\\bI haven't received any other gifts for you."),
        ],
      ),
      text("\\bWe look forward to your next visit."),
    ],
  ),
)