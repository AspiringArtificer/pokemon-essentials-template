event(
  id: 28,
  name: "Prize vendor left",
  x: 2,
  y: 23,
  page_0: page(
    graphic: graphic(
      name: "NPC 07",
    ),
    commands: [
      text("\\CN\\bWe exchange your coins for prizes."),
      label("Choice"),
      text("\\CN\\bWhich prize would you like?"),
      *show_choices(
        choices: ["Smoke Ball - 800 coins", "Miracle Seed - 1000 coins", "Charcoal - 1000 coins", "Mystic Water - 1000 coins"],
        cancellation: 0,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :SMOKEBALL)
            pbSet(2, 800)
            CODE
          ),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1, :MIRACLESEED)
            pbSet(2, 1000)
            CODE
          ),
        ],
        choice3: [
          *script(
            <<~'CODE'
            pbSet(1, :CHARCOAL)
            pbSet(2, 1000)
            CODE
          ),
        ],
        choice4: [
          *script(
            <<~'CODE'
            pbSet(1, :MYSTICWATER)
            pbSet(2, 1000)
            CODE
          ),
        ],
      ),
      *show_choices(
        choices: ["Yellow Flute - 1600 coins", "No thanks"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :YELLOWFLUTE)
            pbSet(2, 1600)
            CODE
          ),
        ],
        choice2: [
          text("\\CN\\bPlease save your Coins and come again!"),
          exit_event_processing,
        ],
      ),
      comment("================================"),
      comment("Chose an item, try to buy it."),
      comment("================================"),
      *script(
        <<~'CODE'
        itm = GameData::Item.get(pbGet(1))
        pbSet(3, itm.name)
        CODE
      ),
      text("\\CN\\bSo, you want the \\v[3]?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *condition(
            script: "pbGet(2) > $player.coins",
            then: [
              text("\\CN\\bSorry, you'll need more coins than that."),
            ],
            else: condition(
              script: "$bag.can_add?(pbGet(1))",
              then: [
                text("\\CN\\bHere you go!\\1"),
                play_se(audio(name: "Mart buy item")),
                script("$player.coins -= pbGet(2)"),
                script("pbBuyPrize(pbGet(1))"),
              ],
              else: [
                text("\\CN\\bYou have no room in your Bag."),
              ],
            ),
          ),
        ],
      ),
      jump_label("Choice"),
    ],
  ),
)