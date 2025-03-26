event(
  id: 5,
  name: "Slot Machine 5",
  x: 0,
  y: 10,
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