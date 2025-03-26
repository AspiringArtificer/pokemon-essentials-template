event(
  id: 29,
  name: "CutTree",
  x: 51,
  y: 31,
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