event(
  id: 12,
  name: "SmashRock",
  x: 14,
  y: 9,
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