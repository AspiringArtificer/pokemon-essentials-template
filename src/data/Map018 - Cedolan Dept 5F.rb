# Cedolan City (7)
#   Cedolan Dept. 1F (14)
#     Cedolan Dept. 5F (18)
map(
  tileset_id: 10,
  autoplay_bgm: true,
  bgm: audio(name: "Poke Mart", volume: 80),
  events: [

    event(
      id: 1,
      name: "Elevator door",
      x: 6,
      y: 1,
      page_0: page(
        graphic: graphic(
          name: "doors9",
        ),
        trigger: :player_touch,
        commands: [
          *comment(
            "This sets the player's current floor, so that the ",
            "elevator knows how many floors to go up/down (this ",
            "affects the wall animation).",
          ),
          control_variables(v(10), constant: 5),
          *move_route(
            this,
            route_play_se(audio(name: "Door slide")),
            route_wait(2),
            turn_left,
            route_wait(2),
            turn_right,
            route_wait(2),
            turn_up,
            route_wait(2),
            skippable: true,
          ),
          wait_completion,
          *move_route(
            player,
            through_on,
            move_up,
            through_off,
            skippable: true,
          ),
          wait_completion,
          change_transparent_flag(:transparent),
          script("Followers.follow_into_door"),
          wait_completion,
          *move_route(
            this,
            route_wait(2),
            turn_right,
            route_wait(2),
            turn_left,
            route_wait(2),
            turn_down,
            route_wait(2),
            skippable: true,
          ),
          wait_completion,
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          change_transparent_flag(:normal),
          transfer_player(map: 20, x: 2, y: 5, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
      page_1: page(
        switch1: s(22),
        graphic: graphic(
          name: "doors9",
        ),
        trigger: :autorun,
        commands: [
          *condition(
            script: "get_self.onEvent?",
            then: [
              change_transparent_flag(:transparent),
              script("Followers.hide_followers"),
              *move_route(
                this,
                route_play_se(audio(name: "Door slide")),
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_right,
                route_wait(2),
                turn_up,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
              change_transparent_flag(:normal),
              *move_route(
                player,
                move_down,
                skippable: true,
              ),
              wait_completion,
              script("Followers.put_followers_on_player"),
              *move_route(
                this,
                turn_right,
                route_wait(2),
                turn_left,
                route_wait(2),
                turn_down,
                route_wait(2),
                skippable: true,
              ),
              wait_completion,
            ],
          ),
          script("setTempSwitchOn(\"A\")"),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Stairs down",
      x: 10,
      y: 2,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *move_route(
            player,
            through_on,
            always_on_top_on,
            turn_right,
            move_right,
            through_off,
            always_on_top_off,
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 17, x: 9, y: 2, direction: :left, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Stairs up",
      x: 2,
      y: 2,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *move_route(
            player,
            through_on,
            always_on_top_on,
            turn_left,
            move_upper_left,
            through_off,
            always_on_top_off,
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 19, x: 22, y: 10, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Floor sign",
      x: 8,
      y: 1,
      page_0: page(
        commands: [
          text("\\sign[signskin]5F: Drugstore"),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Cashier top",
      x: 1,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
          direction: :right,
        ),
        commands: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :HPUP,
              :PROTEIN,
              :IRON,
              :CALCIUM,
              :ZINC,
              :CARBOS
            ])
            CODE
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Cashier bottom",
      x: 1,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
        ),
        commands: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :XATTACK,
              :XDEFENSE,
              :XSPEED,
              :XSPATK,
              :XSPDEF,
              :XACCURACY,
              :GUARDSPEC,
              :DIREHIT
            ])
            CODE
          ),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 17,
    z: 3,
    data: [
       385,  386,  386,  386,  386,  387,  388,  389,  386,  386,  386,  386,  390,  384,  384,  384,  384,  384,  384,  384,
       393,  475,  476,  394,  394,  395,  396,  397,  394,  394,  394,  394,  398,  384,  384,  384,  384,  384,  384,  384,
       393,  483,  484,  402,  402,  403,  415,  405,  402,  402,  497,  498,  398,  384,  384,  384,  384,  384,  384,  384,
       401,  491,  492,  410,  410,  410,  410,  410,  410,  410,  505,  506,  406,  384,  384,  384,  384,  384,  384,  384,
         0,    0,    0,  411,  411,  411,  411,  411,  411,  411,    0,    0,    0,  384,  384,  384,  384,  384,  384,  384,
       429,  429,  459,  430,  420,  420,  420,  420,  420,  420,  429,  429,  429,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  420,  430,  420,  420,  420,  420,  420,  420,  437,  437,  437,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  420,  430,  420,  420,  420,  420,  420,  420,  420,  420,  420,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  420,  430,  420,  420,  420,  420,  420,  422,  420,  420,  422,  384,  384,  384,  384,  384,  384,  384,
       429,  437,  437,  438,  420,  420,  420,  429,  429,  430,  429,  429,  430,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  420,  420,  420,  420,  420,  437,  437,  438,  437,  437,  438,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  420,  422,  420,  420,  422,  420,  420,  420,  420,  420,  420,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  429,  430,  420,  429,  430,  420,  420,  422,  420,  420,  422,  384,  384,  384,  384,  384,  384,  384,
       429,  420,  429,  430,  420,  429,  430,  429,  429,  430,  429,  429,  430,  384,  384,  384,  384,  384,  384,  384,
       429,  437,  437,  438,  437,  437,  438,  437,  437,  438,  437,  437,  438,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,

         0,    0,    0,    0,    0,    0,    0,    0,  534,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  542,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  442,  443,  493,    0,    0,    0,    0,    0,  504,  441,  442,    0,    0,    0,    0,    0,    0,    0,    0,
       450,  450,  451,    0,    0,    0,    0,    0,    0,    0,  449,  450,  450,    0,    0,    0,    0,    0,    0,    0,
       458,  458,  528,    0,    0,    0,    0,    0,    0,    0,  457,  458,  458,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  528,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       513,  532,  531,    0,    0,    0,    0,  603,  603,    0,  603,  603,    0,    0,    0,    0,    0,    0,    0,    0,
       537,  540,  539,    0,    0,    0,    0,  611,  611,    0,  611,  611,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,  619,  619,    0,  619,  619,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  574,  575,    0,  574,  575,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  582,  583,    0,  582,  583,    0,  603,  603,    0,  603,  603,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  590,  591,    0,  590,  591,    0,  611,  611,    0,  611,  611,    0,    0,    0,    0,    0,    0,    0,    0,
       556,  598,  599,    0,  598,  599,    0,  619,  619,    0,  619,  619,  556,    0,    0,    0,    0,    0,    0,    0,
       564,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  564,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  520,    0,    0,    0,    0,    0,    0,    0,  587,  588,  589,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  516,    0,    0,    0,    0,    0,    0,    0,  595,  596,  597,    0,    0,    0,    0,    0,    0,    0,
         0,    0,  524,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
