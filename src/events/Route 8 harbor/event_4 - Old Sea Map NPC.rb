event(
  id: 4,
  name: "Old Sea Map NPC",
  x: 10,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "trainer_SAILOR",
      direction: :left,
    ),
    commands: condition(
      script: "$bag.has?(:OLDSEAMAP)",
      then: [
        *text(
          "\\bI've already given you an Old Sea Map. Have you ",
          "gone to Faraday Island yet?",
        ),
      ],
      else: [
        text("\\bHere, have this Old Sea Map."),
        *condition(
          script: "pbReceiveItem(:OLDSEAMAP)",
          then: [
            text("\\bYou can use that to sail to Faraday Island."),
          ],
          else: [
            text("\\bOh, you don't have any space in your Bag for it."),
          ],
        ),
      ],
    ),
  ),
)