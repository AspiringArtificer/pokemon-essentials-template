event(
  id: 30,
  name: "Prize vendor right",
  x: 6,
  y: 23,
  page_0: page(
    graphic: graphic(
      name: "NPC 07",
    ),
    commands: [
      text("\\CN\\bWe exchange your coins for prizes."),
      label("Choice"),
      *comment(
        "The \"Show Choices\" command doesn't let you type in ",
        "long choice names, so a choice name as long as",
        "\"TM24 Thunderbolt - 4000 coins\"",
        "won't fit.",
      ),
      *comment(
        "You could use rename_choice here to replace the ",
        "choice names. rename_choice doesn't have a limit on ",
        "the length of the choice name it sets.",
      ),
      *comment(
        "However, doing so here to include the moves' names ",
        "in the choices will usually make the choice window too ",
        "wide, and it will overlap the coins window.",
      ),
      *comment(
        "This event settles for showing the move's name in the ",
        "message below, upon choosing an item.",
      ),
      text("\\CN\\bWhich prize would you like?"),
      *show_choices(
        choices: ["TM13 - 4000 coins", "TM23 - 3500 coins", "TM24 - 4000 coins", "TM30 - 4500 coins"],
        cancellation: 0,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :TM13)
            pbSet(2, 4000)
            CODE
          ),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1, :TM23)
            pbSet(2, 3500)
            CODE
          ),
        ],
        choice3: [
          *script(
            <<~'CODE'
            pbSet(1, :TM24)
            pbSet(2, 4000)
            CODE
          ),
        ],
        choice4: [
          *script(
            <<~'CODE'
            pbSet(1, :TM30)
            pbSet(2, 4500)
            CODE
          ),
        ],
      ),
      *show_choices(
        choices: ["TM35 - 4000 coins", "No thanks"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :TM35)
            pbSet(2, 4000)
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
        move = itm.move
        mov = GameData::Move.get(move)
        pbSet(3, itm.name + " " + mov.name)
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