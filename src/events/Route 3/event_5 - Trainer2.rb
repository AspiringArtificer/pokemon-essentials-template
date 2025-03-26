event(
  id: 5,
  name: "Trainer(2)",
  x: 7,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_CAMPER",
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:CAMPER)"),
      script("pbNoticePlayer(get_self)"),
      text("\\bDid I notice you, or did you notice me?"),
      script("pbTrainerCheck(:CAMPER,\"Jeff\", 2)"),
      *condition(
        script: "TrainerBattle.start(:CAMPER, \"Jeff\")",
        then: [
          *condition(
            script: "Phone.can_add?(:CAMPER, \"Jeff\")",
            then: [
              *text(
                "\\bShall we exchange numbers, so we can have a ",
                "rematch?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  *script(
                    <<~'CODE'
                    Phone.add(get_self,
                      :CAMPER, "Jeff", 2
                    )
                    CODE
                  ),
                ],
              ),
            ],
          ),
          control_self_switch("A", :ON),
          control_self_switch("B", :ON),
        ],
      ),
      script("pbTrainerEnd"),
    ],
  ),
  page_1: page(
    self_switch: "B",
    graphic: graphic(
      name: "trainer_CAMPER",
    ),
    commands: [
      script("pbTrainerIntro(:CAMPER)"),
      text("\\bLet's have a rematch!"),
      *condition(
        script: "Phone.battle(:CAMPER, \"Jeff\")",
        then: [
          *script(
            <<~'CODE'
            Phone.reset_after_win(
              :CAMPER, "Jeff"
            )
            CODE
          ),
          control_self_switch("A", :ON),
          script("pbTrainerEnd"),
        ],
      ),
    ],
  ),
  page_2: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_CAMPER",
    ),
    commands: [
      *condition(
        script: "Phone.variant(:CAMPER, \"Jeff\") == 0",
        then: [
          text("\\bI'll get even stronger, and beat you next time!"),
        ],
      ),
      *condition(
        script: "Phone.variant(:CAMPER, \"Jeff\") >= 1",
        then: [
          text("\\bI don't think I'll ever be able to beat you."),
        ],
      ),
      *condition(
        script: "Phone.can_add?(:CAMPER, \"Jeff\")",
        then: [
          *text(
            "\\bShall we exchange numbers, so we can have a ",
            "rematch?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *script(
                <<~'CODE'
                Phone.add(get_self,
                  :CAMPER, "Jeff", 2
                )
                CODE
              ),
            ],
          ),
        ],
      ),
    ],
  ),
)