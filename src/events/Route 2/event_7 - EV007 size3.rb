event(
  id: 7,
  name: "EV007 size(3,1)",
  x: 14,
  y: 31,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *comment(
        "This event is size 3x1. It is 3 tiles wide and 1 tile tall. ",
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
        "event, rather than needing three events that do the ",
        "same thing.",
      ),
      script("pbBridgeOff"),
    ],
  ),
)