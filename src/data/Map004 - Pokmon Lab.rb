# Lappet Town (2)
#   Pokémon Lab (4)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Lab", volume: 80),
  events: [

    event(
      id: 1,
      name: "Professor",
      x: 6,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "phone001",
        ),
        commands: [
          *text(
            "\\bOak: You should battle with your Pokémon to make ",
            "it strong.",
          ),
          *condition(
            script: "$player.has_pokegear",
            then: [
              *text(
                "\\bOak: If you register me in your Pokégear, you can ",
                "call me any time to rate your Pokédex completion.",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  script("Phone.add(4, \"Professor Oak\", 1)"),
                  text("\\bOak: Please let me know how you get on!"),
                ],
                choice2: [
                  *text(
                    "\\bOak: Oh, okay. Let me know if you change your ",
                    "mind.",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(3),
        graphic: graphic(
          name: "phone001",
        ),
        commands: [
          text("\\bOak: Well, which one do you want?"),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Turn back, size(3,1)",
      x: 5,
      y: 8,
      page_0: page(
        commands: [
          *comment(
            "This event is size 3x1. It is 3 tiles wide and 1 tile tall. ",
            "An event's size can be set by adding \"size(x,y)\" in the ",
            "event's name, where x and y are numbers.",
          ),
          *comment(
            "The event's placed position determines the bottom ",
            "left tile occupied by the event in-game.",
          ),
          *comment(
            "There are a lot of reasons to change an event's size. ",
            "Here, it is covering the whole distance between the ",
            "bookshelves with just one event, rather than needing ",
            "three events that do the same thing.",
          ),
        ],
      ),
      page_1: page(
        switch1: s(3),
        trigger: :player_touch,
        commands: [
          text("\\bOak: Wait, don't leave yet!"),
          *move_route(
            player,
            turn_180,
            move_forward,
          ),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Grass ball",
      x: 8,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          *text(
            "This ball contains a Pokémon caught by the ",
            "Professor.",
          ),
        ],
      ),
      page_1: page(
        switch1: s(3),
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          text("\\bOak: So, you want Bulbasaur, the grass Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              script("pbAddPokemon(:BULBASAUR, 5)"),
              control_switches(s(3), :OFF),
              control_variables(v(7), constant: 1),
              control_self_switch("A", :ON),
            ],
            choice2: [
              text("\\bOak: Choose carefully!"),
            ],
          ),
        ],
      ),
      page_2: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 5,
      name: "Fire ball",
      x: 9,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          *text(
            "This ball contains a Pokémon caught by the ",
            "Professor.",
          ),
        ],
      ),
      page_1: page(
        switch1: s(3),
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          text("\\bOak: So, you want Charmander, the fire Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              script("pbAddPokemon(:CHARMANDER, 5)"),
              control_switches(s(3), :OFF),
              control_variables(v(7), constant: 2),
              control_self_switch("A", :ON),
            ],
            choice2: [
              text("\\bOak: Choose carefully!"),
            ],
          ),
        ],
      ),
      page_2: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 6,
      name: "Water ball",
      x: 10,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          *text(
            "This ball contains a Pokémon caught by the ",
            "Professor.",
          ),
        ],
      ),
      page_1: page(
        switch1: s(3),
        graphic: graphic(
          name: "Object ball",
        ),
        commands: [
          text("\\bOak: So, you want Squirtle, the water Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              script("pbAddPokemon(:SQUIRTLE, 5)"),
              control_switches(s(3), :OFF),
              control_variables(v(7), constant: 3),
              control_self_switch("A", :ON),
            ],
            choice2: [
              text("\\bOak: Choose carefully!"),
            ],
          ),
        ],
      ),
      page_2: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 7,
      name: "Exit",
      x: 6,
      y: 13,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 2, x: 18, y: 13, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 8,
      name: "Controlling event",
      x: 7,
      y: 3,
      page_0: page(
        trigger: :autorun,
        commands: [
          *move_route(
            player,
            turn_up,
            move_forward,
            move_forward,
            move_forward,
            move_forward,
            move_forward,
            move_forward,
            move_forward,
            skippable: true,
          ),
          wait_completion,
          text("\\bOak: Here, take one of these rare Pokémon."),
          control_switches(s(3), :ON),
        ],
      ),
      page_1: page(
        switch1: s(3),
      ),
      page_2: page(
        variable: v(7),
        at_least: 1,
        trigger: :autorun,
        commands: [
          text("\\bOak: Ah, you made your choice!"),
          *condition(
            variable: v(7),
            operation: "==",
            constant: 1,
            then: [
              text("\\bOak: Bulbasaur, an excellent choice!"),
            ],
            else: condition(
              variable: v(7),
              operation: "==",
              constant: 2,
              then: [
                text("\\bOak: Charmander, an excellent choice!"),
              ],
              else: [
                text("\\bOak: Squirtle, an excellent choice!"),
              ],
            ),
          ),
          *text(
            "\\bOak: If I had a grandson, he would probably want ",
            "his own Pokémon around now...",
          ),
          control_self_switch("A", :ON),
        ],
      ),
      page_3: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 10,
      name: "Wall sign left",
      x: 6,
      y: 1,
      page_0: page(
        commands: [
          *text(
            "The event next to the Professor contains the autorun ",
            "commands.",
          ),
          *text(
            "There are two times it does something: when the ",
            "player first enters the map, and when the player has ",
            "chosen a starter.",
          ),
          *text(
            "The second time is on a higher page number. Page ",
            "numbers go in order of first to last cutscene, ",
            "including pages for pauses between them if relevant.",
          ),
        ],
      ),
    ),

    event(
      id: 11,
      name: "Wall sign right",
      x: 7,
      y: 1,
      page_0: page(
        commands: [
          *text(
            "Game Variable 7 should store 1 if the player ",
            "chose the Grass starter, 2 if they chose the Fire ",
            "starter, and 3 if they chose the Water starter.",
          ),
          *text(
            "This information can be used later in the game, e.g. ",
            "to determine which Pokémon the rival uses, and to ",
            "detect when the player has chosen a starter at all.",
          ),
        ],
      ),
    ),

    event(
      id: 12,
      name: "Pokédex",
      x: 4,
      y: 1,
      page_0: page(
        graphic: graphic(
          tile_id: 1718,
        ),
        commands: condition(
          script: "!$player.has_pokedex",
          then: [
            play_me(audio(name: "Item get")),
            text("\\PN received a Pokédex!"),
            script("$player.has_pokedex = true"),
            control_self_switch("A", :ON),
          ],
          else: [
            text("You already have a Pokédex."),
          ],
        ),
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 13,
      name: "Dex access",
      x: 3,
      y: 10,
      page_0: page(
        graphic: graphic(
          name: "trainer_SCIENTIST",
          direction: :right,
        ),
        commands: [
          *comment(
            "The numbers used for $Trainer.pokedex.lock(x) and ",
            "$Trainer.pokedex.unlock(x) are the ones defined in ",
            "the PBS file \"regionaldexes.txt\" for the ",
            "corresponding Regional Dex.",
            "The National Dex is not defined in that PBS file. It ",
            "uses the number -1 here.",
          ),
          label("Start"),
          *text(
            "\\bI can control your Pokédex access. What do you ",
            "want me to do?",
          ),
          *show_choices(
            choices: ["Kanto Dex access", "Johto Dex access", "National Dex access", "Exit"],
            cancellation: 4,
            choice1: [
              text("\\bWhat about it?"),
              *show_choices(
                choices: ["Unlock Kanto Dex", "Lock Kanto Dex", "Exit"],
                cancellation: 3,
                choice1: [
                  script("$player.pokedex.unlock(0)"),
                  text("\\bThe Kanto Dex was unlocked."),
                ],
                choice2: [
                  script("$player.pokedex.lock(0)"),
                  text("\\bThe Kanto Dex was locked."),
                ],
                choice3: [
                  jump_label("Start"),
                ],
              ),
            ],
            choice2: [
              text("\\bWhat about it?"),
              *show_choices(
                choices: ["Unlock Johto Dex", "Lock Johto Dex", "Exit"],
                cancellation: 3,
                choice1: [
                  script("$player.pokedex.unlock(1)"),
                  text("\\bThe Johto Dex was unlocked."),
                ],
                choice2: [
                  script("$player.pokedex.lock(1)"),
                  text("\\bThe Johto Dex was locked."),
                ],
                choice3: [
                  jump_label("Start"),
                ],
              ),
            ],
            choice3: [
              text("\\bWhat about it?"),
              *show_choices(
                choices: ["Unlock National Dex", "Lock National Dex", "Exit"],
                cancellation: 3,
                choice1: [
                  script("$player.pokedex.unlock(-1)"),
                  control_switches(s(29), :ON),
                  text("\\bThe National Dex was unlocked."),
                ],
                choice2: [
                  script("$player.pokedex.lock(-1)"),
                  control_switches(s(29), :OFF),
                  text("\\bThe National Dex was locked."),
                ],
                choice3: [
                  jump_label("Start"),
                ],
              ),
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
       521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  542,  542,  542,  542,  542,  542,  542,
       529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  542,  542,  542,  542,  542,  542,  542,
       656,  657,  657,  657,  657,  657,  657,  657,  657,  657,  657,  657,  657,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       656,  657,  657,  657,  657,  624,  624,  624,  657,  657,  657,  657,  657,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       634,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  624,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

      1788,    0,    0,    0,    0,    0, 1456, 1456, 1490, 1507, 1508, 1507, 1508,    0,    0,    0,    0,    0,    0,    0,
      1796, 1794, 1904, 1906, 1904, 1906, 1464, 1464, 1498, 1515, 1516, 1515, 1516,    0,    0,    0,    0,    0,    0,    0,
      1804, 1802, 1936, 1945, 1936, 1945,    0,    0,    0, 1523, 1524, 1523, 1524,    0,    0,    0,    0,    0,    0,    0,
      1732, 1784, 1785,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1732, 1792, 1793,    0,    0,    0,    0,    0, 2064, 2065, 2066,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1800, 1801,    0,    0,    0,    0,    0, 2072, 2073, 2074,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1509, 1507, 1508, 1507, 1508,    0,    0,    0, 1507, 1508, 1507, 1508, 1509,    0,    0,    0,    0,    0,    0,    0,
      1517, 1515, 1516, 1515, 1516,    0,    0,    0, 1515, 1516, 1515, 1516, 1517,    0,    0,    0,    0,    0,    0,    0,
      1525, 1523, 1524, 1523, 1524,    0,    0,    0, 1523, 1524, 1523, 1524, 1525,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0, 1844,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1851, 1852,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
