event(
  id: 16,
  name: "Voltorb Flip",
  x: 11,
  y: 10,
  page_0: page(
    commands: [
      *move_route(
        character(18),
        turn_down,
      ),
      wait_completion,
      *text(
        "\\bMr. Game: Show me how you play and make my ",
        "heart pound with excitement!",
      ),
      script("pbVoltorbFlip"),
    ],
  ),
)