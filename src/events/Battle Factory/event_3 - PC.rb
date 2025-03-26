event(
  id: 3,
  name: "PC",
  x: 6,
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