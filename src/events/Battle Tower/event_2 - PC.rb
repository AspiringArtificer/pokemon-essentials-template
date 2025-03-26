event(
  id: 2,
  name: "PC",
  x: 5,
  y: 8,
  page_0: page(
    commands: condition(
      character: player,
      facing: :up,
      then: [
        script("pbPokeCenterPC"),
      ],
    ),
  ),
)