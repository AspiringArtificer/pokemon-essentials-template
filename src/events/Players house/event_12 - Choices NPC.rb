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
)