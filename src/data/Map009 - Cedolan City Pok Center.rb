# Cedolan City (7)
#   Cedolan City Poké Center (9)
map(
  tileset_id: 4,
  autoplay_bgm: true,
  bgm: audio(name: "Poke Center"),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 7,
      y: 9,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 47, y: 10, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Nurse",
      x: 7,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "NPC 16",
        ),
        commands: [
          *comment(
            "This line of code sets the player's current position as ",
            "the spot they will return to after they lose a battle ",
            "and lack out.",
            "Page 2 of this event detects when this happens, and ",
            "heals the player's Pokémon and wishes them better ",
            "luck in future.",
          ),
          script("pbSetPokemonCenter"),
          text("\\rHello, and welcome to the Pokémon Center."),
          text("\\rWe restore your tired Pokémon to full health."),
          text("\\rWould you like to rest your Pokémon?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\rOK, I'll take your Pokémon for a few seconds."),
              script("$stats.poke_center_count += 1"),
              recover_all(0),
              comment("Nurse turns to face the healing machine."),
              *move_route(
                this,
                turn_left,
                route_wait(2),
              ),
              wait_completion,
              *comment(
                "Nurse places Poké Balls on the healing machine one at ",
                "a time.",
              ),
              control_variables(v(1), property: :party_members),
              control_variables(v(6), constant: 0),
              label("Place ball"),
              control_variables(v(6), "+=", constant: 1),
              play_se(audio(name: "Battle ball shake", volume: 80)),
              wait(8),
              *condition(
                variable: v(6),
                operation: "<",
                other_variable: v(1),
                then: [
                  jump_label("Place ball"),
                ],
              ),
              comment("Healing animation and ME jingle."),
              *move_route(
                character(4),
                step_anime_on,
              ),
              play_me(audio(name: "Pkmn healing")),
              wait(58),
              *comment(
                "Poké Balls are removed from healing machine, nurse ",
                "turns to face the player.",
              ),
              control_variables(v(6), constant: 0),
              script("get_character(4).pattern = 0"),
              *move_route(
                character(4),
                step_anime_off,
              ),
              *move_route(
                this,
                route_wait(15),
                turn_down,
              ),
              wait_completion,
              comment("Pokérus check."),
              *condition(
                script: "pbPokerus?",
                then: [
                  text("\\rYour Pokémon may be infected by Pokérus."),
                  *text(
                    "\\rLittle is known about the Pokérus except that they ",
                    "are microscopic life-forms that attach to Pokémon.",
                  ),
                  *text(
                    "\\rWhile infected, Pokémon are said to grow ",
                    "exceptionally well.",
                  ),
                  control_switches(s(2), :ON),
                ],
                else: [
                  text("\\rThank you for waiting."),
                  text("\\rWe've restored your Pokémon to full health."),
                  comment("Nurse bows."),
                  *move_route(
                    this,
                    change_graphic(name: "NPC 16", pattern: 1),
                    route_wait(10),
                    change_graphic(name: "NPC 16"),
                  ),
                  wait_completion,
                  text("\\rWe hope to see you again!"),
                ],
              ),
            ],
            choice2: [
              text("\\rWe hope to see you again!"),
            ],
          ),
        ],
      ),
      page_1: page(
        switch1: s(1),
        graphic: graphic(
          name: "NPC 16",
        ),
        trigger: :autorun,
        commands: [
          *comment(
            "Every map you can end up in after having all your ",
            "Pokémon faint (typically Poké Centers and home) ",
            "must have an Autorun event in it like this one.",
            "This event fully heals all the player's Pokémon, says ",
            "something to that effect, and turns the \"Starting ",
            "over\" switch OFF again.",
          ),
          *comment(
            "For convenience, this can be a single page in an ",
            "NPC's event (e.g. Mom, a nurse).",
          ),
          *text(
            "\\rFirst, you should restore your Pokémon to full ",
            "health.",
          ),
          script("$stats.poke_center_count += 1"),
          recover_all(0),
          comment("Nurse turns to face the healing machine."),
          *move_route(
            this,
            turn_left,
            route_wait(2),
          ),
          wait_completion,
          *comment(
            "Nurse places Poké Balls on the healing machine one at ",
            "a time.",
          ),
          control_variables(v(1), property: :party_members),
          control_variables(v(6), constant: 0),
          label("Place ball"),
          control_variables(v(6), "+=", constant: 1),
          play_se(audio(name: "Battle ball shake", volume: 80)),
          wait(8),
          *condition(
            variable: v(6),
            operation: "<",
            other_variable: v(1),
            then: [
              jump_label("Place ball"),
            ],
          ),
          comment("Healing animation and ME jingle."),
          *move_route(
            character(4),
            step_anime_on,
          ),
          play_me(audio(name: "Pkmn healing")),
          wait(58),
          *comment(
            "Poké Balls are removed from healing machine, nurse ",
            "turns to face the player.",
          ),
          control_variables(v(6), constant: 0),
          script("get_character(4).pattern = 0"),
          *move_route(
            character(4),
            step_anime_off,
          ),
          *move_route(
            this,
            route_wait(15),
            turn_down,
          ),
          wait_completion,
          text("\\rYour Pokémon have been healed to perfect health."),
          comment("Nurse bows."),
          *move_route(
            this,
            change_graphic(name: "NPC 16", pattern: 1),
            route_wait(10),
            change_graphic(name: "NPC 16"),
          ),
          wait_completion,
          text("\\rWe hope you excel!"),
          control_switches(s(1), :OFF),
        ],
      ),
    ),

    event(
      id: 3,
      name: "PC",
      x: 11,
      y: 1,
      page_0: page(
        commands: [
          script("pbPokeCenterPC"),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Healing balls",
      x: 5,
      y: 2,
      page_0: page(
        move_speed: 4,
        walk_anime: false,
      ),
      page_1: page(
        variable: v(6),
        at_least: 1,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :left,
        ),
        walk_anime: false,
      ),
      page_2: page(
        variable: v(6),
        at_least: 2,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :right,
        ),
        walk_anime: false,
      ),
      page_3: page(
        variable: v(6),
        at_least: 3,
        graphic: graphic(
          name: "Healing balls 1",
          direction: :up,
        ),
        walk_anime: false,
      ),
      page_4: page(
        variable: v(6),
        at_least: 4,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :left,
        ),
        walk_anime: false,
      ),
      page_5: page(
        variable: v(6),
        at_least: 5,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :right,
        ),
        walk_anime: false,
      ),
      page_6: page(
        variable: v(6),
        at_least: 6,
        graphic: graphic(
          name: "Healing balls 2",
          direction: :up,
        ),
        walk_anime: false,
      ),
    ),

    event(
      id: 5,
      name: "Bill",
      x: 12,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "NPC 25",
          direction: :left,
        ),
        commands: [
          script("pbSet(2, pbGetStorageCreator)"),
          text("\\bBill: Hello! I'm \\v[2]."),
          text("\\bI invented the Pokémon Storage System."),
          script("$player.seen_storage_creator = true"),
          label("Choices"),
          text("\\bWhat do you want to know?"),
          *show_choices(
            choices: ["Wallpapers", "Cancel"],
            cancellation: 2,
            choice1: [
              *text(
                "\\bAll storage box wallpapers need to be listed in ",
                "class PokemonStorage, in def allWallpapers.",
              ),
              *text(
                "\\bThey correspond to box_0.png, box_1.png, etc. in ",
                "order without gaps. These images are in the folder ",
                "Graphics/Pictures/Storage.",
              ),
              *text(
                "\\bStorage wallpapers are split into two categories: ",
                "basic and special.All basic wallpapers are listed ",
                "before the special wallpapers.",
              ),
              *text(
                "\\bBasic wallpapers are always accessible, and ",
                "boxes use these wallpapers by default. Numbers 0 ",
                "to 15 inclusive are basic wallpapers.",
              ),
              *text(
                "\\bSpecial wallpapers start off locked and unavailable. ",
                "You can unlock them with pbUnlockWallpaper(id), ",
                "where id is the wallpaper's number.",
              ),
              jump_label("Choices"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Town Map, size(2,1)",
      x: 12,
      y: 1,
      page_0: page(
        commands: [
          *comment(
            "This event is size 2x1. It is 2 tiles wide and 1 tile tall. ",
            "An event's size can be set by adding \"size(x,y)\" in the ",
            "event's name, where x and y are numbers.",
          ),
          *comment(
            "The event's placed position determines the bottom ",
            "left tile occupied by the event in-game.",
          ),
          *comment(
            "There are a lot of reasons to change an event's size. ",
            "Here, it is covering the whole wall map with just one ",
            "event, rather than needing two events that do the ",
            "same thing.",
          ),
          script("pbShowMap"),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       384,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  385,  386,  387,  387,  387,  387,  387,
       392,  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,  394,  387,  387,  387,  387,  387,
       400,  457,  457,  457,  457,  457,  457,  475,  465,  457,  457,  457,  475,  465,  402,  387,  387,  387,  387,  387,
       457,  448,  448,  448,  457,  457,  457,  457,  457,  457,  457,  458,  448,  448,  472,  387,  387,  387,  387,  387,
       457,  448,  448,  448,  473,  465,  465,  465,  465,  465,  465,  466,  448,  448,  448,  387,  387,  387,  387,  387,
       457,  448,  448,  448,  448,  448,  485,  486,  487,  448,  448,  448,  448,  448,  448,  387,  387,  387,  387,  387,
       457,  448,  448,  448,  451,  448,  493,  494,  495,  448,  448,  448,  448,  451,  448,  387,  387,  387,  387,  387,
       457,  448,  457,  457,  458,  448,  501,  502,  503,  448,  448,  457,  457,  458,  448,  387,  387,  387,  387,  387,
       457,  448,  473,  465,  466,  448,  448,  448,  448,  448,  448,  473,  465,  466,  448,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,

         0,  662,  636,  637,    0,    0,    0,  432,  433,    0,    0,  638,  434,  435,    0,    0,    0,    0,    0,    0,
         0,  670,  644,  645,  568,  581,  582,  440,  441,  583,  568,  646,  442,  443,    0,    0,    0,    0,    0,    0,
         0,  678,  652,  653,  585,  589,  590,  601,  570,  591,  587,  654,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  593,  594,  594,  609,  594,  594,  595,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  623,  631,    0,    0,    0,    0,    0,    0,    0,  623,  631,    0,    0,    0,    0,    0,    0,    0,
       623,    0,  621,  622,    0,    0,    0,    0,    0,    0,    0,  621,  622,    0,  623,    0,    0,    0,    0,    0,
       631,    0,  629,  630,    0,    0,    0,    0,    0,    0,    0,  629,  630,    0,  631,    0,    0,    0,    0,    0,
       481,    0,    0,    0,    0,    0,  552,  553,  554,    0,    0,    0,    0,    0,  482,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  560,  561,  562,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  606,    0,    0,    0,    0,    0,  606,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  614,    0,    0,    0,    0,    0,  614,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
