event(
  id: 13,
  name: "May initial reflection",
  x: 30,
  y: 16,
  page_0: page(
    graphic: graphic(
      name: "trainer_POKEMONTRAINER_May",
    ),
    commands: [
      text("\\rDo you want to team up with me?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *comment(
            "Makes this event follow the player. The first ",
            "parameter means \"this event\", the second is a name ",
            "that identifies this follower, and the third is the ",
            "Common Event number run when this follower is ",
            "interacted with.",
          ),
          script("Followers.add(@event_id, \"May\", 2)"),
          *comment(
            "Followers.add does not make this event disappear. It ",
            "should be hidden by using a Self Switch to make it use ",
            "a blank event page instead.",
          ),
          control_self_switch("A", :ON),
          *comment(
            "Creates a partner trainer to battle alongside the ",
            "player. The parameters are the trainer type and ",
            "name of the partner. The partner trainer is defined ",
            "in trainers.txt just like any other trainer.",
          ),
          *script(
            <<~'CODE'
            pbRegisterPartner(
              :POKEMONTRAINER_May,
              "May"
            )
            CODE
          ),
          *comment(
            "Note that the above two features are entirely ",
            "unrelated. You can have a follower which isn't also a ",
            "partner trainer (e.g. escort mission), or a partner ",
            "trainer who doesn't visibly follow you around.",
          ),
          text("\\PN teamed up with May!\\me[Item get]\\wtnp[40]"),
        ],
        choice2: [
          text("\\rOK then."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
  page_2: page(
    switch1: s(22),
    trigger: :autorun,
    commands: [
      *comment(
        "If the player blacked out while May was following ",
        "them, May should return to being this event. This ",
        "page of this event runs automatically whenever this ",
        "map is loaded, and at no other time.",
      ),
      *comment(
        "May should only reappear here if she is not currently ",
        "following the player. This first Conditional Branch ",
        "checks for that.",
      ),
      *condition(
        script: "!$game_player.has_follower?",
        then: [
          *comment(
            "Event 44 is another May event, and is the only way ",
            "to make May appear somewhere else on her own (i.e. ",
            "not being a follower).",
          ),
          *comment(
            "While event 44 is May, its Self Switch A will be ON. ",
            "Therefore, if its Self Switch A is OFF, it is not May, ",
            "and this event should be May (because she is not a ",
            "follower). This second Conditional Branch checks if ",
            "event 44's Self Switch A is off.",
          ),
          *condition(
            script: "get_event(44).isOff?(\"A\")",
            then: [
              *comment(
                "Since event 44 is not May, this event should be May. ",
                "This event's Self Switch A should be turned OFF to ",
                "make its page 1 active (which shows May).",
              ),
              control_self_switch("A", :OFF),
            ],
          ),
        ],
      ),
      script("setTempSwitchOn(\"A\")"),
    ],
  ),
)