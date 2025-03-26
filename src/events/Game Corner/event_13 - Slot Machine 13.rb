event(
  id: 13,
  name: "Slot Machine 13",
  x: 6,
  y: 8,
  page_0: page(
    commands: condition(
      character: player,
      facing: :left,
      then: [
        script("pbSlotMachine"),
      ],
    ),
  ),
)