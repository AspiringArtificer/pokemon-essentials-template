event(
  id: 18,
  name: "Voltorb Flip man",
  x: 11,
  y: 8,
  page_0: page(
    graphic: graphic(
      name: "NPC 17",
    ),
    commands: condition(
      self_switch: "A",
      value: :OFF,
      then: [
        text("\\bMy name is Mr. Game!"),
        *text(
          "\\bMy heart pounds with excitement when people ",
          "enjoy my Coin game!",
        ),
        text("\\bIn fact, that's what I live for!\\nGo ahead and play it!"),
        text("\\bMake my heart pound with excitement!"),
        control_self_switch("A", :ON),
      ],
      else: [
        text("\\bGo ahead and play my Coin game!"),
        text("\\bMake my heart pound with excitement!"),
      ],
    ),
  ),
)