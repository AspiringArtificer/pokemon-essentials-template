event(
  id: 2,
  name: "Galarian Yamask evo right size(1,4)",
  x: 33,
  y: 15,
  page_0: page(
    trigger: :player_touch,
    commands: condition(
      character: player,
      facing: :left,
      then: [
        script("pbEvolutionEvent(2)"),
      ],
    ),
  ),
)