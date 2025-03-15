# Cedolan City (7)
#   Game Corner (13)
map(
  tileset_id: 12,
  autoplay_bgm: true,
  bgm: audio(name: "Game Corner", volume: 80),
  events: [

    event(
      id: 1,
      name: "Slot Machine 1",
      x: 0,
      y: 6,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 2,
      name: "Slot Machine 2",
      x: 0,
      y: 7,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 3,
      name: "Slot Machine 3",
      x: 0,
      y: 8,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 4,
      name: "Slot Machine 4",
      x: 0,
      y: 9,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 5,
      name: "Slot Machine 5",
      x: 0,
      y: 10,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 6,
      name: "Slot Machine 6",
      x: 5,
      y: 6,
      page_0: page(
        commands: condition(
          character: player,
          facing: :right,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 7,
      name: "Slot Machine 7",
      x: 5,
      y: 7,
      page_0: page(
        commands: condition(
          character: player,
          facing: :right,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 8,
      name: "Slot Machine 8",
      x: 5,
      y: 8,
      page_0: page(
        commands: condition(
          character: player,
          facing: :right,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 9,
      name: "Slot Machine 9",
      x: 5,
      y: 9,
      page_0: page(
        commands: condition(
          character: player,
          facing: :right,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 10,
      name: "Slot Machine 10",
      x: 5,
      y: 10,
      page_0: page(
        commands: condition(
          character: player,
          facing: :right,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 11,
      name: "Slot Machine 11",
      x: 6,
      y: 6,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 12,
      name: "Slot Machine 12",
      x: 6,
      y: 7,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 13,
      name: "Slot Machine 13",
      x: 6,
      y: 8,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 14,
      name: "Slot Machine 14",
      x: 6,
      y: 9,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

    event(
      id: 15,
      name: "Slot Machine 15",
      x: 6,
      y: 10,
      page_0: page(
        commands: condition(
          character: player,
          facing: :left,
          then: [
            script("pbSlotMachine"),
          ],
        ),
      ),
    ),

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
    ),

    event(
      id: 17,
      name: "Lottery",
      x: 9,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 23",
        ),
        commands: [
          *text(
            "\\rThis is the Pokémon Lottery Corner. I'm Felicity, your ",
            "attendant today.",
          ),
          *text(
            "\\rIf the drawn number matches the ID No. of any of ",
            "your Pokémon, you could win fabulous gifts.",
          ),
          text("\\rWould you like to check today's lucky number?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *text(
                "\\rFirst, I'll look up today's Pokémon Lottery Corner ",
                "lucky number.",
              ),
              text("..."),
              *comment(
                "This line of code calculates a winning ID number ",
                "depending on the date, and puts it in Game Variable ",
                "1.",
              ),
              script("pbSetLotteryNumber(1)"),
              text("\\rYour Loto Ticket number is \\v[1]."),
              *text(
                "\\rNow, let's see if it matches the ID No. of any of your ",
                "Pokémon.",
              ),
              *comment(
                "This line of code checks all Pokémon in the player's ",
                "party and storage for one that best matches the ",
                "given ID number. The Pokémon's name is put in Game ",
                "Variable 2, its location (1=party, 2=storage) is put in ",
                "Game Variable 3, and the number of digits matched is ",
                "put in Game Variable 4.",
              ),
              script("pbLottery(pbGet(1), 2, 3, 4)"),
              *condition(
                variable: v(4),
                operation: "==",
                constant: 0,
                then: [
                  comment("No digits were matched."),
                  text("\\rI'm sorry. You didn't get a match..."),
                  text("\\rPlease do visit again."),
                ],
                else: [
                  script("$stats.lottery_prize_count += 1"),
                  comment("1 or more digits were matched."),
                  *comment(
                    "Show a message depending on whether the matching ",
                    "Pokémon is in the player's party or Pokémon storage.",
                  ),
                  *condition(
                    variable: v(3),
                    operation: "==",
                    constant: 1,
                    then: [
                      text("\\rCongratulations!"),
                      *text(
                        "\\rThe ID number of your team's \\v[2] matches your ",
                        "Loto Ticket number!",
                      ),
                    ],
                    else: [
                      text("\\rCongratulations!"),
                      *text(
                        "\\rThe ID number of your PC-boxed \\v[2] matches your ",
                        "Loto Ticket number!",
                      ),
                    ],
                  ),
                  *comment(
                    "Award a prize based on how many digits were ",
                    "matched.",
                  ),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 5,
                    then: [
                      text("\\rOh my goodness, all five digits matched!"),
                      text("\\rYou've won the jackpot prize!"),
                      *condition(
                        script: "pbReceiveItem(:MASTERBALL)",
                        then: [
                          *text(
                            "\\rPlease do visit again! Good-bye from Felicity, your ",
                            "attendant!",
                          ),
                          script("pbSetEventTime"),
                        ],
                        else: [
                          *text(
                            "\\rYou have no room left. Make room, then come see ",
                            "me.",
                          ),
                          script("setVariable(:MASTERBALL)"),
                          control_self_switch("B", :ON),
                        ],
                      ),
                    ],
                  ),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 4,
                    then: [
                      *text(
                        "\\rThe last four digits matched, so you win the first ",
                        "prize!",
                      ),
                      *condition(
                        script: "pbReceiveItem(:MAXREVIVE)",
                        then: [
                          *text(
                            "\\rPlease do visit again! Good-bye from Felicity, your ",
                            "attendant!",
                          ),
                          script("pbSetEventTime"),
                        ],
                        else: [
                          *text(
                            "\\rYou have no room left. Make room, then come see ",
                            "me.",
                          ),
                          script("setVariable(:MAXREVIVE)"),
                          control_self_switch("B", :ON),
                        ],
                      ),
                    ],
                  ),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 3,
                    then: [
                      *text(
                        "\\rThe last three digits matched, so you win the ",
                        "second prize!",
                      ),
                      *condition(
                        script: "pbReceiveItem(:EXPSHARE)",
                        then: [
                          *text(
                            "\\rPlease do visit again! Good-bye from Felicity, your ",
                            "attendant!",
                          ),
                          script("pbSetEventTime"),
                        ],
                        else: [
                          *text(
                            "\\rYou have no room left. Make room, then come see ",
                            "me.",
                          ),
                          script("setVariable(:EXPSHARE)"),
                          control_self_switch("B", :ON),
                        ],
                      ),
                    ],
                  ),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 2,
                    then: [
                      *text(
                        "\\rThe last two digits matched, so you win the third ",
                        "prize!",
                      ),
                      *condition(
                        script: "pbReceiveItem(:PPUP)",
                        then: [
                          *text(
                            "\\rPlease do visit again! Good-bye from Felicity, your ",
                            "attendant!",
                          ),
                          script("pbSetEventTime"),
                        ],
                        else: [
                          *text(
                            "\\rYou have no room left. Make room, then come see ",
                            "me.",
                          ),
                          script("setVariable(:PPUP)"),
                          control_self_switch("B", :ON),
                        ],
                      ),
                    ],
                  ),
                  *condition(
                    variable: v(4),
                    operation: "==",
                    constant: 1,
                    then: [
                      text("\\rThe last digit matched, so you win the fourth prize!"),
                      *condition(
                        script: "pbReceiveItem(:ULTRABALL)",
                        then: [
                          *text(
                            "\\rPlease do visit again! Good-bye from Felicity, your ",
                            "attendant!",
                          ),
                          script("pbSetEventTime"),
                        ],
                        else: [
                          *text(
                            "\\rYou have no room left. Make room, then come see ",
                            "me.",
                          ),
                          script("setVariable(:ULTRABALL)"),
                          control_self_switch("B", :ON),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
            choice2: [
              text("\\rOh, I see.\\nPlease do visit us again."),
            ],
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "NPC 23",
        ),
        commands: [
          *text(
            "\\rYou've already drawn a Loto Ticket today. Please ",
            "come back tomorrow.",
          ),
        ],
      ),
      page_2: page(
        switch1: s(24),
        self_switch: "A",
        graphic: graphic(
          name: "NPC 23",
        ),
        trigger: :autorun,
        commands: [
          control_self_switch("A", :OFF),
          script("setTempSwitchOn(\"A\")"),
        ],
      ),
      page_3: page(
        self_switch: "B",
        graphic: graphic(
          name: "NPC 23",
        ),
        commands: [
          text("\\rI've been waiting for you. Here's the item you won."),
          *condition(
            script: "pbReceiveItem(getVariable())",
            then: [
              control_self_switch("B", :OFF),
              script("pbSetEventTime"),
            ],
            else: [
              *text(
                "\\rYou have no room left. Make room, then come see ",
                "me.",
              ),
            ],
          ),
        ],
      ),
    ),

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
    ),

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
    ),

    event(
      id: 20,
      name: "Exit",
      x: 9,
      y: 14,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 34, y: 20, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 21,
      name: "Coin Case giver",
      x: 3,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 08",
        ),
        commands: [
          text("\\rWelcome!"),
          *condition(
            script: "!$bag.has?(:COINCASE)",
            then: [
              text("\\rOh, you don't have a Coin Case? Here."),
              *condition(
                script: "pbReceiveItem(:COINCASE)",
                then: [
                  *text(
                    "\\rYou can exchange your coins for fabulous prizes ",
                    "next door.",
                  ),
                ],
                else: [
                  *text(
                    "\\rYou don't have any room for it. Come back when ",
                    "you do.",
                  ),
                ],
              ),
            ],
            else: [
              *text(
                "\\rYou can exchange your coins for fabulous prizes ",
                "next door.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 22,
      name: "Triple Triad explainer",
      x: 13,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 08",
        ),
        commands: [
          text("\\rI'm here to explain the rules of Triple Triad."),
          label("Choices"),
          text("\\rWhich topic do you want to learn about?"),
          *show_choices(
            choices: ["Basics", "Game rules", "Prizes", "Exit"],
            cancellation: 4,
            choice1: [
              *text(
                "\\rTriple Triad is a game played with special cards ",
                "placed on a 3x3 board.",
              ),
              *text(
                "\\rEach card has 4 numbers on it, one per side.  ",
                "These numbers are so-called stats.",
              ),
              *text(
                "\\rPlayers take turns placing cards on the board. As ",
                "they do so, they try to capture and gain control of ",
                "their opponent's cards.",
              ),
              *text(
                "\\rThat's where the numbers come in. If a player ",
                "places a card with a higher number next to a card ",
                "with a lower number, the player captures that card.",
              ),
              *text(
                "\\rThus, the goal of the game is to gain control of more ",
                "cards than the other player by the end of the game.",
              ),
              jump_label("Choices"),
            ],
            choice2: [
              *text(
                "\\rThere are a number of optional game rules you can ",
                "apply to individual games.",
              ),
              *text(
                "\\rThey can affect card stats, how cards capture ",
                "each other, the scoring and the prizes.",
              ),
              jump_label("Choices"),
            ],
            choice3: [
              *text(
                "\\rWhen you win a game, you will recive 1 random ",
                "card from your opponent from their Deck.",
              ),
              *text(
                "\\rThis also works the other way around: if you lose, ",
                "you have to give your opponent one of your cards, ",
                "chosen at random.",
              ),
              *text(
                "\\rYou can change what you win or lose from a game ",
                "by using an optional game rule.",
              ),
              jump_label("Choices"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 23,
      name: "Triple Triad card shop",
      x: 14,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
        ),
        commands: [
          label("Shop Start"),
          text("\\bWelcome to the Triad Card Shop."),
          label("Choices"),
          *show_choices(
            choices: ["Buy Cards", "Sell Cards", "Information", "Exit"],
            cancellation: 4,
            choice1: [
              script("pbBuyTriads"),
              text("\\bAnything else I can do for you?"),
              jump_label("Choices"),
            ],
            choice2: [
              script("pbSellTriads"),
              text("\\bAnything else I can do for you?"),
              jump_label("Choices"),
            ],
            choice3: [
              *text(
                "\\bHere is where you can purchase new cards for ",
                "Triple Triad duels.",
              ),
              *text(
                "\\bThe selection grows as you catch and find new ",
                "Pokémon, so check often.",
              ),
              *text(
                "\\bAnd, of course, stronger Pokémon cards cost more ",
                "than weaker cards.",
              ),
              *text(
                "\\bYou don't have to use this shop in your game. It's ",
                "just an example of how the player could gain Triple ",
                "Triad cards. You could implement other ways.",
              ),
              jump_label("Shop Start"),
            ],
            choice4: [
              text("\\bPlease come again."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 24,
      name: "Triple Triad duel",
      x: 16,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_YOUNGSTER",
          direction: :left,
        ),
        commands: [
          text("\\bI'm ready to duel with you."),
          *condition(
            script: "pbCanTriadDuel?",
            then: [
              *comment(
                "The two numbers are the min and max level of the ",
                "opponent respectively. Each number can be between ",
                "0 and 9 inclusive, and the max level must be higher ",
                "than or equal to the min level.",
              ),
              script("pbTriadDuel(\"Jack\", 0, 5)"),
            ],
            else: [
              *text(
                "\\bOh, you don't have enough cards to play. You need ",
                "at least 5.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 25,
      name: "Triple Triad duel with rules",
      x: 16,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "trainer_LASS",
          direction: :left,
        ),
        commands: [
          text("\\rReady for a real rule duel?"),
          *condition(
            script: "pbCanTriadDuel?",
            then: [
              *comment(
                "This duel includes certain battle rules. See the wiki ",
                "for details of what rules can be applied.",
              ),
              *script(
                <<~'CODE'
                pbTriadDuel("Alice", 0, 5,
                  ["countunplayed",
                  "samewins",
                  "elements",
                  "direct"]
                )
                CODE
              ),
            ],
            else: [
              *text(
                "\\rOh, you don't have enough cards to play. You need ",
                "at least 5.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 26,
      name: "Triple Triad duel with deck",
      x: 16,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "trainer_CAMPER",
          direction: :left,
        ),
        commands: [
          text("\\bI built my deck specially for this!"),
          *condition(
            script: "pbCanTriadDuel?",
            then: [
              *comment(
                "This duel has no special rules, and has a predefined ",
                "opponent's deck. The level numbers are unused, but ",
                "still need to be defined (each being 0-9).",
              ),
              *script(
                <<~'CODE'
                pbTriadDuel("Tim", 0, 5, nil,
                  [:BULBASAUR, :CHARMANDER,
                   :SQUIRTLE, :PIKACHU, :CLEFAIRY]
                )
                CODE
              ),
            ],
            else: [
              *text(
                "\\bOh, you don't have enough cards to play. You need ",
                "at least 5.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 27,
      name: "Triple Triad duel with prize",
      x: 16,
      y: 8,
      page_0: page(
        graphic: graphic(
          name: "trainer_COOLTRAINER_F",
          direction: :left,
        ),
        commands: [
          text("\\rIf you win, I'll give you an Arceus card!"),
          *condition(
            script: "pbCanTriadDuel?",
            then: [
              *comment(
                "This duel has a prize card defined, which the player ",
                "gets if they win (ignoring any rule which affects ",
                "prizes).  If the player draws or loses, however, the ",
                "rules apply normally.",
              ),
              *script(
                <<~'CODE'
                pbTriadDuel("Sophie", 0, 5, nil, nil,
                  :ARCEUS
                )
                CODE
              ),
            ],
            else: [
              *text(
                "\\rOh, you don't have enough cards to play. You need ",
                "at least 5.",
              ),
            ],
          ),
        ],
      ),
    ),

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
    ),

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
    ),

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
    ),

    event(
      id: 31,
      name: "Shop exit",
      x: 4,
      y: 30,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 39, y: 19, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 32,
    z: 3,
    data: [
       384,  384,  384,  384,  385,  386,  387,  384,  384,  384,  384,  384,  384,  385,  386,  387,  384,  384,  479,  479,
       392,  392,  392,  392,  393,  394,  395,  392,  392,  392,  392,  392,  392,  393,  394,  395,  392,  392,  479,  479,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  479,  479,
       409,  409,  409,  409,  409,  409,  409,  410,  409,  409,  409,  410,  409,  409,  409,  409,  409,  410,  479,  479,
       409,  425,  417,  417,  417,  417,  417,  418,  425,  417,  417,  418,  425,  417,  417,  417,  417,  418,  479,  479,
       409,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,
       409,  411,  400,  400,  400,  409,  409,  411,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,
       409,  410,  400,  400,  400,  409,  409,  410,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,
       409,  410,  400,  400,  400,  409,  409,  410,  400,  400,  409,  409,  409,  411,  400,  400,  400,  400,  479,  479,
       409,  410,  400,  400,  400,  409,  409,  410,  400,  400,  409,  409,  409,  410,  400,  400,  400,  400,  479,  479,
       409,  410,  400,  400,  400,  409,  409,  410,  400,  400,  409,  409,  409,  410,  400,  400,  400,  400,  479,  479,
       409,  418,  400,  400,  400,  425,  417,  418,  400,  400,  425,  417,  417,  418,  400,  400,  400,  400,  479,  479,
       409,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,
       409,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       384,  384,  384,  385,  386,  387,  384,  384,  384,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       392,  392,  392,  393,  394,  395,  392,  392,  392,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  417,  417,  417,  417,  417,  417,  417,  417,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  409,  411,  400,  400,  400,  400,  409,  409,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  409,  410,  400,  400,  400,  400,  407,  409,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       409,  400,  400,  400,  400,  400,  400,  400,  400,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
       479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,

         0,    0,  488,  489,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       499,  604,  496,  497,    0,    0,  604,    0,  604,    0,  604,    0,  604,    0,    0,    0,  604,  499,    0,    0,
       507,  597,  504,  505,  571,  613,  599,    0,  597,  598,  599,    0,  597,  614,  598,  614,  599,  507,    0,    0,
         0,  605,  623,  577,  579,  621,  607,    0,  605,  606,  607,    0,  605,  622,  606,  622,  607,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       513,    0,    0,    0,    0,  512,  513,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  486,    0,    0,
       521,  532,    0,    0,  524,  520,  521,  532,    0,    0,    0,    0,    0,    0,    0,    0,    0,  494,    0,    0,
       521,  532,    0,    0,  524,  520,  521,  532,    0,    0,  525,  526,  527,    0,    0,    0,    0,  518,    0,    0,
       521,  532,    0,    0,  524,  520,  521,  532,    0,    0,  533,  534,  535,    0,    0,    0,    0,  486,    0,    0,
       521,  532,    0,    0,  524,  520,  521,  532,    0,    0,  544,  545,  546,    0,    0,    0,    0,  494,    0,    0,
       529,  532,    0,    0,  524,  528,  529,  532,    0,    0,  552,  553,  554,    0,    0,    0,    0,  518,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       499,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  509,    0,    0,
       507,    0,    0,    0,    0,    0,    0,    0,  468,  469,  470,    0,    0,    0,    0,    0,    0,  517,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  476,  477,  478,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  488,  489,    0,    0,    0,  488,  489,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       604,  496,  497,    0,    0,    0,  496,  497,  604,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       597,  504,  505,  614,  598,  614,  504,  505,  599,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       605,  622,  606,  622,  606,  622,  606,  622,  607,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       480,  481,    0,    0,    0,    0,    0,  480,  481,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       496,  497,    0,    0,    0,    0,    0,  496,  497,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       504,  505,    0,    0,    0,    0,    0,  504,  505,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,  468,  469,  470,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,  476,  477,  478,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  615,  569,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  536,  537,  538,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  614,  598,    0,    0,    0,  598,  614,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
