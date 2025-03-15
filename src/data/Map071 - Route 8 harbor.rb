# Route 8 (69)
#   Route 8 harbor (71)
map(
  tileset_id: 15,
  autoplay_bgm: true,
  bgm: audio(name: "Route 1", volume: 80),
  events: [

    event(
      id: 1,
      name: "Door",
      x: 8,
      y: 2,
      page_0: page(
        graphic: graphic(
          pattern: 3,
        ),
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 69, x: 31, y: 15, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
      page_1: page(
        switch1: s(22),
        graphic: graphic(
          pattern: 3,
        ),
        trigger: :autorun,
        commands: [
          *condition(
            script: "get_self.onEvent?",
            then: [
              script("Followers.hide_followers"),
              *move_route(
                player,
                route_play_se(audio(name: "Door exit", volume: 80)),
                move_down,
                skippable: true,
              ),
              wait_completion,
              script("Followers.put_followers_on_player"),
            ],
          ),
          script("setTempSwitchOn(\"A\")"),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Sailor",
      x: 8,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "trainer_SAILOR",
          direction: :up,
        ),
        commands: [
          *script(
            <<~'CODE'
            hide_choice(2,
              !$bag.has?(:AURORATICKET))
            hide_choice(3,
              !$bag.has?(:OLDSEAMAP))
            CODE
          ),
          text("\\bAhoy, there!\\nWhere do you want to sail?"),
          *show_choices(
            choices: ["Tiall Region", "Berth Island", "Faraday Island", "Exit"],
            cancellation: 4,
            choice1: [
              text("\\bThe Tiall Region it is. All aboard!"),
              *move_route(
                character(2),
                through_on,
                move_down,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                through_on,
                move_down,
                move_down,
                through_off,
              ),
              wait_completion,
              play_se(audio(name: "Door exit", volume: 80)),
              change_transparent_flag(:transparent),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              change_transparent_flag(:normal),
              transfer_player(map: 75, x: 17, y: 11, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              text("\\bBerth Island it is. All aboard!"),
              control_switches(s(51), :ON),
              *move_route(
                character(2),
                through_on,
                move_down,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                through_on,
                move_down,
                move_down,
                through_off,
              ),
              wait_completion,
              play_se(audio(name: "Door exit", volume: 80)),
              change_transparent_flag(:transparent),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              change_transparent_flag(:normal),
              transfer_player(map: 72, x: 14, y: 23, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice3: [
              text("\\bFaraday Island it is. All aboard!"),
              control_switches(s(52), :ON),
              *move_route(
                character(2),
                through_on,
                move_down,
                change_opacity(0),
                through_off,
              ),
              *move_route(
                player,
                through_on,
                move_down,
                move_down,
                through_off,
              ),
              wait_completion,
              play_se(audio(name: "Door exit", volume: 80)),
              change_transparent_flag(:transparent),
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              change_transparent_flag(:normal),
              transfer_player(map: 73, x: 14, y: 23, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice4: [
              text("\\bLet me know if you want to set sail."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Aurora Ticket NPC",
      x: 6,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_SAILOR",
          direction: :right,
        ),
        commands: condition(
          script: "$bag.has?(:AURORATICKET)",
          then: [
            *text(
              "\\bI've already given you an Aurora Ticket. Have you ",
              "gone to Berth Island yet?",
            ),
          ],
          else: [
            text("\\bHere, have this Aurora Ticket."),
            *condition(
              script: "pbReceiveItem(:AURORATICKET)",
              then: [
                text("\\bYou can use that to sail to Berth Island."),
              ],
              else: [
                text("\\bOh, you don't have any space in your Bag for it."),
              ],
            ),
          ],
        ),
      ),
    ),

    event(
      id: 4,
      name: "Old Sea Map NPC",
      x: 10,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_SAILOR",
          direction: :left,
        ),
        commands: condition(
          script: "$bag.has?(:OLDSEAMAP)",
          then: [
            *text(
              "\\bI've already given you an Old Sea Map. Have you ",
              "gone to Faraday Island yet?",
            ),
          ],
          else: [
            text("\\bHere, have this Old Sea Map."),
            *condition(
              script: "pbReceiveItem(:OLDSEAMAP)",
              then: [
                text("\\bYou can use that to sail to Faraday Island."),
              ],
              else: [
                text("\\bOh, you don't have any space in your Bag for it."),
              ],
            ),
          ],
        ),
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       384,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  391,  421,  421,  421,
       392,  393,  393,  395,  393,  395,  394,  396,  397,  398,  393,  395,  393,  395,  393,  393,  399,  421,  421,  421,
       400,  401,  401,  401,  401,  401,  402,  404,  405,  406,  401,  401,  401,  401,  401,  401,  407,  421,  421,  421,
       408,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,  415,  421,  421,  421,
       409,  409,  409,  409,  409,  411,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  418,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  418,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  421,  421,  421,
       421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
       421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
       421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       449,  449,  449,  449,  449,  434,    0,    0,    0,    0,    0,  432,  449,  449,  449,  449,  449,    0,    0,    0,
        68,   68,   68,   68,   84,  442,    0,    0,    0,    0,    0,  440,   82,   68,   68,   68,   68,    0,    0,    0,
        48,   48,   48,   48,   72,  443,  449,  436,    0,  435,  449,  444,   64,   48,   48,   48,   48,    0,    0,    0,
        48,   48,   48,   48,   50,   68,   68,   68,  457,   68,   68,   68,   49,   48,   48,   48,   48,    0,    0,    0,
        48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,    0,    0,    0,
        48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,    0,    0,    0,
        48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,    0,    0,    0,
        76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,    0,    0,    0,
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
         0,    0,    0,    0,    0,    0,  499,  500,  501,  502,  503,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  507,  508,  509,  510,  511,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  515,  516,  517,  518,  519,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
