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
)