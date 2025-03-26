event(
  id: 7,
  name: "Vendor",
  x: 12,
  y: 21,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      *comment(
        "Poké Balls are cheaper on Saturdays (day 6).",
        "If the first value (the 0) is greater than 0, then the ",
        "name of today (\"Saturday\") is stored in the Game ",
        "Variable of that number.",
      ),
      *condition(
        script: "pbIsWeekday(0, 6)",
        then: [
          text("\\bWe're having a sale today. 25% off all Poké Balls."),
          *comment(
            "setPrice(item, buy price, sell price)",
            "If the sell price isn't given, it will be half of the buy ",
            "price. If the sell price is 0, the player cannot sell it to ",
            "the Mart.",
          ),
          *comment(
            "You can use this to change the sell price of items sold ",
            "by the player to the Mart, even if the Mart doesn't ",
            "stock them.",
            "Price changes only apply to the next call to ",
            "pbPokemonMart. After that, they are forgotten.",
          ),
          *script(
            <<~'CODE'
            setPrice(:GREATBALL, 450)
            setPrice(:ULTRABALL, 600)
            setPrice(:TIMERBALL, 750)
            setPrice(:REPEATBALL, 750)
            CODE
          ),
        ],
      ),
      *comment(
        "This vendor is selling a Key Item, the Silph Scope. If ",
        "the player has a Silph Scope already, it will not ",
        "appear in the vendor's inventory.",
        "Key Items sold by vendors/Marts should have a non-",
        "zero price.",
      ),
      script("setPrice(:SILPHSCOPE, 5000)"),
      *condition(
        switch: s(12),
        value: :ON,
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :SILPHSCOPE,
              :GREATBALL, :ULTRABALL,
              :LEMONADE, :SODAPOP, :FRESHWATER,
              :MOOMOOMILK,
              :TIMERBALL, :REPEATBALL,
              :LAVACOOKIE
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *script(
        <<~'CODE'
        pbPokemonMart([
          :SILPHSCOPE,
          :GREATBALL, :ULTRABALL,
          :SODAPOP, :FRESHWATER
        ])
        CODE
      ),
    ],
  ),
)