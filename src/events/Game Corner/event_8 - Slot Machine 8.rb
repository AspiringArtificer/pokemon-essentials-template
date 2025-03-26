event(
  id: 8,
  name: "Slot Machine 8",
  x: 5,
  y: 8,
  page_0: page(
    commands: condition(
      character: player,
      facing: :right,
      then: [
        script("pbSlotMachine"),
      ],
    ),
  ),
)