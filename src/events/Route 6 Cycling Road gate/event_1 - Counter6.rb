event(
  id: 1,
  name: "Counter(6)",
  x: 6,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
    ),
    trigger: :event_touch,
    commands: [
      *comment(
        "This event can notice the player at a distance even ",
        "though an impassable tile (the desk) is in the way. ",
        "This is because this event's name contains the text ",
        "\"Counter(X)\", where \"X\" is the number of tiles in front ",
        "of itself that it can see.",
      ),
      *condition(
        script: "$bag.has?(:BICYCLE)",
        then: [
          script("setTempSwitchOn(\"A\")"),
        ],
        else: [
          script("pbExclaim(get_self)"),
          *text(
            "\\bSorry, you can't enter Cycle Road without a ",
            "Bicycle.",
          ),
          *move_route(
            player,
            turn_right,
            move_right,
          ),
        ],
      ),
    ],
  ),
  page_1: page(
    switch1: s(21),
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: [
      text("\\bCycling Road is a great ride."),
    ],
  ),
)