event(
  id: 14,
  name: "Rival",
  x: 18,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "trainer_RIVAL1",
    ),
    commands: [
      *comment(
        "This event should be somewhere where the player ",
        "can't possibly see it.",
        "It is moved from here to where it is needed when its ",
        "appearance is triggered.",
      ),
      *comment(
        "Note that this event does nothing except look like an ",
        "NPC (the Rival). The actual battle and movements ",
        "are done by the controlling event at the entrance of ",
        "this short path.",
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
)