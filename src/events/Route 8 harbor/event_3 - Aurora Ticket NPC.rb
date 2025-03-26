event(
  id: 3,
  name: "Aurora Ticket NPC",
  x: 6,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "trainer_SAILOR",
      direction: :right,
    ),
    commands: condition(
      script: "$bag.has?(:AURORATICKET)",
      then: [
        *text(
          "\\bI've already given you an Aurora Ticket. Have you ",
          "gone to Berth Island yet?",
        ),
      ],
      else: [
        text("\\bHere, have this Aurora Ticket."),
        *condition(
          script: "pbReceiveItem(:AURORATICKET)",
          then: [
            text("\\bYou can use that to sail to Berth Island."),
          ],
          else: [
            text("\\bOh, you don't have any space in your Bag for it."),
          ],
        ),
      ],
    ),
  ),
)