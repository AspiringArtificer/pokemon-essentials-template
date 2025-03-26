event(
  id: 14,
  name: "Slot Machine 14",
  x: 6,
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