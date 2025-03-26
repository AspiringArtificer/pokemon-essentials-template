event(
  id: 15,
  name: "Slot Machine 15",
  x: 6,
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