event(
  id: 1,
  name: "Galarian Yamask evo left size(1,4)",
  x: 30,
  y: 15,
  page_0: page(
    trigger: :player_touch,
    commands: condition(
      character: player,
      facing: :right,
      then: [
        script("pbEvolutionEvent(2)"),
      ],
    ),
  ),
)