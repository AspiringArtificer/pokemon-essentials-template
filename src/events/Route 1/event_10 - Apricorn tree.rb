event(
  id: 10,
  name: "Apricorn tree",
  x: 10,
  y: 10,
  page_0: page(
    graphic: graphic(
      name: "Object tree 2",
      hue: 300,
    ),
    commands: [
      comment("Gives 1 random Apricorn each time."),
      *comment(
        "For demonstration purposes only - Apricorn trees ",
        "should provide a fixed Apricorn, have a 24 hour delay ",
        "(like Kurt does), and should look different to ",
        "Headbutt trees.",
      ),
      *script(
        <<~'CODE'
        apricorns = [
          :REDAPRICORN,
          :YELLOWAPRICORN,
          :BLUEAPRICORN,
          :GREENAPRICORN,
          :PINKAPRICORN,
          :WHITEAPRICORN,
          :BLACKAPRICORN
        ]
        CODE
      ),
      *script(
        <<~'CODE'
        random_item = apricorns.sample
        pbItemBall(random_item)
        CODE
      ),
    ],
  ),
)