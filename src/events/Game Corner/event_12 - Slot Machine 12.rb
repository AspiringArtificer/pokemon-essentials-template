event(
  id: 12,
  name: "Slot Machine 12",
  x: 6,
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