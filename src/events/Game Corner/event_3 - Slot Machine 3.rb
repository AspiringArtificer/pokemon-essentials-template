event(
  id: 3,
  name: "Slot Machine 3",
  x: 0,
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