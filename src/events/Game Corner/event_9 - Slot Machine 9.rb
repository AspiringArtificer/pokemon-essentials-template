event(
  id: 9,
  name: "Slot Machine 9",
  x: 5,
  y: 9,
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