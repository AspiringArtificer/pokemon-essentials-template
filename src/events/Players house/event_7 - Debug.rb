event(
  id: 7,
  name: "Debug, badges, screenshots",
  x: 30,
  y: 1,
  page_0: page(
    commands: [
      label("Start"),
      text("Choose a topic."),
      *show_choices(
        choices: ["Debug mode", "Give all badges", "Taking screenshots", "Cancel"],
        cancellation: 4,
        choice1: [
          *text(
            "Debug mode is a special way of playing the game. It ",
            "unlocks various developer features to make it easier ",
            "to access all parts of the game and test things.",
          ),
          *text(
            "Playing in Debug mode allows you to access the ",
            "Debug menu (press F9 or find it in the pause menu).",
          ),
          *text(
            "The party screen and Pokémon storage have a ",
            "similar debug menu for modifying a Pokémon's ",
            "properties, such as its level or species.",
          ),
          *text(
            "You can use field moves at any time, and hold Ctrl to ",
            "skip any battles and decide the outcome of Trainer ",
            "battles. Hold Ctrl while moving to walk over anything.",
          ),
          *text(
            "A full list of Debug mode features is available on the ",
            "wiki.",
          ),
          script("$DEBUG = true"),
          *text(
            "The $DEBUG variable was set to true. This flag is set ",
            "automatically during playtesting within RMXP. This is ",
            "what causes the game to be in Debug mode.",
          ),
          jump_label("Start"),
        ],
        choice2: [
          *script(
            <<~'CODE'
            for i in 0...16
              $player.badges[i] = true
            end
            CODE
          ),
          *text(
            "Obtained all Gym Badges for the first and second ",
            "regions.",
          ),
          *text(
            "To add a Gym Badge, use $player.badges[X]=true ",
            "where X is a number from 0 through 7. Use",
            "$player.badges[X] to see if you have a Badge.",
          ),
          *text(
            "Note that the first Gym Badge is number 0, the ",
            "second Badge is number 1, and so on.",
          ),
          *text(
            "In Debug mode, you can set which Gym Badges you ",
            "have via the Debug menu.",
          ),
          jump_label("Start"),
        ],
        choice3: [
          text("Press F8 to take a screenshot of the game."),
          *text(
            "The screenshot will be put in the same folder as the ",
            "one containing the save file.",
          ),
          jump_label("Start"),
        ],
      ),
    ],
  ),
)