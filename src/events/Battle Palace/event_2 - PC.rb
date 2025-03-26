event(
  id: 2,
  name: "PC",
  x: 7,
  y: 3,
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