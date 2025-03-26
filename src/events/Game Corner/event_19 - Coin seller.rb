event(
  id: 19,
  name: "Coin seller",
  x: 4,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 07",
    ),
    commands: [
      text("\\G\\CN\\bWelcome to Rocket Game Corner!"),
      *condition(
        script: "!$bag.has?(:COINCASE)",
        then: [
          *text(
            "\\G\\CN\\bDo you need some game coins?\\nWould you ",
            "like to buy some?",
          ),
          text("\\G\\CN\\bYou don't have a Coin Case."),
        ],
        else: [
          label("Start menu"),
          *text(
            "\\G\\CN\\bDo you need some game coins?\\nWould you ",
            "like to buy some?",
          ),
          *show_choices(
            choices: ["50 coins [$1,000]", "500 coins [$10,000]", "Exit"],
            cancellation: 3,
            choice1: [
              *condition(
                script: "$player.coins + 50 >= Settings::MAX_COINS",
                then: [
                  text("\\G\\CN\\bWhoops!\\nYour Coin Case is full."),
                ],
                else: condition(
                  gold: 999,
                  operation: "<=",
                  then: [
                    text("\\G\\CN\\bYou can't afford the coins."),
                  ],
                  else: [
                    change_gold("-=", constant: 1000),
                    script("$player.coins += 50"),
                    play_se(audio(name: "Mart buy item")),
                    text("\\G\\CN\\bThank you\\nHere are your coins!"),
                  ],
                ),
              ),
            ],
            choice2: [
              *condition(
                script: "$player.coins + 500 >= Settings::MAX_COINS",
                then: [
                  text("\\G\\CN\\bWhoops!\\nYour Coin Case is full."),
                ],
                else: condition(
                  gold: 9999,
                  operation: "<=",
                  then: [
                    text("\\G\\CN\\bYou can't afford the coins."),
                  ],
                  else: [
                    change_gold("-=", constant: 10000),
                    script("$player.coins += 500"),
                    play_se(audio(name: "Mart buy item")),
                    text("\\G\\CN\\bThank you\\nHere are your coins!"),
                  ],
                ),
              ),
            ],
            choice3: [
              text("\\G\\CN\\bNo?\\nPlease come play sometime!"),
              exit_event_processing,
            ],
          ),
          jump_label("Start menu"),
        ],
      ),
    ],
  ),
)