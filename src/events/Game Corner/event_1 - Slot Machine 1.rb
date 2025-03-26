event(
  id: 1,
  name: "Slot Machine 1",
  x: 0,
  y: 6,
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