event(
  id: 29,
  name: "Prize vendor middle",
  x: 4,
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
        choices: ["Abra - 180 coins", "Clefairy - 500 coins", "Dratini - 2800 coins", "Scyther - 5500 coins"],
        cancellation: 0,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :ABRA)
            pbSet(2, 180)
            pbSet(4, 9)   # Level
            CODE
          ),
        ],
        choice2: [
          *script(
            <<~'CODE'
            pbSet(1, :CLEFAIRY)
            pbSet(2, 500)
            pbSet(4, 8)   # Level
            CODE
          ),
        ],
        choice3: [
          *script(
            <<~'CODE'
            pbSet(1, :DRATINI)
            pbSet(2, 2800)
            pbSet(4, 18)   # Level
            CODE
          ),
        ],
        choice4: [
          *script(
            <<~'CODE'
            pbSet(1, :SCYTHER)
            pbSet(2, 5500)
            pbSet(4, 25)   # Level
            CODE
          ),
        ],
      ),
      *show_choices(
        choices: ["Porygon - 9999 coins", "No thanks"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            pbSet(1, :PORYGON)
            pbSet(2, 9999)
            pbSet(4, 26)   # Level
            CODE
          ),
        ],
        choice2: [
          text("\\CN\\bPlease save your Coins and come again!"),
          exit_event_processing,
        ],
      ),
      comment("================================"),
      comment("Chose a Pokémon, try to buy it."),
      comment("================================"),
      *condition(
        script: "$player.party_full?",
        then: [
          *text(
            "\\CN\\bYour party's full!\\nPlease make some room ",
            "before you come back.",
          ),
          exit_event_processing,
        ],
      ),
      *script(
        <<~'CODE'
        sp = GameData::Species.get(pbGet(1))
        pbSet(3, sp.name)
        CODE
      ),
      text("\\CN\\bWould you like \\v[3]?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *condition(
            script: "pbGet(2) > $player.coins",
            then: [
              text("\\CN\\bSorry, you'll need more coins than that."),
            ],
            else: [
              text("\\CN\\bHere you go!\\1"),
              play_se(audio(name: "Mart buy item")),
              script("$player.coins -= pbGet(2)"),
              *script(
                <<~'CODE'
                pbAddPokemonSilent(
                  pbGet(1), pbGet(4)
                )
                CODE
              ),
              text("\\CN\\PN received the \\v[3]!"),
            ],
          ),
        ],
      ),
      jump_label("Choice"),
    ],
  ),
)