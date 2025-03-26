event(
  id: 23,
  name: "EV023 size(2,1)",
  x: 14,
  y: 69,
  page_0: page(
    trigger: :player_touch,
    commands: [
      *comment(
        "This event is size 2x1. It is 2 tiles wide and 1 tile tall. ",
        "An event's size can be set by adding \"size(x,y)\" in the ",
        "event's name, where x and y are numbers.",
      ),
      *comment(
        "The event's placed position determines the bottom ",
        "left tile occupied by the event in-game.",
      ),
      *comment(
        "There are a lot of reasons to change an event's size. ",
        "Here, it is covering the whole width of the stairs with ",
        "just one event, rather than needing two events that ",
        "do the same thing.",
      ),
      script("pbBridgeOff"),
    ],
  ),
)