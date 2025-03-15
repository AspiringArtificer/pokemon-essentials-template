# Battle Frontier (52)
#   Battle Frontier Mart (54)
map(
  tileset_id: 5,
  autoplay_bgm: true,
  bgm: audio(name: "Poke Mart", volume: 80),
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
          transfer_player(map: 52, x: 22, y: 13, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Mart",
      x: 2,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
          direction: :right,
        ),
        commands: [
          *condition(
            script: "$player.badge_count >= 8",
            then: [
              *script(
                <<~'CODE'
                pbPokemonMart([
                  :POKEBALL, :GREATBALL, :ULTRABALL,
                  :POTION, :SUPERPOTION,
                  :HYPERPOTION, :MAXPOTION,
                  :FULLRESTORE, :REVIVE,
                  :ANTIDOTE, :PARALYZEHEAL,
                  :AWAKENING, :BURNHEAL, :ICEHEAL,
                  :FULLHEAL,
                  :ESCAPEROPE,
                  :REPEL, :SUPERREPEL, :MAXREPEL
                ])
                CODE
              ),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "$player.badge_count >= 7",
            then: [
              *script(
                <<~'CODE'
                pbPokemonMart([
                  :POKEBALL, :GREATBALL, :ULTRABALL,
                  :POTION, :SUPERPOTION,
                  :HYPERPOTION, :MAXPOTION,
                  :REVIVE,
                  :ANTIDOTE, :PARALYZEHEAL,
                  :AWAKENING, :BURNHEAL, :ICEHEAL,
                  :FULLHEAL,
                  :ESCAPEROPE,
                  :REPEL, :SUPERREPEL, :MAXREPEL
                ])
                CODE
              ),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "$player.badge_count >= 5",
            then: [
              *script(
                <<~'CODE'
                pbPokemonMart([
                  :POKEBALL, :GREATBALL, :ULTRABALL,
                  :POTION, :SUPERPOTION,
                  :HYPERPOTION,
                  :REVIVE,
                  :ANTIDOTE, :PARALYZEHEAL,
                  :AWAKENING, :BURNHEAL, :ICEHEAL,
                  :FULLHEAL,
                  :ESCAPEROPE,
                  :REPEL, :SUPERREPEL, :MAXREPEL
                ])
                CODE
              ),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "$player.badge_count >= 3",
            then: [
              *script(
                <<~'CODE'
                pbPokemonMart([
                  :POKEBALL, :GREATBALL,
                  :POTION, :SUPERPOTION,
                  :HYPERPOTION,
                  :REVIVE,
                  :ANTIDOTE, :PARALYZEHEAL,
                  :AWAKENING, :BURNHEAL, :ICEHEAL,
                  :ESCAPEROPE,
                  :REPEL, :SUPERREPEL
                ])
                CODE
              ),
              exit_event_processing,
            ],
          ),
          *condition(
            script: "$player.badge_count >= 1",
            then: [
              *script(
                <<~'CODE'
                pbPokemonMart([
                  :POKEBALL, :GREATBALL,
                  :POTION, :SUPERPOTION,
                  :ANTIDOTE, :PARALYZEHEAL,
                  :AWAKENING, :BURNHEAL, :ICEHEAL,
                  :ESCAPEROPE,
                  :REPEL
                ])
                CODE
              ),
              exit_event_processing,
            ],
          ),
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL,
              :POTION
            ])
            CODE
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Questionnaire",
      x: 1,
      y: 4,
      page_0: page(
        commands: condition(
          script: "$player.mystery_gift_unlocked",
          else: [
            text("There is a questionnaire.\\nWould you like to fill it out?"),
            *show_choices(
              choices: ["Yes", "No"],
              cancellation: 2,
              choice1: [
                text("\\PN filled in the questionnaire."),
                *move_route(
                  character(2),
                  turn_down,
                ),
                script("pbExclaim(get_character(2))"),
                wait(20),
                text("\\bOh, hello!\\nYou filled in the questionnaire?"),
                text("\\bThat means you must know about the Mystery Gift."),
                *text(
                  "\\bFrom now on, you should be receiving Mystery ",
                  "Gifts!",
                ),
                script("$player.mystery_gift_unlocked = true"),
                *text(
                  "\\w[signskin]Once you save your game, you can ",
                  "access the Mystery Gift.",
                ),
              ],
            ),
          ],
        ),
      ),
    ),

    event(
      id: 4,
      name: "Deliveryman",
      x: 3,
      y: 6,
      page_0: page(
        graphic: graphic(
          direction: :right,
        ),
      ),
      page_1: page(
        switch1: s(30),
        graphic: graphic(
          name: "NPC 01",
          direction: :right,
        ),
        commands: [
          *condition(
            script: "pbNextMysteryGiftID > 0",
            then: [
              text("\\bHello. You must be \\PN."),
              text("\\bI've received a gift for you.\\nHere you go!"),
              *script(
                <<~'CODE'
                id = pbNextMysteryGiftID
                pbReceiveMysteryGift(id)
                CODE
              ),
            ],
            else: [
              text("\\bI haven't received any other gifts for you."),
            ],
          ),
          text("\\bWe look forward to your next visit."),
        ],
      ),
    ),

    event(
      id: 5,
      name: "BP shop bottom",
      x: 8,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
          direction: :left,
        ),
        commands: [
          *script(
            <<~'CODE'
            pbBattlePointShop([
              :PROTEIN, :CALCIUM, :IRON,
              :ZINC, :CARBOS, :HPUP,
              :POWERBRACER, :POWERBELT,
              :POWERLENS, :POWERBAND,
              :POWERANKLET, :POWERWEIGHT,
              :CHOICEBAND, :CHOICESPECS,
              :CHOICESCARF,
              :FOCUSBAND, :FOCUSSASH
            ])
            CODE
          ),
        ],
      ),
    ),

    event(
      id: 6,
      name: "BP shop top",
      x: 8,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "NPC 19",
          direction: :left,
        ),
        commands: [
          *script(
            <<~'CODE'
            pbBattlePointShop([
              :SCOPELENS, :WIDELENS, :ZOOMLENS,
              :WISEGLASSES, :MUSCLEBAND,
              :BINDINGBAND,
              :RAZORCLAW, :RAZORFANG,
              :AIRBALLOON, :IRONBALL, :TOXICORB,
              :FLAMEORB, :LIFEORB,
              :WHITEHERB, :POWERHERB,
              :ABSORBBULB, :CELLBATTERY,
              :REDCARD, :EJECTBUTTON, :RARECANDY
            ])
            CODE
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
       409,  385,  385,  385,  385,  385,  385,  385,  385,  385,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  393,  393,  393,  393,  393,  393,  393,  393,  393,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       425,  433,  433,  425,  443,  433,  433,  423,  425,  425,  425,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       407,  416,  416,  425,  426,  416,  416,  416,  416,  416,  440,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       425,  425,  425,  425,  426,  416,  416,  416,  425,  425,  425,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       425,  433,  433,  433,  434,  416,  416,  416,  425,  443,  433,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       425,  425,  425,  427,  416,  416,  416,  416,  425,  426,  407,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       425,  441,  433,  434,  416,  416,  416,  416,  425,  426,  416,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
       409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,

       384,    0,  388,    0,  387,  387,  387,  485,  486,  487,  386,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       392,  390,  396,  456,  395,  395,  395,  493,  494,  495,  394,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       400,  398,    0,  464,    0,    0,    0,  501,  502,  503,  402,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       488,  489,  491,  480,    0,    0,    0,  456,  488,  490,  491,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       496,  497,  499,  472,    0,    0,    0,  464,  496,  498,  499,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  488,  491,    0,    0,    0,    0,  480,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,  496,  499,    0,    0,    0,    0,  480,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       408,    0,    0,  403,  404,  405,    0,  472,    0,    0,  410,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,  411,  412,  413,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,  452,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,  460,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
