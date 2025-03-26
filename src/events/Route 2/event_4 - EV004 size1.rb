event(
  id: 4,
  name: "EV004 size(1,4)",
  x: 20,
  y: 49,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *comment(
        "This event is size 1x4. It is 1 tile wide and 4 tiles tall. ",
        "An event's size can be set by adding \"size(x,y)\" in the ",
        "event's name, where x and y are numbers.",
      ),
      *comment(
        "The event's placed position determines the bottom ",
        "left tile occupied by the event in-game.",
      ),
      *comment(
        "There are a lot of reasons to change an event's size. ",
        "Here, it is covering the whole path with just one ",
        "event, rather than needing four events that do the ",
        "same thing.",
      ),
      script("pbBridgeOn"),
    ],
  ),
)