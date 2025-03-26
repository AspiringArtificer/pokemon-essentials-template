event(
  id: 10,
  name: "Lab sign, size(2,1)",
  x: 33,
  y: 28,
  page_0: page(
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
        "Here, it is covering the whole sign with just one ",
        "event, rather than needing two events that do the ",
        "same thing.",
      ),
      text("\\w[signskin]Pokémon Institute"),
      text("\\w[signskin]\"Building Tomorrow Out Of Yesterday\""),
    ],
  ),
)