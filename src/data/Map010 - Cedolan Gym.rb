# Cedolan City (7)
#   Cedolan Gym (10)
map(
  tileset_id: 14,
  autoplay_bgm: true,
  bgm: audio(name: "Gym"),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 6,
      y: 15,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 11, y: 29, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Gym Guy",
      x: 7,
      y: 12,
      page_0: page(
        graphic: graphic(
          name: "NPC 15",
        ),
        commands: [
          text("\\bThis is an example of a Pokémon Gym."),
          *text(
            "\\bThe only differences are that the trainers become ",
            "inactive when the Leader is defeated, and the ",
            "Leader gives you a Gym Badge and TM as a reward.",
          ),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Brock",
      x: 6,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_LEADER_Brock",
        ),
        commands: [
          script("$stats.gym_leader_attempts[0] += 1"),
          script("pbTrainerIntro(:LEADER_Brock)"),
          text("\\bYou've made it this far, but can you beat me?"),
          *condition(
            script: "TrainerBattle.start(:LEADER_Brock, \"Brock\")",
            then: [
              *text(
                "\\me[Badge get]\\bYou've earned the Boulder Badge.",
                "\\wtnp[110]",
              ),
              *script(
                <<~'CODE'
                $stats.set_time_to_badge(0)
                $player.badges[0] = true
                CODE
              ),
              text("\\bHere, have this TM too."),
              script("pbReceiveItem(:TM80)"),
              *text(
                "\\bYou may find the Pokémon on Route 1 are a little ",
                "tougher now.",
              ),
              script("$PokemonGlobal.encounter_version = 1"),
              control_switches(s(4), :ON),
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_LEADER_Brock",
        ),
        commands: [
          *text(
            "\\bI often work in the caves on Route 7, digging up ",
            "fossils.",
          ),
          *text(
            "\\bThere's a man in the Pokémon Institute who can ",
            "revive fossils into living Pokémon.",
          ),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Trainer(3)",
      x: 3,
      y: 8,
      page_0: page(
        graphic: graphic(
          name: "trainer_CAMPER",
          direction: :right,
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:CAMPER)"),
          script("pbNoticePlayer(get_self)"),
          text("\\bBattle me now!"),
          *condition(
            script: "TrainerBattle.start(:CAMPER, \"Liam\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_CAMPER",
          direction: :right,
        ),
        commands: [
          *text(
            "\\bYou're pretty hot. But not as hot as",
            "Brock!",
          ),
        ],
      ),
      page_2: page(
        switch1: s(4),
        graphic: graphic(
          name: "trainer_CAMPER",
          direction: :right,
        ),
        commands: [
          *text(
            "\\bYou're pretty hot. But not as hot as",
            "Brock!",
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
       400,  401,  402,  402,  402,  402,  403,  402,  402,  402,  402,  405,  406,  384,  384,  384,  384,  384,  384,  384,
       408,  409,  410,  410,  412,  412,  411,  412,  412,  410,  410,  413,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  417,  418,  418,  418,  418,  418,  418,  418,  418,  418,  421,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  425,  426,  427,  427,  435,  427,  435,  427,  427,  428,  429,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  433,  434,  442,  442,  442,  459,  442,  442,  442,  434,  437,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  441,  442,  442,  450,  466,  467,  468,  450,  442,  442,  434,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  449,  442,  442,  466,  467,  467,  467,  468,  442,  442,  442,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  449,  442,  450,  434,  436,  459,  436,  434,  450,  442,  442,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  457,  442,  451,  452,  452,  452,  452,  452,  453,  442,  450,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  449,  442,  434,  436,  434,  444,  434,  436,  434,  442,  442,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  457,  442,  442,  451,  452,  452,  452,  453,  442,  442,  450,  414,  384,  384,  384,  384,  384,  384,  384,
       408,  449,  442,  442,  434,  434,  444,  434,  434,  442,  442,  442,  414,  384,  384,  384,  384,  384,  384,  384,
       416,  447,  452,  452,  446,  447,  452,  452,  446,  447,  452,  452,  422,  384,  384,  384,  384,  384,  384,  384,
       424,  447,  452,  452,  454,  455,  452,  452,  454,  455,  452,  452,  430,  384,  384,  384,  384,  384,  384,  384,
       432,  447,  452,  452,  452,  452,  452,  452,  452,  452,  452,  452,  438,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  461,  462,  463,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  469,  470,  471,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  385,    0,    0,    0,  385,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  393,    0,    0,    0,  393,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  386,  387,  388,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,  394,  395,  396,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
