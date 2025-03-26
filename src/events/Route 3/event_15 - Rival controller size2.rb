event(
  id: 15,
  name: "Rival controller size(2,1)",
  x: 22,
  y: 13,
  page_0: page(
    trigger: :player_touch,
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
        "Here, it is covering the whole path with just one ",
        "event, rather than needing two events that do the ",
        "same thing.",
      ),
      script("pbTrainerIntro(:RIVAL1)"),
      comment("Position the Rival event level with the player."),
      control_variables(v(1), character: player, property: :map_x),
      control_variables(v(2), constant: 6),
      event_location_variables(character(14), x: v(1), y: v(2), direction: :down),
      *move_route(
        character(14),
        through_on,
        move_down,
        move_down,
        move_down,
        move_down,
        move_down,
        move_down,
        through_off,
        skippable: true,
      ),
      wait_completion,
      text("\\bHi \\PN! I'm your Rival!"),
      *text(
        "\\bDo you want to name me, or leave me with my ",
        "default name as defined in trainers.txt?",
      ),
      *show_choices(
        choices: ["Rename", "Cancel"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            name = pbEnterNPCName(
              _I("Rival's name?"),
              1, Settings::MAX_PLAYER_NAME_SIZE,
              "Blue",
              "trainer_RIVAL1"
            )
            pbSet(12, name)
            CODE
          ),
          text("\\bSo my name is \\v[12], huh? Okay then."),
        ],
        choice2: [
          script("pbSet(12, nil)"),
        ],
      ),
      text("\\bLet's get down to the battle!"),
      *condition(
        variable: v(7),
        operation: "==",
        constant: 1,
        then: [
          comment("Player chose Bulbasaur, rival has Charmander."),
          *condition(
            script: "TrainerBattle.start(:RIVAL1, \"Blue\", 1)",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
        ],
        else: condition(
          variable: v(7),
          operation: "==",
          constant: 2,
          then: [
            comment("Player chose Charmander, rival has Squirtle."),
            *condition(
              script: "TrainerBattle.start(:RIVAL1, \"Blue\", 2)",
              then: [
                control_self_switch("A", :ON),
              ],
            ),
          ],
          else: [
            comment("Player chose Squirtle, rival has Bulbasaur."),
            *condition(
              script: "TrainerBattle.start(:RIVAL1, \"Blue\", 0)",
              then: [
                control_self_switch("A", :ON),
              ],
            ),
          ],
        ),
      ),
      *condition(
        self_switch: "A",
        value: :ON,
        then: [
          text("\\bI'm going to leave now. Smell you later!"),
          comment("Move the Rival event off-screen."),
          *move_route(
            character(14),
            through_on,
            move_up,
            move_up,
            move_up,
            move_up,
            move_up,
            move_up,
            through_off,
          ),
          wait_completion,
          comment("Clear the rival's event."),
          script("pbSetSelfSwitch(14, \"A\", true)"),
          comment("Disable this event."),
          control_self_switch("A", :ON),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
)