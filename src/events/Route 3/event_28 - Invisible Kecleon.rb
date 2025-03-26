event(
  id: 28,
  name: "Invisible Kecleon",
  x: 45,
  y: 44,
  page_0: page(
    commands: [
      *condition(
        script: "$bag.has?(:SILPHSCOPE)",
        then: [
          *text(
            "Something unseeable is in the way. Want to use the ",
            "Silph Scope?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              jump_label("Battle"),
            ],
          ),
        ],
        else: condition(
          script: "$bag.has?(:DEVONSCOPE)",
          then: [
            *text(
              "Something unseeable is in the way. Want to use the ",
              "Devon Scope?",
            ),
            *show_choices(
              choices: ["Yes", "No"],
              cancellation: 2,
              choice1: [
                jump_label("Battle"),
              ],
            ),
          ],
          else: [
            text("Something unseeable is in the way."),
          ],
        ),
      ),
      exit_event_processing,
      label("Battle"),
      text("The invisible Pokémon became completely visible!"),
      text("The startled Pokémon attacked!"),
      script("WildBattle.start(:KECLEON, 30)"),
      comment("If won"),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 1,
        then: [
          script("pbFadeOutIn(99999){}"),
          control_self_switch("A", :ON),
        ],
      ),
      comment("If escaped"),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 3,
        then: [
          script("pbFadeOutIn(99999){}"),
          control_self_switch("A", :ON),
        ],
      ),
      comment("If caught"),
      *condition(
        variable: v(1),
        operation: "==",
        constant: 4,
        then: [
          control_self_switch("A", :ON),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    through: true,
  ),
)