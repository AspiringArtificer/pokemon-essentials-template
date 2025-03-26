event(
  id: 4,
  name: "Slot Machine 4",
  x: 0,
  y: 9,
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