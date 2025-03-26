event(
  id: 2,
  name: "Turn back, size(3,1)",
  x: 5,
  y: 8,
  page_0: page(
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
        "Here, it is covering the whole distance between the ",
        "bookshelves with just one event, rather than needing ",
        "three events that do the same thing.",
      ),
    ],
  ),
  page_1: page(
    switch1: s(3),
    trigger: :player_touch,
    commands: [
      text("\\bOak: Wait, don't leave yet!"),
      *move_route(
        player,
        turn_180,
        move_forward,
      ),
    ],
  ),
)