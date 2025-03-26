event(
  id: 22,
  name: "SmashRock",
  x: 51,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "Object rock",
    ),
    commands: [
      *move_route(
        this,
        turn_down,
      ),
      *condition(
        script: "pbRockSmash",
        then: [
          script("pbSmashThisEvent"),
          script("pbRockSmashRandomEncounter"),
        ],
      ),
    ],
  ),
)