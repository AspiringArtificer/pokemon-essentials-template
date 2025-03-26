event(
  id: 11,
  name: "Slot Machine 11",
  x: 6,
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