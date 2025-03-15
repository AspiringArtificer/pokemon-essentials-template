# Safari Zone outside (66)
#   Safari Zone gate (67)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Safari Zone exterior", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 4,
      y: 8,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 66, x: 12, y: 7, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Counter(4)",
      x: 7,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "NPC 07",
          direction: :left,
        ),
        trigger: :event_touch,
        commands: [
          *comment(
            "This event can notice the player at a distance even ",
            "though an impassable tile (the desk) is in the way. ",
            "This is because this event's name contains the text ",
            "\"Counter(X)\", where \"X\" is the number of tiles in front ",
            "of itself that it can see.",
          ),
          text("\\bWelcome to the Safari Zone!"),
          *move_route(
            player,
            turn_right,
          ),
          text("\\G\\bFor just $500, you can play the Safari Game."),
          *text(
            "\\G\\bYou can roam the wide-open Safari Zone and ",
            "catch whatever you like.",
          ),
          text("\\G\\bWould you like to play?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *condition(
                script: "pbBoxesFull?",
                then: [
                  text("\\G\\bSorry, your PC boxes are full."),
                  *move_route(
                    player,
                    move_down,
                  ),
                  wait_completion,
                  exit_event_processing,
                ],
              ),
              *condition(
                gold: 499,
                operation: "<=",
                then: [
                  text("\\G\\bOops!\\nNot enough money!"),
                  text("\\G\\bCome again."),
                  *move_route(
                    player,
                    move_down,
                  ),
                  wait_completion,
                  exit_event_processing,
                ],
                else: [
                  text("\\G\\bThat'll be $500, please!\\1"),
                  change_gold("-=", constant: 500),
                  play_se(audio(name: "Mart buy item")),
                  text("\\G\\bWe only use a special kind of Poké Ball here."),
                  *text(
                    "\\G\\PN received 30 Safari Balls from the attendant.",
                    "\\me[Item get]\\wtnp[40]",
                  ),
                  *text(
                    "\\G\\bWe'll call you on the PA when you run out of time ",
                    "or Safari Balls.",
                  ),
                  text("\\G\\bWell, I'll wish you the best of luck!"),
                  *condition(
                    script: "$game_player.x == 3",
                    then: [
                      *move_route(
                        player,
                        turn_up,
                        move_up,
                        move_right,
                        move_up,
                        change_opacity(0),
                      ),
                    ],
                    else: condition(
                      script: "$game_player.x == 5",
                      then: [
                        *move_route(
                          player,
                          turn_up,
                          move_up,
                          move_left,
                          move_up,
                          change_opacity(0),
                        ),
                      ],
                      else: [
                        *move_route(
                          player,
                          turn_up,
                          move_up,
                          move_up,
                          change_opacity(0),
                        ),
                      ],
                    ),
                  ),
                  wait_completion,
                  script("Followers.follow_into_door"),
                  wait_completion,
                  script("pbSafariState.pbStart(30)"),
                  play_se(audio(name: "Door exit", volume: 80)),
                  change_tone(red: -255, green: -255, blue: -255, frames: 6),
                  wait(8),
                  *move_route(
                    player,
                    change_opacity(255),
                  ),
                  transfer_player(map: 68, x: 25, y: 27, direction: :retain, fading: false),
                  change_tone(red: 0, green: 0, blue: 0, frames: 6),
                  exit_event_processing,
                ],
              ),
            ],
            choice2: [
              text("\\G\\bOkay.\\nPlease come again!"),
              *move_route(
                player,
                move_down,
              ),
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(25),
        graphic: graphic(
          name: "NPC 07",
          direction: :left,
        ),
        trigger: :autorun,
        commands: [
          *move_route(
            player,
            move_down,
          ),
          wait_completion,
          *condition(
            script: "pbSafariState.decision == 0",
            then: [
              text("\\bAre you going to leave the Safari Zone early?"),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  text("\\bPlease return any Safari Balls you may have left."),
                  script("pbSafariState.pbEnd"),
                  *move_route(
                    player,
                    move_down,
                    move_down,
                    skippable: true,
                  ),
                  wait_completion,
                  exit_event_processing,
                ],
                choice2: [
                  text("\\bGood luck!"),
                  *move_route(
                    player,
                    move_up,
                    change_opacity(0),
                  ),
                  wait_completion,
                  script("Followers.follow_into_door"),
                  wait_completion,
                  play_se(audio(name: "Door exit", volume: 80)),
                  change_tone(red: -255, green: -255, blue: -255, frames: 6),
                  wait(8),
                  *move_route(
                    player,
                    change_opacity(255),
                  ),
                  transfer_player(map: 68, x: 25, y: 27, direction: :retain, fading: false),
                  change_tone(red: 0, green: 0, blue: 0, frames: 6),
                  exit_event_processing,
                ],
              ),
            ],
          ),
          *condition(
            script: "pbSafariState.decision == 1",
            then: [
              text("\\bDid you catch your fair share? Come again!"),
              script("pbSafariState.pbEnd"),
              *move_route(
                player,
                move_down,
                move_down,
                skippable: true,
              ),
              wait_completion,
            ],
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
       400,  400,  400,  401,  402,  403,  400,  400,  400,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       408,  408,  408,  409,  410,  411,  408,  408,  408,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1092, 1094, 1093,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1095, 1086, 1085,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1095, 1086, 1085,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1095, 1086, 1085,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1095, 1086, 1085,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       696,  696,  696, 1095, 1086, 1085,  696,  696,  696,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1772, 1772, 2032,    0,    0,    0, 2032, 1772, 1772,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1780, 1780, 2048,    0,    0,    0, 2048, 1780, 1780,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1727, 1670, 2048,    0,    0,    0, 2048, 1670, 1727,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1735,    0, 2048,    0,    0,    0, 2048,    0, 1749,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1743,    0, 2048,    0,    0,    0, 2048,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1751, 1670, 2048,    0,    0,    0, 2048, 1670, 1727,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1749,    0, 2056, 1245, 1246, 1247, 2056,    0, 1749,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
