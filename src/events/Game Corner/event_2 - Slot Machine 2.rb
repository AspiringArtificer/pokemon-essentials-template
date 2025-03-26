event(
  id: 2,
  name: "Slot Machine 2",
  x: 0,
  y: 7,
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