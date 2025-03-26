event(
  id: 44,
  name: "May west reflection",
  x: 3,
  y: 15,
  page_0: page,
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_POKEMONTRAINER_May",
    ),
    commands: [
      *comment(
        "Normally, once you have escorted an NPC trainer to ",
        "the end of a dungeon, they will just remain there ",
        "and cannot be made to follow the player again. ",
        "However, for the sake of example, this page does let ",
        "May follow the player again.",
      ),
      text("\\rDo you want to team up with me again?"),
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
          control_self_switch("A", :OFF),
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
          *comment(
            "This Set Move Route command is to ensure that May ",
            "faces down once she stops following the player. ",
            "Without this, she will be facing in whichever direction ",
            "she was facing when the player talked to this event ",
            "to add May as a follower.",
          ),
          *move_route(
            this,
            turn_down,
          ),
        ],
        choice2: [
          text("\\rOK then."),
        ],
      ),
    ],
  ),
)