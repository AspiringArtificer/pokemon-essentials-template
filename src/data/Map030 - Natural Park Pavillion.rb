# Natural Park (28)
#   Natural Park Pavillion (30)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Natural Park"),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 5,
      y: 9,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 28, x: 26, y: 6, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Man contest",
      x: 5,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "NPC 01",
        ),
        commands: condition(
          script: "pbIsWeekday(1, 2, 4, 6)",
          then: [
            *comment(
              "Today is Tuesday (2), Thursday (4) or Saturday (6), ",
              "and the Bug Contest is running today. The weekday's ",
              "name is put in Game Variable 1.",
            ),
            *condition(
              script: "pbBugContestState.pbContestHeld?",
              then: [
                *text(
                  "\\bWe hope you'll take part in a Bug-Catching Contest ",
                  "in the future!",
                ),
                exit_event_processing,
              ],
            ),
            text("\\bToday's \\v[1]."),
            text("\\bThat means the Bug-Catching Contest is on today."),
            text("\\bThe rules are simple."),
            *text(
              "\\bUsing one of your Pokémon, catch a Bug-type ",
              "Pokémon to be judged.",
            ),
            text("\\bWould you like to give it a try?"),
            *show_choices(
              choices: ["Yes", "No"],
              cancellation: 2,
              choice1: [
                *condition(
                  script: "pbBoxesFull?",
                  then: [
                    text("\\bSorry, your PC boxes are full."),
                    exit_event_processing,
                  ],
                ),
                *text(
                  "\\bYou are only allowed to take 1 Pokémon into the ",
                  "Contest.",
                ),
                *text(
                  "\\bPlease choose which Pokémon you want to enter ",
                  "with.",
                ),
                *comment(
                  "Opens a screen for choosing an able Pokémon (i.e. a ",
                  "non-egg, non-fainted Pokémon).",
                  "The party index of the chosen Pokémon is put in ",
                  "Game Variable 1, and the chosen Pokémon's name is ",
                  "put in Game Variable 2.",
                ),
                script("pbChooseAblePokemon(1, 2)"),
                *condition(
                  variable: v(1),
                  operation: "<",
                  constant: 0,
                  then: [
                    comment("Cancelled choosing a Pokémon."),
                    text("\\bOK. We hope you'll take part in the future."),
                    exit_event_processing,
                  ],
                  else: [
                    text("\\bYou will be entering with \\v[2], then."),
                    text("\\bWe'll hold your other Pokémon while you compete."),
                    *text(
                      "\\PN's Pokémon were left with the Contest ",
                      "Helper.\\se[Pkmn exp full]\\wtnp[20]",
                    ),
                    text("\\bHere are the Sport Balls for the Contest."),
                    text("\\PN received 20 Sport Balls.\\me[Item get]\\wtnp[40]"),
                    *text(
                      "\\bThe person who gets the strongest bug Pokémon is ",
                      "the winner.",
                    ),
                    text("\\bYou have 20 minutes."),
                    text("\\bIf you run out of Sport Balls, you're done."),
                    *text(
                      "\\bYou can keep the last Pokémon you catch as your ",
                      "own.",
                    ),
                    *text(
                      "\\bGo out and catch the strongest Bug-type Pokémon ",
                      "you can find!",
                    ),
                    *comment(
                      "- Set the map ID and X/Y coordinates of the spot the ",
                      "player is teleported to at the end for judging.",
                      "- Set the map IDs of reception maps which, if you ",
                      "enter them, will not immediately end the contest ",
                      "(those maps should prompt the player to go back into ",
                      "the contest's map or to end the contest).",
                    ),
                    *comment(
                      "- Set the map ID of the map where the contest takes ",
                      "place (there can only be one). NPC participants have ",
                      "random wild Pokémon found on this map.",
                      "- Set the party index of the Pokémon chosen by the ",
                      "player to use in the contest.",
                      "- Start the contest with 20 Sport Balls.",
                    ),
                    *script(
                      <<~'CODE'
                      contest = pbBugContestState
                      contest.pbSetJudgingPoint(30, 5, 6)
                      contest.pbSetReception(
                        "BugContestReception"
                      )
                      contest.pbSetContestMap(
                        "BugContest"
                      )
                      contest.pbSetPokemon(pbGet(1))
                      contest.pbStart(20)
                      CODE
                    ),
                    *condition(
                      character: player,
                      facing: :up,
                      then: [
                        *move_route(
                          player,
                          through_on,
                          move_down,
                          move_down,
                          move_down,
                          change_opacity(0),
                          through_off,
                        ),
                      ],
                      else: condition(
                        character: player,
                        facing: :left,
                        then: [
                          *move_route(
                            player,
                            through_on,
                            move_down,
                            move_left,
                            move_down,
                            move_down,
                            move_down,
                            change_opacity(0),
                            through_off,
                          ),
                        ],
                        else: [
                          *move_route(
                            player,
                            through_on,
                            move_down,
                            move_right,
                            move_down,
                            move_down,
                            move_down,
                            change_opacity(0),
                            through_off,
                          ),
                        ],
                      ),
                    ),
                    wait_completion,
                    play_se(audio(name: "Door exit", volume: 80)),
                    change_tone(red: -255, green: -255, blue: -255, frames: 6),
                    wait(8),
                    *move_route(
                      player,
                      change_opacity(255),
                    ),
                    transfer_player(map: 28, x: 26, y: 6, direction: :retain, fading: false),
                    change_tone(red: 0, green: 0, blue: 0, frames: 6),
                    exit_event_processing,
                  ],
                ),
              ],
              choice2: [
                text("\\bOK. We hope you'll take part in the future."),
              ],
            ),
          ],
          else: [
            comment("Today is not a Contest day."),
            *text(
              "\\bWe hold contests regularly in the Park. You should ",
              "give it a shot.",
            ),
          ],
        ),
      ),
      page_1: page(
        switch1: s(20),
      ),
      page_2: page(
        switch1: s(26),
        graphic: graphic(
          name: "NPC 01",
        ),
        trigger: :autorun,
        commands: [
          *comment(
            "Event page called when the contest is still in ",
            "progress.",
          ),
          wait(20),
          *text(
            "\\bYou still have some time left. Do you want to finish ",
            "now?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *text(
                "\\bPlease wait here for the announcement of the ",
                "winners.",
              ),
              script("pbBugContestState.pbStartJudging"),
            ],
            choice2: [
              text("\\bOK. Please go back outside and finish up."),
              *move_route(
                player,
                turn_down,
                route_wait(4),
                change_opacity(0),
              ),
              wait_completion,
              play_se(audio(name: "Door exit", volume: 80)),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              *move_route(
                player,
                change_opacity(255),
              ),
              transfer_player(map: 28, x: 26, y: 6, direction: :retain, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
        ],
      ),
      page_3: page(
        switch1: s(27),
        graphic: graphic(
          name: "NPC 01",
        ),
        trigger: :autorun,
        commands: [
          text("\\bWe will now judge the Pokémon you've caught."),
          text("......\\wt[10]\\n......"),
          *text(
            "\\bWe have chosen the winners!\\nAre you ready for ",
            "this?",
          ),
          script("pbBugContestState.pbGetPlaceInfo(2)"),
          text("\\bPlacing third is \\v[1], who caught a writhing \\v[2]!"),
          text("\\bThe score was \\v[3] points!"),
          script("pbBugContestState.pbGetPlaceInfo(1)"),
          *text(
            "\\bPlacing second is \\v[1], who caught a wriggling ",
            "\\v[2]!",
          ),
          text("\\bThe score was \\v[3] points!"),
          script("pbBugContestState.pbGetPlaceInfo(0)"),
          text("\\bThis Bug-Catching Contest winner is..."),
          text("\\b\\v[1], who caught a whopping \\v[2]!"),
          text("\\bThe score was \\v[3] points!"),
          *condition(
            script: "pbBugContestState.place == 0",
            then: condition(
              switch: s(29),
              value: :ON,
              then: [
                *script(
                  <<~'CODE'
                  evo_stones = [
                    :FIRESTONE, :THUNDERSTONE,
                    :WATERSTONE, :LEAFSTONE,
                    :MOONSTONE, :SUNSTONE,
                    :DUSKSTONE, :DAWNSTONE,
                    :SHINYSTONE, :OVALSTONE
                  ]
                  item = evo_stones.sample
                  pbSet(1, item)
                  data = GameData::Item.get(item)
                  pbSet(3, data.name)
                  CODE
                ),
                *text(
                  "\\me[Bug contest 1st]\\b\\PN, the First Place finisher, ",
                  "wins the \\v[3]!",
                ),
                script("pbReceiveItem(pbGet(1))"),
              ],
              else: [
                *text(
                  "\\me[Bug contest 1st]\\b\\PN, the First Place finisher, ",
                  "wins the Sun Stone!",
                ),
                script("pbReceiveItem(:SUNSTONE)"),
              ],
            ),
          ),
          *condition(
            script: "pbBugContestState.place == 1",
            then: [
              *text(
                "\\me[Bug contest 2nd]\\b\\PN, the Second Place finisher, ",
                "wins the Everstone!",
              ),
              script("pbReceiveItem(:EVERSTONE)"),
            ],
          ),
          *condition(
            script: "pbBugContestState.place == 2",
            then: [
              *text(
                "\\me[Bug contest 3rd]\\b\\PN, the Third Place finisher, ",
                "wins the Sitrus Berry!",
              ),
              script("pbReceiveItem(:SITRUSBERRY)"),
            ],
          ),
          *condition(
            script: "pbBugContestState.place == 3",
            then: [
              *text(
                "\\bEveryone else gets a Shed Shell as a consolation ",
                "prize!",
              ),
              script("pbReceiveItem(:SHEDSHELL)"),
            ],
          ),
          *text(
            "\\bWe'll return the Pokémon we kept for you. Here ",
            "you go!\\se[Pkmn exp full]",
          ),
          *text(
            "\\bWe hope you'll take part in a Bug-Catching Contest ",
            "in the future!",
          ),
          script("pbBugContestState.pbEnd"),
          script("setTempSwitchOn(\"A\")"),
        ],
      ),
      page_4: page(
        switch1: s(21),
        graphic: graphic(
          name: "NPC 01",
        ),
        commands: [
          *text(
            "\\bWe hope you'll take part in a Bug-Catching Contest ",
            "in the future!",
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Man regular",
      x: 5,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 01",
        ),
        commands: [
          comment("Today is not a Contest day."),
          *text(
            "\\bWe hold contests regularly in the Park. You should ",
            "give it a shot.",
          ),
        ],
      ),
      page_1: page(
        switch1: s(19),
      ),
    ),

    event(
      id: 4,
      name: "Contestant 1",
      x: 2,
      y: 5,
      page_0: page(
        graphic: graphic(
          direction: :up,
        ),
      ),
      page_1: page(
        switch1: s(27),
        graphic: graphic(
          name: "trainer_BUGCATCHER",
          direction: :right,
        ),
        commands: [
          *text(
            "Josh: \\bI study a lot, but that's not good enough to ",
            "win.",
          ),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Contestant 2",
      x: 3,
      y: 6,
      page_0: page(
        graphic: graphic(
          direction: :up,
        ),
      ),
      page_1: page(
        switch1: s(27),
        graphic: graphic(
          name: "trainer_CAMPER",
          direction: :up,
        ),
        commands: [
          *text(
            "Barry: \\bI work a lot, but that's not good enough to ",
            "win.",
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Contestant 3",
      x: 7,
      y: 6,
      page_0: page(
        graphic: graphic(
          direction: :up,
        ),
      ),
      page_1: page(
        switch1: s(27),
        graphic: graphic(
          name: "trainer_YOUNGSTER",
          direction: :up,
        ),
        commands: [
          *text(
            "Samuel: \\bI put lots of effort in, but that's not good ",
            "enough to win.",
          ),
        ],
      ),
    ),

    event(
      id: 7,
      name: "Contestant 4",
      x: 8,
      y: 5,
      page_0: page(
        graphic: graphic(
          direction: :left,
        ),
      ),
      page_1: page(
        switch1: s(27),
        graphic: graphic(
          name: "trainer_LASS",
          direction: :left,
        ),
        commands: [
          *text(
            "Abby: \\rI try my best, but that's not good enough to ",
            "win.",
          ),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
      2184, 2184, 2185, 2186, 2184, 2184, 2184, 2189, 2190, 2184, 2184,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2192, 2192, 2193, 2194, 2192, 2192, 2192, 2197, 2198, 2192, 2192,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2221, 2221, 2221, 2221, 2221, 2221, 2221, 2221, 2221, 2221,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 1195, 1196, 1196, 1196, 1196, 1196, 1197, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 1203, 1204, 1204, 1204, 1204, 1204, 1205, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 1203, 1204, 1204, 1204, 1204, 1204, 1205, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 1211, 1212, 1212, 1212, 1212, 1212, 1213, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      2221, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212, 2212,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0, 2008,    0,    0,    0,    0,    0, 2008,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0, 2017, 2002, 2002, 2002, 2002, 2002, 2019,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 2025, 2026, 2026, 2026, 2026, 2026, 2027,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
