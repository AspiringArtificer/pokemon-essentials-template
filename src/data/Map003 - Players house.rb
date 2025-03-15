# Lappet Town (2)
#   Player's house (3)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Lappet Town", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 3,
      y: 9,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 2, x: 8, y: 7, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 2,
      name: "Stairs up",
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
            move_upper_right,
            through_off,
            always_on_top_off,
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 3, x: 29, y: 2, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 3,
      name: "Stairs down",
      x: 28,
      y: 2,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *move_route(
            player,
            through_on,
            always_on_top_on,
            turn_left,
            move_left,
            through_off,
            always_on_top_off,
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 3, x: 9, y: 2, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

    event(
      id: 4,
      name: "PC",
      x: 20,
      y: 1,
      page_0: page(
        commands: [
          script("pbTrainerPC"),
        ],
      ),
    ),

    event(
      id: 6,
      name: "Trainer, Visual Editor, Terrain Tags",
      x: 29,
      y: 1,
      page_0: page(
        commands: [
          label("Start"),
          text("Choose a topic."),
          *show_choices(
            choices: ["About the trainer", "Map connections", "Terrain Tags", "Cancel"],
            cancellation: 4,
            choice1: [
              *text(
                "The $player global variable contains information ",
                "about the player, such as their trainer type, ID ",
                "number, name, party Pokémon and money.",
              ),
              text("This information is in class Player."),
              jump_label("Start"),
            ],
            choice2: [
              *text(
                "Map connections are how two maps are displayed ",
                "next to each other in the overworld, allowing you to ",
                "walk from one to the other.",
              ),
              *text(
                "The connections are defined in the PBS file ",
                "\"map_connections.txt\". There is a Debug feature that ",
                "makes connecting maps easier.",
              ),
              *text(
                "In the Debug menu, go to \"PBS File Editors...\" > ",
                "\"Edit map_connections.txt\". Instructions are available ",
                "within. You can move maps around with the mouse.",
              ),
              jump_label("Start"),
            ],
            choice3: [
              *text(
                "Every tile in a tileset has a terrain tag, which is a ",
                "number. This number is used to give certain tiles ",
                "special effects.",
              ),
              *text(
                "For example, ledge tiles have terrain tag 1, which ",
                "means the player jumps over them. Ledge tiles also ",
                "have a single passable direction (set separately).",
              ),
              *text(
                "Grass tiles (in which you can have wild encounters) ",
                "have terrain tag 2. Water tiles have terrain tag 6 or 7.",
              ),
              *text(
                "Terrain tag 0 means the tile has no special effect. ",
                "See the wiki for more information and a complete list ",
                "of all terrain tags and their effects.",
              ),
              *text(
                "You can only set terrain tags up to 7 via RPG Maker ",
                "XP's Database. Essentials has terrain tags with ",
                "higher numbers.",
              ),
              *text(
                "To fully set a tileset's terrain tags, open the Debug ",
                "menu and go to \"Other Editors...\" > \"Edit Terrain ",
                "Tags\".",
              ),
              jump_label("Start"),
            ],
          ),
        ],
      ),
    ),

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
    ),

    event(
      id: 8,
      name: "Pokédex",
      x: 5,
      y: 4,
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
      id: 9,
      name: "Mom",
      x: 7,
      y: 4,
      page_0: page(
        graphic: graphic(
          name: "NPC 28",
          direction: :left,
        ),
        commands: condition(
          self_switch: "A",
          value: :ON,
          then: [
            *text(
              "\\rRemember to read the wiki for further information.  ",
              "An Internet shortcut to the wiki can be found in the ",
              "project's main folder.",
            ),
          ],
          else: [
            *script(
              <<~'CODE'
              $player.has_pokegear = true
              $player.has_running_shoes = true
              CODE
            ),
            play_me(audio(name: "Item get")),
            text("You received a Pokégear and Running Shoes."),
            control_self_switch("A", :ON),
          ],
        ),
      ),
      page_1: page(
        switch1: s(1),
        graphic: graphic(
          name: "NPC 28",
          direction: :left,
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
            "\\rOh... Are you all right? Well, you'll have better luck ",
            "this time.",
          ),
          recover_all(0),
          *text(
            "[This message was triggered by the \"Starting Over\" ",
            "Game Switch being ON. Now turning that Game ",
            "Switch off.]",
          ),
          control_switches(s(1), :OFF),
        ],
      ),
    ),

    event(
      id: 10,
      name: "Warp tile 1",
      x: 1,
      y: 3,
      page_0: page(
        graphic: graphic(
          tile_id: 1103,
        ),
        trigger: :player_touch,
        commands: [
          text("Choose a destination."),
          *show_choices(
            choices: ["Poké Center", "Poké Mart", "Pokémon Gym", "Day Care"],
            cancellation: 0,
            choice1: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 9, x: 7, y: 8, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 25, x: 4, y: 7, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice3: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 10, x: 6, y: 14, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice4: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 27, x: 4, y: 7, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
          *show_choices(
            choices: ["Cave", "Safari Zone", "Bug Catching Contest", "Battle Frontier"],
            cancellation: 0,
            choice1: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 49, x: 12, y: 14, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 67, x: 4, y: 7, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice3: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 29, x: 1, y: 5, direction: :right, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice4: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 52, x: 18, y: 16, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
          *show_choices(
            choices: ["Cancel"],
            cancellation: 1,
          ),
        ],
      ),
    ),

    event(
      id: 11,
      name: "Warp tile 2",
      x: 2,
      y: 3,
      page_0: page(
        graphic: graphic(
          tile_id: 1103,
        ),
        trigger: :player_touch,
        commands: [
          text("Choose a destination."),
          *show_choices(
            choices: ["Game Corner", "Trainer area", "Shadow Pokémon area"],
            cancellation: 0,
            choice1: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 13, x: 9, y: 13, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 31, x: 10, y: 18, direction: :up, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice3: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 47, x: 16, y: 21, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
          *show_choices(
            choices: ["Bridges map", "Water map"],
            cancellation: 0,
            choice1: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 21, x: 16, y: 26, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 69, x: 28, y: 12, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
          *show_choices(
            choices: ["Harbor", "Cycle Road", "Cancel"],
            cancellation: 3,
            choice1: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 71, x: 8, y: 3, direction: :down, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
            choice2: [
              change_tone(red: -255, green: -255, blue: -255, frames: 6),
              wait(8),
              transfer_player(map: 46, x: 11, y: 6, direction: :left, fading: false),
              change_tone(red: 0, green: 0, blue: 0, frames: 6),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 12,
      name: "Choices NPC",
      x: 9,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 08",
          direction: :right,
        ),
        commands: [
          *comment(
            "The \"Show Choices\" event command only allows you ",
            "to input up to 4 choices. If you want more, you can ",
            "have multiple \"Show Choices\" in a row, and they will ",
            "be joined together and treated as one.",
          ),
          *comment(
            "You can have as many or as few choices in each ",
            "\"Show Choices\" event command as you want. You ",
            "don't have to have the maximum 4 choices in one ",
            "before adding another one.",
          ),
          *text(
            "\\rI will offer you more than 4 choices at once. You ",
            "can put multiple \"Show Choices\" commands in a row ",
            "to do this.",
          ),
          text("\\rPlease choose one."),
          *show_choices(
            choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4"],
            cancellation: 0,
            choice1: [
              text("Choice 1 was chosen."),
            ],
            choice2: [
              text("Choice 2 was chosen."),
            ],
            choice3: [
              text("Choice 3 was chosen."),
            ],
            choice4: [
              text("Choice 4 was chosen."),
            ],
          ),
          *show_choices(
            choices: ["Choice 5", "Choice 6"],
            cancellation: 0,
            choice1: [
              text("Choice 5 was chosen."),
            ],
            choice2: [
              text("Choice 6 was chosen."),
            ],
          ),
          *show_choices(
            choices: ["Choice 7"],
            cancellation: 5,
            choice1: [
              text("Choice 7 was chosen."),
            ],
            cancel: [
              text("The choice was cancelled."),
            ],
          ),
          comment("================================"),
          *comment(
            "Each \"Show Choices\" command has its own \"When ",
            "cancel\" property. The last one that isn't \"Disallow\" is ",
            "the one that will be used.",
            "To forbid cancelling a choice, set all of the \"Show ",
            "Choices\" commands to \"Disallow\".",
          ),
          text("\\rPlease choose one. This choice can't be cancelled."),
          *show_choices(
            choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4"],
            cancellation: 0,
            choice1: [
              text("Choice 1 was chosen."),
            ],
            choice2: [
              text("Choice 2 was chosen."),
            ],
            choice3: [
              text("Choice 3 was chosen."),
            ],
            choice4: [
              text("Choice 4 was chosen."),
            ],
          ),
          *show_choices(
            choices: ["Choice 5", "Choice 6", "Choice 7"],
            cancellation: 0,
            choice1: [
              text("Choice 5 was chosen."),
            ],
            choice2: [
              text("Choice 6 was chosen."),
            ],
            choice3: [
              text("Choice 7 was chosen."),
            ],
          ),
          comment("================================"),
          *comment(
            "This is an example of setting the \"When cancel\" ",
            "property in a \"Show Choices\" command that isn't the ",
            "last one. The \"When cancel\" properties in all later ",
            "\"Show Choices\" commands should be set to ",
            "\"Disallow\".",
          ),
          *text(
            "\\rPlease choose one. Cancelling will result in Choice ",
            "3.",
          ),
          *show_choices(
            choices: ["Choice 1", "Choice 2", "Choice 3", "Choice 4"],
            cancellation: 3,
            choice1: [
              text("Choice 1 was chosen."),
            ],
            choice2: [
              text("Choice 2 was chosen."),
            ],
            choice3: [
              text("Choice 3 was chosen."),
            ],
            choice4: [
              text("Choice 4 was chosen."),
            ],
          ),
          *show_choices(
            choices: ["Choice 5", "Choice 6", "Choice 7"],
            cancellation: 0,
            choice1: [
              text("Choice 5 was chosen."),
            ],
            choice2: [
              text("Choice 6 was chosen."),
            ],
            choice3: [
              text("Choice 7 was chosen."),
            ],
          ),
          comment("================================"),
          *comment(
            "This is an example of renaming and hiding choices.",
            "rename_choice and hide_choice apply to the next ",
            "Show Choices command in the same event page, no ",
            "matter how much later it happens.",
          ),
          *comment(
            "Renaming is useful if the name you want for a choice ",
            "is longer than RPG Maker XP allows, or if you want ",
            "that choice's name to vary, e.g. saying \"Potions: X\" ",
            "where \"X\" is how many Potions the player has.",
          ),
          *script(
            <<~'CODE'
            if rand(2) == 0
              rename_choice(1,
            _I("This choice's name is too long!")
              )
            else
              qty = $bag.quantity(:POTION)
              rename_choice(1,
                _I("Potions: {1}", qty)
              )
            end
            CODE
          ),
          *comment(
            "Hiding is useful for an NPC who unlocks choices ",
            "depending on certain conditions, e.g. the player ",
            "having particular Key Items. See the Route 8 harbor ",
            "map for an example of this.",
          ),
          *script(
            <<~'CODE'
            hide_choice(2, !$player.male?)
            hide_choice(3, !$player.female?)
            CODE
          ),
          *text(
            "\\rThis is an example of how to modify choices, using ",
            "the hide_choice and rename_choice scripts.",
          ),
          *show_choices(
            choices: ["You won't see me!", "The player is male", "The player is female", "Cancel"],
            cancellation: 4,
            choice1: [
              text("This choice was renamed by rename_choice."),
            ],
            choice2: [
              text("This choice is hidden if the player is not male."),
            ],
            choice3: [
              text("This choice is hidden if the player is not female."),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 13,
      name: "Text formatting NPC",
      x: 10,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "NPC 07",
          direction: :left,
        ),
        commands: [
          label("Start"),
          text("Choose a text option."),
          *show_choices(
            choices: ["Text colours", "Text formatting", "Insert text/in-line graphics", "Graphic and info windows"],
            cancellation: 0,
            choice1: [
              *text(
                "\\bThis is the text of a male character.",
                "\\rThis is the text of a female character.",
              ),
              *text(
                "\\pgThis text is the colour of the player's gender. ",
                "\\pogThis text is the colour of the opposite gender to ",
                "the player.",
              ),
              *text(
                "\\c[0]Default, \\c[1]blue, \\c[2]red, \\c[3]green, \\c[4]cyan, ",
                "\\c[5]magenta, \\c[6]yellow, \\c[7]grey, \\c[8]white, ",
                "\\c[9]purple, \\c[10]orange, \\c[11]dark, \\c[12]light.",
              ),
              jump_label("Start"),
            ],
            choice2: [
              *text(
                "<b>Bold text,</b> <i>italic text,</i> <u>underlined ",
                "text,</u> <s>strikethrough text,</s> <outln>outline ",
                "text,</outln> <outln2>thicker outline text.</outln2>",
              ),
              *text(
                "<fn=Power Clear Bold>Power Clear Bold text,</fn> ",
                "<fs=25>size 25 text,</fs> <fs=40>size 40 text,</fs> ",
                "<o=128>half-transparent text.</o>",
              ),
              *text(
                "This is a line\\n break. Text is \\n<r>right-aligned until ",
                "next line\\n break. Text is <ac>centred</ac> here. ",
                "Text is <ar>right-aligned</ar> here.",
              ),
              jump_label("Start"),
            ],
            choice3: [
              *text(
                "\\PN is the player's name, \\PM is the player's money, ",
                "\\v[12] is the content of Game Variable 12.",
              ),
              *text(
                "This is <icon=bagPocket3> bagPocket3 from the ",
                "folder Graphics/Icons. Icons shown this ",
                "way are not padded.",
              ),
              jump_label("Start"),
            ],
            choice4: [
              text("\\GThe money window is shown."),
              text("\\CNThe coins window is shown."),
              *text(
                "\\G\\CNThe money and coins windows are both ",
                "shown. The coins window must be shown second.",
              ),
              *text(
                "\\f[introBoy]The introBoy picture from the ",
                "Graphics/Pictures folder is shown.",
              ),
              *text(
                "\\ff[introBoy]The introBoy picture is shown again, but ",
                "cropped to the top-left 96x96 pixels of it.",
              ),
              jump_label("Start"),
            ],
          ),
          *show_choices(
            choices: ["Message box appearance", "Text speed and audio", "Audio", "Cancel"],
            cancellation: 4,
            choice1: [
              *text(
                "\\w[signskin]The windowskin has changed to ",
                "\"signskin\" here.",
              ),
              *text(
                "\\l[3]This message box has 3 lines to it rather than 2, ",
                "so more text can be shown at once. Lorem ipsum ",
                "dolor sit amet, consectetur adipisicing elit.",
              ),
              text("\\wuThis message box is at the top."),
              text("\\wmThis message box is in the middle."),
              *text(
                "\\wuThis message box is\\wm jumping around the ",
                "screen\\wd in a rather off-putting way.",
              ),
              text("\\opThis message box slides on-screen at the start."),
              text("\\clThis message box slides off-screen at the end."),
              jump_label("Start"),
            ],
            choice2: [
              text("\\ts[]This text appeared instantly!"),
              text("\\ts[5]This text is slow to appear."),
              *text(
                "Slow text speed is 4, normal speed is 2, fast speed ",
                "is 1. It takes this many 1/80ths of a second for the ",
                "next character in a message to appear.",
              ),
              jump_label("Start"),
            ],
            choice3: [
              *text(
                "\\se[Pkmn move learnt]Sound effect \"Pkmn move ",
                "learnt\" was played.",
              ),
              *text(
                "Music effect \"Item get\" will be played.",
                "\\me[Item get]",
              ),
              jump_label("Start"),
            ],
          ),
          *text(
            "A complete list of all message options is available on ",
            "the wiki.",
          ),
        ],
      ),
    ),

    event(
      id: 14,
      name: "Pokémon-checking NPC",
      x: 1,
      y: 5,
      page_0: page(
        graphic: graphic(
          name: "trainer_SCIENTIST",
          direction: :right,
        ),
        commands: [
          label("Choices"),
          text("Choose a topic."),
          *show_choices(
            choices: ["What is your first Pokémon?", "Is a Celebi in your party?", "Give a Celebi", "Cancel"],
            cancellation: 4,
            choice1: [
              *comment(
                "Get the first able Pokémon in the party, and store its ",
                "party index in Game Variable 1.",
                "Stores -1 if it can't find an able Pokémon in the party.",
                "An \"able\" Pokémon is a non-Egg, non-fainted ",
                "Pokémon.",
              ),
              script("pbFirstAblePokemon(1)"),
              *condition(
                variable: v(1),
                operation: "<",
                constant: 0,
                then: [
                  text("You don't have any able Pokémon with you."),
                ],
                else: [
                  *comment(
                    "Retrieve the Pokémon whose party index is in ",
                    "Game Variable 1.",
                    "Store that Pokémon's name in Game Variable 2.",
                  ),
                  *script(
                    <<~'CODE'
                    pkmn = pbGetPokemon(1)
                    pbSet(2, pkmn.name)
                    CODE
                  ),
                  text("\\v[2] is the first Pokémon in your party."),
                ],
              ),
              jump_label("Choices"),
            ],
            choice2: [
              comment("Counts fainted Pokémon, but not Eggs."),
              *condition(
                script: "$player.has_species?(:CELEBI)",
                then: [
                  text("You have a Celebi in your party."),
                ],
                else: [
                  text("You don't have a Celebi in your party."),
                ],
              ),
              jump_label("Choices"),
            ],
            choice3: [
              *comment(
                "Gives the player a Level 20 Celebi.",
                "If it can't be added to the party, it is stored in the PC ",
                "instead.",
                "To only let the Pokémon be added to the party, use ",
                "pbAddToParty instead.",
              ),
              *comment(
                "See the Pokémon Fan Club events for more ",
                "examples.",
              ),
              script("pbAddPokemon(:CELEBI, 20)"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 15,
      name: "Roaming Pokémon",
      x: 5,
      y: 1,
      page_0: page(
        graphic: graphic(
          tile_id: 1721,
        ),
        commands: [
          label("Start"),
          text("Choose a roaming Pokémon."),
          *show_choices(
            choices: ["Latias/Latios", "Kyogre", "Entei", "Cancel"],
            cancellation: 4,
            choice1: [
              *condition(
                switch: s(53),
                value: :ON,
                then: [
                  text("Switch 53 is on. Latias and Latios are roaming."),
                ],
                else: [
                  *text(
                    "Switch 53 is off. Latias and Latios are not roaming. ",
                    "Do you want to make Latias and Latios roam?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      control_switches(s(53), :ON),
                      text("Latias and Latios are now roaming."),
                    ],
                  ),
                ],
              ),
              jump_label("Start"),
            ],
            choice2: [
              *condition(
                switch: s(54),
                value: :ON,
                then: [
                  text("Switch 54 is on. Kyogre is roaming."),
                ],
                else: [
                  *text(
                    "Switch 54 is off. Kyogre is not roaming. Do you want ",
                    "to make Kyogre roam?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      control_switches(s(54), :ON),
                      text("Kyogre is now roaming."),
                    ],
                  ),
                ],
              ),
              jump_label("Start"),
            ],
            choice3: [
              *condition(
                switch: s(55),
                value: :ON,
                then: [
                  text("Switch 55 is on. Entei is roaming."),
                ],
                else: [
                  *text(
                    "Switch 55 is off. Entei is not roaming. Do you want to ",
                    "make Entei roam?",
                  ),
                  *show_choices(
                    choices: ["Yes", "No"],
                    cancellation: 2,
                    choice1: [
                      control_switches(s(55), :ON),
                      text("Entei is now roaming."),
                    ],
                  ),
                ],
              ),
              jump_label("Start"),
            ],
          ),
        ],
      ),
    ),

  ],
  data: table(
    x: 31,
    y: 15,
    z: 3,
    data: [
       416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  542,  542,  542,  542,  542,  542,  542,  542,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,
       424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  542,  542,  542,  542,  542,  542,  542,  542,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
       769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  542,  542,  542,  542,  542,  542,  542,  542,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,  769,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  769,  769,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760,  760,  760,  760,  769,  769,  770,  760,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760, 1177, 1177, 1177,  760,  760,  760,  760,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760, 1177, 1177, 1177,  760,  760,  760,  760,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
       769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,  542,  542,  542,  542,  542,  542,  542,  542,  769,  760,  760,  760,  760,  760,  760,  760,  760,  760,  760,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0, 1530, 1531,    0, 1712, 1491, 1492,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1504, 1505,    0,    0,    0,    0, 1457, 1457,
      1569, 1570, 1538, 1539,    0, 1720, 1499, 1500,    0,    0, 1256, 1257,    0,    0,    0,    0,    0,    0,    0,    0, 1904, 1906, 1556, 1512, 1513,    0,    0, 1262,    0, 1465, 1465,
      1577, 1578, 1546, 1547,    0, 1728,    0,    0,    0, 1287, 1264, 1265,    0,    0,    0,    0,    0,    0,    0,    0, 1936, 1938, 1564, 1520, 1521,    0,    0, 1270, 1271, 1287,    0,
         0,    0,    0, 1168, 1169, 1169, 1169, 1169, 1170, 1295, 1272, 1273,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1278, 1279, 1295,    0,
         0,    0,    0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1584, 1585, 1586, 1168, 1169, 1169, 1169, 1170,    0,    0,    0,
         0,    0,    0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1592, 1593, 1594, 1176,    0, 1728,    0, 1178,    0,    0,    0,
      1770,    0,    0, 1184, 1185, 1185, 1185, 1185, 1186,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0, 1600, 1601, 1602, 1176,    0,    0,    0, 1178,    0,    0,    0,
      1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1184, 1185, 1185, 1185, 1186,    0,    0,    0,
         0,    0, 1245, 1246, 1247,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1695,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1703,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1663,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1712,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1674, 2083, 2085, 1675,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1720,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1674, 2091, 2093, 1675,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1723,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1731,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
