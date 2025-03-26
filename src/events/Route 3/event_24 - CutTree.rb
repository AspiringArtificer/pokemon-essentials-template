event(
  id: 24,
  name: "CutTree",
  x: 44,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "Object tree 1",
    ),
    commands: [
      *move_route(
        this,
        turn_down,
      ),
      *condition(
        script: "pbCut",
        then: [
          script("pbSmashThisEvent"),
        ],
      ),
    ],
  ),
)