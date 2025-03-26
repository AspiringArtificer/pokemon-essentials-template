event(
  id: 7,
  name: "Slot Machine 7",
  x: 5,
  y: 7,
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