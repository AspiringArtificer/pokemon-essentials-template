event(
  id: 12,
  name: "SmashRock",
  x: 58,
  y: 14,
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