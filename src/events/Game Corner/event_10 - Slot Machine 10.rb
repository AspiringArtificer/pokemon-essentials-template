event(
  id: 10,
  name: "Slot Machine 10",
  x: 5,
  y: 10,
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