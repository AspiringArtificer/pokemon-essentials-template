event(
  id: 6,
  name: "Trainer(2)",
  x: 7,
  y: 17,
  page_0: page(
    graphic: graphic(
      name: "trainer_PICNICKER",
      direction: :up,
    ),
    trigger: :event_touch,
    commands: [
      script("pbTrainerIntro(:PICNICKER)"),
      script("pbNoticePlayer(get_self)"),
      text("\\rBattle me now!"),
      *script(
        <<~'CODE'
        pbTrainerCheck(
          :PICNICKER, "Susie", 2
        )
        CODE
      ),
      *condition(
        script: "TrainerBattle.start(:PICNICKER, \"Susie\")",
        then: [
          *condition(
            script: "Phone.can_add?(:PICNICKER, \"Susie\")",
            then: [
              text("\\rCan I add you to my contacts list?"),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  *script(
                    <<~'CODE'
                    Phone.add(get_self,
                      :PICNICKER, "Susie", 2
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
      name: "trainer_PICNICKER",
      direction: :up,
    ),
    commands: [
      script("pbTrainerIntro(:PICNICKER)"),
      text("\\rBattle me now!"),
      *condition(
        script: "Phone.battle(:PICNICKER, \"Susie\")",
        then: [
          *script(
            <<~'CODE'
            Phone.reset_after_win(
              :PICNICKER, "Susie"
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
      name: "trainer_PICNICKER",
      direction: :up,
    ),
    commands: [
      *condition(
        script: "Phone.variant(:PICNICKER, \"Susie\") == 0",
        then: [
          *text(
            "\\rI say the same thing after every battle. Why? Just ",
            "because.",
          ),
        ],
      ),
      *condition(
        script: "Phone.variant(:PICNICKER, \"Susie\") >= 1",
        then: [
          *text(
            "\\rI say the same thing after every battle. Why? Just ",
            "because.",
          ),
        ],
      ),
      *condition(
        script: "Phone.can_add?(:PICNICKER, \"Susie\")",
        then: [
          text("\\rCan I add you to my contacts list?"),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              *script(
                <<~'CODE'
                Phone.add(get_self,
                  :PICNICKER, "Susie", 2
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