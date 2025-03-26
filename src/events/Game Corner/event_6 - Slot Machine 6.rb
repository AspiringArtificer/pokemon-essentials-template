event(
  id: 6,
  name: "Slot Machine 6",
  x: 5,
  y: 6,
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