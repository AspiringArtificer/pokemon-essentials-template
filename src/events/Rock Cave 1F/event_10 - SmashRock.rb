event(
  id: 10,
  name: "SmashRock",
  x: 20,
  y: 15,
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