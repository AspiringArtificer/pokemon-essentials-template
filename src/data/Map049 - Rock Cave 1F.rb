# Route 7 (47)
#   Rock Cave 1F (49)
map(
  tileset_id: 6,
  autoplay_bgm: true,
  bgm: audio(name: "Cave", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit south",
      x: 12,
      y: 15,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          script("pbCaveExit"),
          transfer_player(map: 47, x: 46, y: 11, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Exit right",
      x: 20,
      y: 20,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          script("pbCaveExit"),
          transfer_player(map: 47, x: 56, y: 16, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Ladder",
      x: 10,
      y: 12,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 50, x: 11, y: 12, direction: :right, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Hole",
      x: 12,
      y: 7,
      page_0: page(
        through: true,
        trigger: :player_touch,
        commands: [
          wait(4),
          play_se(audio(name: "Player fall", volume: 80)),
          change_transparent_flag(:transparent),
          wait(4),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 50, x: 12, y: 7, direction: :retain, fading: false),
          change_transparent_flag(:normal),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 5,
      name: "NPC",
      x: 17,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 05",
        ),
        commands: [
          text("\\bCan you push that boulder onto the switch?"),
          *condition(
            self_switch: "A",
            value: :ON,
            then: [
              text("\\bOh! The boulder has been moved onto the switch!"),
              text("\\bWell done!"),
            ],
            else: [
              text("\\bOh. The boulder is not on the switch."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "StrengthBoulder",
      x: 12,
      y: 9,
      page_0: page(
        graphic: graphic(
          name: "Object boulder",
        ),
        move_speed: 2,
        trigger: :player_touch,
        commands: [
          script("pbPushThisBoulder"),
        ],
      ),
      page_1: page(
        switch1: s(57),
      ),
    ),

    event(
      id: 7,
      name: "StrengthBoulder",
      x: 19,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "Object boulder",
        ),
        move_speed: 2,
        trigger: :player_touch,
        commands: [
          script("pbPushThisBoulder"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "Object boulder",
        ),
        move_speed: 2,
      ),
    ),

    event(
      id: 8,
      name: "Boulder position checks",
      x: 6,
      y: 5,
      page_0: page(
        trigger: :parallel,
        commands: [
          comment("Boulder to be pushed down hole is event 6."),
          *condition(
            self_switch: "A",
            value: :OFF,
            then: [
              control_variables(v(4), character: character(6), property: :map_x),
              control_variables(v(5), character: character(6), property: :map_y),
              *condition(
                variable: v(4),
                operation: "==",
                constant: 12,
                then: condition(
                  variable: v(5),
                  operation: "==",
                  constant: 7,
                  then: [
                    comment("Is over hole."),
                    wait(8),
                    play_se(audio(name: "Battle throw", volume: 80)),
                    control_switches(s(57), :ON),
                    control_self_switch("A", :ON),
                  ],
                ),
              ),
            ],
          ),
          comment("Boulder to be pushed onto switch is event 7."),
          *comment(
            "There is more to this one because the boulder can be ",
            "pushed off the switch again.",
          ),
          *condition(
            self_switch: "B",
            value: :OFF,
            then: [
              control_variables(v(4), character: character(7), property: :map_x),
              control_variables(v(5), character: character(7), property: :map_y),
              *condition(
                variable: v(4),
                operation: "==",
                constant: 20,
                then: condition(
                  variable: v(5),
                  operation: "==",
                  constant: 7,
                  then: [
                    comment("Is on switch."),
                    wait(8),
                    play_se(audio(name: "Battle ball drop", volume: 80)),
                    script("pbSetSelfSwitch(5, \"A\", true)"),
                    control_self_switch("B", :ON),
                  ],
                ),
              ),
            ],
            else: [
              control_variables(v(4), character: character(7), property: :map_x),
              control_variables(v(5), character: character(7), property: :map_y),
              *condition(
                variable: v(4),
                operation: "!=",
                constant: 20,
                then: [
                  comment("Boulder has been moved off the switch."),
                  script("pbSetSelfSwitch(5, \"A\", false)"),
                  control_self_switch("B", :OFF),
                ],
                else: condition(
                  variable: v(5),
                  operation: "!=",
                  constant: 7,
                  then: [
                    comment("Boulder has been moved off the switch."),
                    script("pbSetSelfSwitch(5, \"A\", false)"),
                    control_self_switch("B", :OFF),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 9,
      name: "Sign",
      x: 14,
      y: 10,
      page_0: page(
        commands: [
          *text(
            "The positions of the boulders are checked by a ",
            "Parallel Process event.",
          ),
          *text(
            "The hole event must have its \"Through\" option set, to ",
            "allow boulder events to be pushed onto it.",
          ),
        ],
      ),
    ),

    event(
      id: 10,
      name: "SmashRock",
      x: 20,
      y: 15,
      page_0: page(
        graphic: graphic(
          name: "Object rock",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbRockSmash",
            then: [
              script("pbSmashThisEvent"),
              script("pbRockSmashRandomEncounter"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 11,
      name: "SmashRock",
      x: 20,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "Object rock",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbRockSmash",
            then: [
              script("pbSmashThisEvent"),
              script("pbRockSmashRandomEncounter"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 12,
      name: "SmashRock",
      x: 14,
      y: 9,
      page_0: page(
        graphic: graphic(
          name: "Object rock",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbRockSmash",
            then: [
              script("pbSmashThisEvent"),
              script("pbRockSmashRandomEncounter"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 13,
      name: "Dungeon ladder",
      x: 24,
      y: 14,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *comment(
            "Set which dungeon parameters are to be used for the ",
            "next dungeon map entered. These parameters are ",
            "defined in the PBS file dungeon_parameters.txt",
          ),
          *comment(
            "You can set the following:",
            "$PokemonGlobal.dungeon_area = :forest",
            "$PokemonGlobal.dungeon_version = 42",
          ),
          script("$PokemonGlobal.dungeon_area = :cave"),
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 51, x: 0, y: 0, direction: :right, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 14,
      name: "Dungeon sign",
      x: 24,
      y: 13,
      page_0: page(
        commands: [
          text("This ladder leads to a random dungeon."),
          *text(
            "The levels of Pokémon within are based on the levels ",
            "of Pokémon in the player's party.",
          ),
          *text(
            "This is because the dungeon map's metadata gives it ",
            "the \"ScaleWildEncounterLevels\" flag.",
          ),
        ],
      ),
    ),

    event(
      id: 15,
      name: "Tile puzzles",
      x: 24,
      y: 8,
      page_0: page(
        commands: [
          text("Which tile puzzle do you want to play?"),
          *show_choices(
            choices: ["Alph", "Alph Rotator", "Mystic Square", "Tile Swap"],
            cancellation: 0,
            choice1: [
              *comment(
                "A jigsaw puzzle. All tiles start in trays on either side ",
                "of the grid.",
              ),
              *condition(
                script: "pbTilePuzzle(1, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
            choice2: [
              *comment(
                "A jigsaw puzzle. All tiles start in trays on either side ",
                "of the grid. Each tile can be rotated.",
              ),
              *condition(
                script: "pbTilePuzzle(2, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
            choice3: [
              *comment(
                "Also known as the 15 puzzle. All tiles (except for one) ",
                "start in random places in the grid. Use the empty tile ",
                "space to slide tiles around and rearrange them to ",
                "create the picture. The missing tile is the bottom right ",
                "one in the completed picture.",
              ),
              *condition(
                script: "pbTilePuzzle(3, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
            choice4: [
              *comment(
                "All tiles start in random places in the grid. By choosing ",
                "and swapping pairs of adjacent tiles, unscramble the ",
                "picture.",
              ),
              *condition(
                script: "pbTilePuzzle(4, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
          ),
          *show_choices(
            choices: ["Tile Swap Rotator", "Rubik's Square", "Star Rotator", "Cancel"],
            cancellation: 4,
            choice1: [
              *comment(
                "All tiles start in random places in the grid. By choosing ",
                "and swapping pairs of adjacent tiles, unscramble the ",
                "picture. Each tile can be rotated.",
              ),
              *condition(
                script: "pbTilePuzzle(5, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
            choice2: [
              *comment(
                "All tiles start in random places in the grid. Slide a ",
                "whole row of tiles left/right, or a whole column of tiles ",
                "up/down at a time. The tile that falls off one side of ",
                "the grid appears on the other side. Unscramble the ",
                "picture.",
              ),
              *condition(
                script: "pbTilePuzzle(6, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
            choice3: [
              *comment(
                "All tiles start in their proper places in the grid, but are ",
                "randomly rotated. When one tile is rotated, all tiles ",
                "touching one of its sides are also rotated.",
              ),
              *condition(
                script: "pbTilePuzzle(7, \"Kabuto\")",
                then: [
                  text("Puzzle solved!"),
                ],
                else: [
                  text("Gave up..."),
                ],
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 16,
      name: "EV016",
      x: 18,
      y: 10,
      page_0: page(
        commands: [
          *comment(
            "This event is empty, but prevents boulders from ",
            "being pushed over it.",
          ),
        ],
      ),
    ),

  ],
  data: table(
    x: 34,
    y: 29,
    z: 3,
    data: [
       513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  536,  513,  513,  513,  513,  513,  513,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  536,  513,  513,  513,  513,  536,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  610,  610,  610,  549,  610,  610,  610,  609,  610,  610,  610,  610,  611,  610,  610,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  610,  610,  610,  610,  610,  610,  610,  609,  610,  610,  610,  610,  611,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  536,  513,  513,  610,  610,  610,  610,  610,  610,  610,  610,  610,  617,  618,  618,  618,  618,  619,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  536,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  658,  658,  659,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  536,  513,  513,  513,  513,  513,  666,  666,  667,  541,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  542,  543,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  666,  666,  676,  659,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  550,  551,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  666,  666,  666,  667,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  541,  610,  610,  513,  513,  513,  513,  536,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  666,  666,  666,  667,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  658,  658,  659,  610,  610,  610,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  666,  666,  667,  610,  610,  610,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  666,  666,  676,  659,  610,  610,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  666,  666,  667,  610,  610,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  666,  666,  676,  658,  658,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,
       536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  666,  666,  666,  666,  666,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  536,  513,  513,  513,  666,  666,  666,  666,  666,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,
       513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,  536,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  510,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  511,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  514,  510,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  511,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  514,  514,  565,  557,    0,    0,  557,  504,  601,  602,  602,  602,  602,  603,  506,  512,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,  510,  522,  514,  566,    0,    0,    0,    0,  512,    0,    0,    0,    0,  455,    0,  514,  512,  520,  521,  521,  511,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  510,  522,  565,  514,  559,    0,    0,    0,    0,  512,    0,    0,    0,    0,    0,    0,  514,  520,  521,  521,  511,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  510,  521,  522,  567,    0,    0,    0,    0,  512,    0,    0,    0,    0,    0,    0,  514,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  514,  557,    0,    0,    0,    0,    0,  447,  520,  521,  521,  539,  521,  521,  521,  522,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  447,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  514,  565,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  514,  518,  505,  505,  505,  507,  508,  509,  505,  506,    0,    0,  557,  557,    0,    0,    0,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  518,  505,  505,  505,  528,  505,  505,  505,  506,  514,    0,    0,    0,  557,  504,  505,  505,  528,  505,  505,  519,  512,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,    0,  512,  504,  505,  505,  505,  505,  505,  519,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  518,  506,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  518,  506,  514,    0,    0,    0,  515,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  514,    0,    0,    0,  512,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  514,  518,  505,  505,  505,  519,  512,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  518,  505,  505,  505,  505,  505,  519,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  558,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  433,  434,  435,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  441,  442,  443,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  516,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
