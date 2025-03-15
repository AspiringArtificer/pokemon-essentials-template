# Intro (1)
map(
  tileset_id: 4,
  events: [

    event(
      id: 1,
      name: "Intro",
      x: 0,
      y: 0,
      page_0: page(
        trigger: :autorun,
        commands: [
          change_text_options(1, 1),
          *text(
            "<ac>\\c[8]\\l[3](Please refer to the\\nPokémon ",
            "Essentials Wiki\\nfor documentation.)",
          ),
          change_text_options(2, 0),
          prepare_transition,
          show_picture(
            number: 1,
            graphic: "introbg",
            origin: :upper_left,
            blending: :normal,
          ),
          execute_transition(""),
          wait(18),
          show_picture(
            number: 2,
            graphic: "introbase",
            origin: :center,
            x: 256,
            y: 256,
            opacity: 0,
            blending: :normal,
          ),
          show_picture(
            number: 3,
            graphic: "introOak",
            origin: :center,
            x: 256,
            y: 172,
            opacity: 0,
            blending: :normal,
          ),
          move_picture(
            number: 2,
            frames: 15,
            origin: :center,
            x: 256,
            y: 256,
            blending: :normal,
          ),
          move_picture(
            number: 3,
            frames: 15,
            origin: :center,
            x: 256,
            y: 172,
            blending: :normal,
          ),
          wait(18),
          play_bgm(audio(name: "New Start")),
          text("\\bHello! Sorry to keep you waiting!"),
          text("\\bWelcome to the world of Pokémon."),
          text("\\bMy name is Oak."),
          text("\\bPeople call me the Pokémon Professor."),
          label("Help Choices"),
          text("\\bIf you need help, I am certainly capable of giving it."),
          *show_choices(
            choices: ["Controls", "Adventure", "No info needed"],
            cancellation: 3,
            choice1: [
              script("pbEventScreen(ButtonEventScene)"),
              jump_label("Help Choices"),
            ],
            choice2: [
              text("\\bWell then, without further ado..."),
              *script(
                <<~'CODE'
                pbToneChangeAll(
                  Tone.new(-255, -255, -255, 0),
                  10)
                CODE
              ),
              wait(10),
              show_picture(
                number: 4,
                graphic: "helpadventurebg",
                origin: :upper_left,
                opacity: 0,
                blending: :normal,
              ),
              move_picture(
                number: 4,
                frames: 10,
                origin: :upper_left,
                blending: :normal,
              ),
              wait(10),
              change_text_options(1, 1),
              *text(
                "<ac>\\c[0]\\l[3]You are about to enter a world\\nwhere ",
                "you will embark on a grand\\nadventure of your very ",
                "own.",
              ),
              *text(
                "<ac>\\c[0]\\l[5]Speak to people and check things\\n",
                "wherever you go, be it in towns,\\nroads or caves.\\n",
                "Gather information and hints from\\n",
                "every possible source.",
              ),
              *text(
                "<ac>\\c[0]\\l[3]New paths will open to you when\\n",
                "you help people in need, overcome\\n",
                "challenges, and solve mysteries.",
              ),
              *text(
                "<ac>\\c[0]\\l[7]At times, you will be challenged\\n",
                "by others to a battle.\\n",
                "At other times, wild creatures\\nmay stand in your way.\\n\\n",
                "By overcoming such hurdles,\\nyou will gain great power.",
              ),
              *text(
                "<ac>\\c[0]\\l[2]However, your adventure is not\\n",
                "solely about becoming powerful.",
              ),
              *text(
                "<ac>\\c[0]\\l[7]On your travels, we hope that\\n",
                "you will meet countless people\\n",
                "and, through them, achieve\\npersonal growth.\\n\\n",
                "This is the most important\\nobjective of this adventure.",
              ),
              move_picture(
                number: 4,
                frames: 10,
                origin: :upper_left,
                opacity: 0,
                blending: :normal,
              ),
              wait(10),
              erase_picture(number: 4),
              *script(
                <<~'CODE'
                pbToneChangeAll(
                  Tone.new(0, 0, 0, 0),
                  10)
                CODE
              ),
              wait(10),
              change_text_options(2, 0),
              jump_label("Help Choices"),
            ],
          ),
          wait(5),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 172,
            opacity: 0,
            blending: :normal,
          ),
          wait(10),
          erase_picture(number: 3),
          show_picture(
            number: 3,
            graphic: "introMarill",
            origin: :center,
            x: 256,
            y: 220,
            opacity: 0,
            blending: :normal,
          ),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 220,
            blending: :normal,
          ),
          wait(10),
          *text(
            "\\bThis world is inhabited by creatures we call ",
            "Pokémon.",
          ),
          *text(
            "\\bPeople and Pokémon live together by supporting ",
            "each other.",
          ),
          *text(
            "\\bSome people play with Pokémon, some battle with ",
            "them.",
          ),
          wait(5),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 220,
            opacity: 0,
            blending: :normal,
          ),
          wait(10),
          erase_picture(number: 3),
          show_picture(
            number: 3,
            graphic: "introOak",
            origin: :center,
            x: 256,
            y: 172,
            opacity: 0,
            blending: :normal,
          ),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 172,
            blending: :normal,
          ),
          wait(10),
          text("\\bBut we don't know everything about Pokémon yet."),
          text("\\bThere are still many mysteries to solve."),
          text("\\bThat's why I study Pokémon every day."),
          wait(5),
          move_picture(
            number: 2,
            frames: 10,
            origin: :center,
            x: 256,
            y: 256,
            opacity: 0,
            blending: :normal,
          ),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 172,
            opacity: 0,
            blending: :normal,
          ),
          wait(10),
          erase_picture(number: 3),
          wait(15),
          text("\\bAre you a boy or a girl?"),
          *show_choices(
            choices: ["Boy", "Girl"],
            cancellation: 0,
            choice1: [
              *comment(
                "Initializes player character 1.",
                "[\"pbChangePlayer\" takes a value from 1 upwards. To ",
                "edit information about a player character, go to the ",
                "Debug menu and choose \"PBS file editors...\" > \"Edit ",
                "metadata.txt\".]",
              ),
              script("pbChangePlayer(1)"),
              show_picture(
                number: 3,
                graphic: "introBoy",
                origin: :center,
                x: 256,
                y: 178,
                opacity: 0,
                blending: :normal,
              ),
            ],
            choice2: [
              comment("Initializes player character 2."),
              script("pbChangePlayer(2)"),
              show_picture(
                number: 3,
                graphic: "introGirl",
                origin: :center,
                x: 256,
                y: 178,
                opacity: 0,
                blending: :normal,
              ),
            ],
          ),
          move_picture(
            number: 2,
            frames: 10,
            origin: :center,
            x: 256,
            y: 256,
            blending: :normal,
          ),
          move_picture(
            number: 3,
            frames: 10,
            origin: :center,
            x: 256,
            y: 178,
            blending: :normal,
          ),
          wait(10),
          text("\\bNow what did you say your name was?"),
          label("Enter Name"),
          *comment(
            "Opens the name entry screen and initializes the ",
            "trainer object",
          ),
          script("pbTrainerName"),
          wait(5),
          text("\\bSo you're \\PN?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice2: [
              text("\\bWhat is your name?"),
              jump_label("Enter Name"),
            ],
          ),
          text("\\b\\PN, are you ready?"),
          text("\\bYour very own Pokémon story is about to unfold."),
          text("\\bYou'll face fun times and tough challenges."),
          *text(
            "\\bA world of dreams and adventures with Pokémon ",
            "awaits! Let's go!",
          ),
          *text(
            "\\bEnjoy the Starter Kit. You should give credit when ",
            "using it.",
          ),
          fade_out_bgm(seconds: 4),
          control_self_switch("A", :ON),
          *script(
            <<~'CODE'
            pbToneChangeAll(
              Tone.new(-255, -255, -255, 0),
              10)
            CODE
          ),
          wait(10),
          erase_picture(number: 1),
          erase_picture(number: 2),
          erase_picture(number: 3),
          transfer_player(map: 3, x: 25, y: 6, direction: :down, fading: true),
          *script(
            <<~'CODE'
            pbToneChangeAll(
              Tone.new(0, 0, 0, 0),
              10)
            CODE
          ),
          wait(10),
        ],
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

    event(
      id: 2,
      name: "Quick start intro",
      x: 0,
      y: 14,
      page_0: page(
        commands: [
          *comment(
            "This is the Debug intro, used to quickly start a game. ",
            "The player's name and trainer type are chosen ",
            "automatically.",
          ),
          script("pbChangePlayer(1)"),
          script("pbTrainerName(\"Red\")"),
          control_self_switch("A", :ON),
          *script(
            <<~'CODE'
            pbToneChangeAll(
              Tone.new(-255, -255, -255, 0),
              0
            )
            CODE
          ),
          transfer_player(map: 3, x: 25, y: 6, direction: :down, fading: false),
          *script(
            <<~'CODE'
            pbToneChangeAll(
              Tone.new(0, 0, 0, 0),
              10
            )
            CODE
          ),
          wait(10),
        ],
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
       387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,

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
