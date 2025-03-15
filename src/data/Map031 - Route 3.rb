# Route 3 (31)
map(
  autoplay_bgm: true,
  bgm: audio(name: "Route 3", volume: 80),
  events: [

    event(
      id: 1,
      name: "CutTree",
      x: 17,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "Object tree 1",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbCut",
            then: [
              script("pbSmashThisEvent"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 2,
      name: "HeadbuttTree",
      x: 22,
      y: 20,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 3,
      name: "HeadbuttTree",
      x: 22,
      y: 21,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Trainer(2)",
      x: 5,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "trainer_YOUNGSTER",
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:YOUNGSTER)"),
          script("pbNoticePlayer(get_self)"),
          text("\\bHi! I like shorts! They're comfy and easy to wear!"),
          *condition(
            script: "TrainerBattle.start(:YOUNGSTER, \"Ben\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_YOUNGSTER",
        ),
        commands: [
          text("\\bYou can't get a trainer event simpler than me!"),
        ],
      ),
    ),

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
    ),

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
    ),

    event(
      id: 7,
      name: "Trainer(1)",
      x: 10,
      y: 13,
      page_0: page(
        graphic: graphic(
          name: "trainer_BEAUTY",
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:BEAUTY)"),
          script("pbNoticePlayer(get_self)"),
          text("\\rI've brought my own special backdrop!"),
          *script(
            <<~'CODE'
            setBattleRule(
              "backdrop", "champion1"
            )
            CODE
          ),
          *condition(
            script: "TrainerBattle.start(:BEAUTY, \"Bridget\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_BEAUTY",
        ),
        commands: [
          *text(
            "\\rIf exactly 2 trainers notice you at the same time, ",
            "they become a double battle.",
          ),
          *text(
            "\\rHere, though, 3 trainers noticed you at once, so I ",
            "battled you by myself. Then the 2 remaining trainers ",
            "noticing you at the same time became a double battle.",
          ),
          *text(
            "\\rI battled you first because my event's ID number (7) ",
            "comes before the Hiker's and Fisherman's event ID ",
            "numbers (8 and 9).",
          ),
        ],
      ),
    ),

    event(
      id: 8,
      name: "Trainer(1)",
      x: 9,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "trainer_HIKER",
          direction: :right,
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:HIKER)"),
          script("pbNoticePlayer(get_self)"),
          text("\\bThis battle will go without a hitch!"),
          *condition(
            script: "TrainerBattle.start(:HIKER, \"Ford\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_HIKER",
          direction: :right,
        ),
        commands: [
          text("\\bHow did you manage to face all three of us?"),
        ],
      ),
    ),

    event(
      id: 9,
      name: "Trainer(1)",
      x: 11,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "trainer_FISHERMAN",
          direction: :left,
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:FISHERMAN)"),
          script("pbNoticePlayer(get_self)"),
          text("\\bI'll get my tackle out for you!"),
          *condition(
            script: "TrainerBattle.start(:FISHERMAN, \"Andrew\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_FISHERMAN",
          direction: :left,
        ),
        commands: [
          *text(
            "\\bI don't understand why my Magikarp couldn't beat ",
            "you.",
          ),
        ],
      ),
    ),

    event(
      id: 10,
      name: "Trainer(2)",
      x: 13,
      y: 17,
      page_0: page(
        graphic: graphic(
          name: "trainer_LASS",
          direction: :up,
        ),
        trigger: :event_touch,
        commands: [
          script("pbTrainerIntro(:LASS)"),
          script("pbNoticePlayer(get_self)"),
          text("\\rGet ready for a double battle!"),
          script("setBattleRule(\"double\")"),
          *condition(
            script: "TrainerBattle.start(:LASS, \"Crissy\")",
            then: [
              control_self_switch("A", :ON),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_LASS",
          direction: :up,
        ),
        commands: [
          *text(
            "\\rMake sure all double battle opponents have at least ",
            "2 Pokémon!",
          ),
        ],
      ),
    ),

    event(
      id: 11,
      name: "Double trainer F",
      x: 14,
      y: 13,
      page_0: page(
        graphic: graphic(
          name: "trainer_COOLTRAINER_F",
        ),
        commands: [
          *condition(
            script: "!pbCanDoubleBattle?",
            then: [
              *text(
                "\\rYou'll need at least two Pokémon or a partner if you ",
                "want to battle us.",
              ),
              exit_event_processing,
            ],
          ),
          script("pbTrainerIntro(:COOLCOUPLE)"),
          text("\\rAh, looks like a challenging trainer. Ready, Bob?"),
          script("setBattleRule(\"double\")"),
          *condition(
            script: "TrainerBattle.start(:COOLCOUPLE, \"Alice & Bob\")",
            then: [
              control_self_switch("A", :ON),
              comment("Set the partner event's Self Switch \"A\" on."),
              script("pbSetSelfSwitch(12, \"A\", true)"),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_COOLTRAINER_F",
        ),
        commands: [
          *text(
            "\\rOur events weren't created by comments, ",
            "because we need to check how many Pokémon you ",
            "had.",
          ),
        ],
      ),
    ),

    event(
      id: 12,
      name: "Double trainer M",
      x: 15,
      y: 13,
      page_0: page(
        graphic: graphic(
          name: "trainer_COOLTRAINER_M",
        ),
        commands: [
          *condition(
            script: "!pbCanDoubleBattle?",
            then: [
              *text(
                "\\bYou'll need at least two Pokémon or a partner if you ",
                "want to battle us.",
              ),
              exit_event_processing,
            ],
          ),
          script("pbTrainerIntro(:COOLCOUPLE)"),
          text("\\bAh, looks like a challenging trainer. Ready, Alice?"),
          script("setBattleRule(\"double\")"),
          *condition(
            script: "TrainerBattle.start(:COOLCOUPLE, \"Alice & Bob\")",
            then: [
              control_self_switch("A", :ON),
              comment("Set the partner event's Self Switch \"A\" on."),
              script("pbSetSelfSwitch(11, \"A\", true)"),
            ],
          ),
          script("pbTrainerEnd"),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_COOLTRAINER_M",
        ),
        commands: [
          *text(
            "\\bOur events weren't created by comments, ",
            "because we need to check how many Pokémon you ",
            "had.",
          ),
        ],
      ),
    ),

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
    ),

    event(
      id: 14,
      name: "Rival",
      x: 18,
      y: 2,
      page_0: page(
        graphic: graphic(
          name: "trainer_RIVAL1",
        ),
        commands: [
          *comment(
            "This event should be somewhere where the player ",
            "can't possibly see it.",
            "It is moved from here to where it is needed when its ",
            "appearance is triggered.",
          ),
          *comment(
            "Note that this event does nothing except look like an ",
            "NPC (the Rival). The actual battle and movements ",
            "are done by the controlling event at the entrance of ",
            "this short path.",
          ),
        ],
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

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
    ),

    event(
      id: 16,
      name: "Remove follower size(1,4)",
      x: 1,
      y: 17,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *comment(
            "This event removes a follower (May) and moves it to ",
            "a particular position. It only triggers if the player has ",
            "moved left onto this event, and only if they have a ",
            "follower. Note that this event is 4 tiles tall, covering ",
            "the whole path.",
          ),
          *comment(
            "These trigger requirements let us know exactly where ",
            "the follower will be in relation to the player, which is ",
            "information we can use below to ensure the correct ",
            "move route is given to the follower to make it end up ",
            "in the correct position.",
          ),
          *condition(
            script: "$game_player.has_follower?",
            then: condition(
              character: player,
              facing: :left,
              then: [
                comment("Turn the player towards the follower while it talks."),
                *move_route(
                  player,
                  turn_right,
                ),
                *comment(
                  "Make the follower show an exclamation bubble. The ",
                  "script here means that the next Show Animation ",
                  "command will play over the follower instead of ",
                  "whatever target it says it applies to.",
                ),
                script("follower_animation"),
                show_animation(this, anim(3)),
                wait(10),
                text("\\rI'll wait here, then."),
                *comment(
                  "This line of code means that the next Set Move Route ",
                  "command will apply to the follower, rather than to the ",
                  "event/player it says it applies to. Only one Set Move ",
                  "Route command is reassigned by the use of this ",
                  "code.",
                ),
                script("follower_move_route"),
                *comment(
                  "Give the follower a different move route depending ",
                  "on where the player currently is, to ensure it ends up ",
                  "at the correct position. Note that Through is set ON ",
                  "because the follower will be moved into the tile ",
                  "occupied by the event it will be replaced with.",
                ),
                control_variables(v(1), character: player, property: :map_y),
                *condition(
                  variable: v(1),
                  operation: "==",
                  constant: 14,
                  then: [
                    *move_route(
                      this,
                      through_on,
                      move_down,
                      move_right,
                      turn_down,
                      through_off,
                      skippable: true,
                    ),
                  ],
                ),
                *condition(
                  variable: v(1),
                  operation: "==",
                  constant: 15,
                  then: [
                    *move_route(
                      this,
                      through_on,
                      move_right,
                      turn_down,
                      through_off,
                      skippable: true,
                    ),
                  ],
                ),
                *condition(
                  variable: v(1),
                  operation: "==",
                  constant: 16,
                  then: [
                    *move_route(
                      this,
                      through_on,
                      move_up,
                      move_right,
                      turn_down,
                      through_off,
                      skippable: true,
                    ),
                  ],
                ),
                *condition(
                  variable: v(1),
                  operation: "==",
                  constant: 17,
                  then: [
                    *move_route(
                      this,
                      through_on,
                      move_up,
                      move_up,
                      move_right,
                      turn_down,
                      through_off,
                      skippable: true,
                    ),
                  ],
                ),
                comment("Wait for the follower to finish moving."),
                wait_completion,
                *comment(
                  "Once the follower has finished moving, remove it as a ",
                  "follower. At the same time, turn event 44's Self ",
                  "Switch A on, which depicts May.",
                ),
                script("Followers.remove(\"May\")"),
                script("pbSetSelfSwitch(44, \"A\", true)"),
                comment("Deregister the trainer."),
                script("pbDeregisterPartner"),
              ],
            ),
          ),
        ],
      ),
    ),

    event(
      id: 17,
      name: "Cave entrance",
      x: 55,
      y: 8,
      page_0: page(
        graphic: graphic(
          pattern: 3,
        ),
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: 255, green: 255, blue: 255, gray: 255, frames: 6),
          wait(8),
          script("pbCaveEntrance"),
          transfer_player(map: 34, x: 23, y: 17, direction: :up, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
      page_1: page(
        switch1: s(22),
        graphic: graphic(
          pattern: 3,
        ),
        trigger: :autorun,
        commands: [
          *condition(
            script: "get_self.onEvent?",
            then: [
              script("Followers.hide_followers"),
              *move_route(
                player,
                route_play_se(audio(name: "Door exit", volume: 80)),
                move_down,
                skippable: true,
              ),
              wait_completion,
              script("Followers.put_followers_on_player"),
            ],
          ),
          script("setTempSwitchOn(\"A\")"),
        ],
      ),
    ),

    event(
      id: 18,
      name: "HeadbuttTree",
      x: 48,
      y: 6,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 19,
      name: "HeadbuttTree",
      x: 48,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 20,
      name: "HeadbuttTree",
      x: 48,
      y: 8,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 21,
      name: "HeadbuttTree",
      x: 48,
      y: 9,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 22,
      name: "SmashRock",
      x: 51,
      y: 7,
      page_0: page(
        graphic: graphic(
          name: "Object rock",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbRockSmash",
            then: [
              script("pbSmashThisEvent"),
              script("pbRockSmashRandomEncounter"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 23,
      name: "SmashRock",
      x: 51,
      y: 8,
      page_0: page(
        graphic: graphic(
          name: "Object rock",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbRockSmash",
            then: [
              script("pbSmashThisEvent"),
              script("pbRockSmashRandomEncounter"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 24,
      name: "CutTree",
      x: 44,
      y: 14,
      page_0: page(
        graphic: graphic(
          name: "Object tree 1",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbCut",
            then: [
              script("pbSmashThisEvent"),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 25,
      name: "HeadbuttTree",
      x: 48,
      y: 61,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 26,
      name: "HeadbuttTree",
      x: 49,
      y: 61,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

    event(
      id: 27,
      name: "HeadbuttTree",
      x: 50,
      y: 61,
      page_0: page(
        graphic: graphic(
          name: "Object tree 2",
        ),
        commands: [
          script("pbHeadbutt"),
        ],
      ),
    ),

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
    ),

    event(
      id: 29,
      name: "CutTree",
      x: 51,
      y: 31,
      page_0: page(
        graphic: graphic(
          name: "Object tree 1",
        ),
        commands: [
          *move_route(
            this,
            turn_down,
          ),
          *condition(
            script: "pbCut",
            then: [
              script("pbSmashThisEvent"),
            ],
          ),
        ],
      ),
    ),

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
    ),

  ],
  data: table(
    x: 70,
    y: 69,
    z: 3,
    data: [
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385, 1177, 1179, 1177, 1177, 1179, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1192, 1188, 1188, 1188,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385, 1177, 1187, 1193, 1177, 1179, 1177, 1177, 1177, 1177, 1177, 1192, 1188, 1188, 1188, 1188, 1189, 1192, 1188, 1193,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385, 1177, 1177, 1179, 1177, 1179, 1177, 1177, 1177, 1177, 1177, 1181, 1177, 1177, 1177, 1177, 1177, 1181, 1177, 1187,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385, 1177, 1177, 1179, 1177, 1187, 1193, 1177, 1177, 1177, 1192, 1189, 1192, 1188, 1188, 1188, 1188, 1189, 1177, 1177,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385,  385, 1193, 1179, 1177, 1177, 1187, 1188, 1188, 1188, 1189, 1177, 1181, 1177, 1177, 1177, 1177, 1177, 1177, 1177,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  818,  819,  802,  801,  800,  803,  818,  819,  818,  819,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  818,  819,  810,  811,  385, 1179, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1177, 1181, 1192,  385,  385,  385,  385,  385,  385,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  415,  415,  810,  809,  808,  811, 1088, 1089, 1089, 1089, 1089, 1090,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385,  415,  818,  819,  385, 1179, 1177, 1177, 1177, 1192, 1188, 1188, 1188, 1188, 1189,  385,  810,  811,  810,  811,  810,  811,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  415,  415,  802,  801,  800,  803, 1096, 1097, 1097, 1097, 1097, 1098,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385,  386,  385,  388,  385, 1187, 1188, 1188, 1188, 1189, 1192,  385,  385,  385,  385,  385,  802,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  415,  415,  810,  809,  808,  811, 1096, 1097, 1097, 1097, 1097, 1106, 1089, 1090,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385,  388,  389,  386,  385,  385,  385,  385,  385,  385,  385,  385,  810,  811,  810,  811,  810,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385,  415,  802,  801,  800,  803, 1096, 1097, 1097, 1097, 1097, 1097, 1097, 1098,  818,  819,  818,  819,  818,  819,  818,  819,  818,  819,  818,  819,  385,  385,  386,  387,  385,  388,  389,  386,  389,  385,  386,  282,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  389,  386,  810,  809,  808,  811, 1233, 1234, 1092, 1097, 1097, 1097, 1097, 1098,  385,  388,  386,  387,  385,  386,  286,  385,  286,  389,  385,  387,  385,  388,  387,  385,  389,  386,  385,  387,  388,  389,  385,  284,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  803,  818,  819,  818,  819,  818,  819,  818,  819,  818,  819,  818,  819,  802,  801,  800,  801,  800,  803,  385,  388,  802,  801,  800,  801,  800,  803, 1096, 1097, 1097, 1097, 1097, 1098,  386,  425,  426,  426,  426,  426,  426,  426,  426,  426,  426,  427,  388,  386,  385,  386,  388,  385,  388,  385,  387,  386,  286,  385,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  811,  385,  286,  387,  385,  386,  389,  386,  286,  388,  385,  415,  415,  810,  809,  808,  809,  808,  811,  387,  385,  810,  809,  808,  809,  808,  811, 1233, 1233, 1233, 1233, 1233, 1233,  385,  441,  442,  442,  442,  442,  442,  442,  442,  442,  442,  443,  385,  387,  388,  387,  385,  387,  386,  387,  385,  388,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       818,  819,  818,  819,  286,  389,  386,  386,  388,  385,  388,  387,  385,  389,  386,  385,  818,  819,  818,  819,  818,  819,  386,  387,  818,  819,  802,  801,  800,  801,  800,  803,  286,  385,  387,  386,  385,  389,  385,  387,  386,  385,  386,  388,  385,  387,  386,  385,  389,  385,  386,  385,  388,  385,  388,  385,  387,  386,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       385,  386,  387,  385,  386,  385,  388,  385,  387,  386,  385,  387,  386,  387,  385,  388,  386,  385,  387,  386,  385,  388,  385,  388,  286,  385,  810,  809,  808,  809,  808,  811,  385,  386,  388,  385,  388,  385,  386,  286,  810,  811,  810,  811,  385,  810,  811,  810,  811,  810,  811,  810,  811,  390,  390,  386,  388,  385,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  539,  385,  386,  286,  818,  819,  818,  819,  818,  819,  388,  537,  539,  389,  386,  388,  387,  385,  802,  801,  800,  803,  389,  818,  819,  802,  801,  800,  801,  800,  803,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  542,  547,  389,  388,  385,  387,  386,  385,  386,  388,  387,  385,  545,  547,  385,  810,  811,  810,  811,  810,  809,  808,  811,  385,  387,  415,  810,  809,  808,  809,  808,  811,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       385,  386,  387,  385,  387,  388,  386,  389,  385,  388,  385,  387,  386,  385,  386,  388,  386,  385,  387,  385,  386,  545,  547,  385,  386,  389,  385,  388,  387,  385,  389,  385,  386,  545,  547,  386,  802,  801,  800,  801,  800,  801,  800,  803,  388,  386,  385,  818,  819,  818,  819,  818,  819,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       810,  811,  810,  811,  386,  389,  385,  388,  386,  387,  386,  385,  387,  388,  386,  385,  388,  386,  810,  811,  388,  545,  556,  538,  538,  538,  538,  538,  538,  538,  538,  538,  538,  558,  547,  387,  810,  809,  808,  809,  808,  809,  808,  811,  385,  387,  389,  390,  390,  390,  390,  390,  390,  390,  390,  390,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  803,  387,  385,  387,  386,  385,  389,  385,  388,  386,  387,  385,  389,  386,  385,  802,  803,  385,  553,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  555,  385,  802,  801,  800,  801,  800,  801,  800,  803,  537,  539,  385,  390,  390,  390,  390,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  811,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  810,  811,  810,  811,  810,  811,  385,  386,  389,  385,  387,  386,  385,  388,  385,  388,  387,  385,  389,  386,  810,  809,  808,  809,  808,  809,  808,  811,  545,  547,  386,  385,  390,  390,  810,  811,  810,  811,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  803,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  818,  819,  802,  801,  800,  803,  388,  385,  388,  386,  389,  286,  389,  385,  387,  386,  385,  386,  388,  385,  802,  801,  800,  801,  800,  801,  800,  803,  545,  547,  388,  387,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  811,  810,  811,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  810,  809,  808,  811,  386,  389,  386,  385,  386,  385,  388,  387,  386,  385,  810,  811,  810,  811,  810,  809,  808,  809,  808,  809,  808,  811,  545,  547,  385,  386,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  803,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  818,  819,  818,  819,  388,  390,  390,  385,  386,  387,  385,  387,  388,  387,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  286,  385,  802,  801,  800,  803,  818,  819,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  811,  810,  811,  810,  811,  390,  390,  390,  390,  390,  390,  390,  390,  390,  385,  388,  387,  390,  390,  390,  390,  385,  386,  389,  389,  385,  387,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  387,  389,  810,  809,  808,  811,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  390,  390,  390,  390,  390,  390,  390,  386,  390,  390,  390,  390,  390,  390,  390,  390,  385,  388,  386,  389,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  386,  282,  802,  803,  818,  819,  390,  390,  390,  390,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  810,  811,  810,  811,  390,  390,  390,  387,  386,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  385,  284,  810,  811,  415,  390,  390,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  390,  389,  385,  387,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  803,  818,  819,  818,  819,  545,  547,  388,  386,  802,  803,  415,  387,  390,  390,  390,  390,  390,  390,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  811,  810,  809,  808,  809,  808,  809,  808,  811,  390,  390,  390,  385,  545,  547,  385,  286,  810,  811,  415,  415,  388,  387,  390,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  390,  386,  545,  547,  387,  388,  818,  819,  810,  811,  386,  388,  387,  385,  387,  390,  390,  386,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  390,  390,  386,  385,  545,  547,  386,  385,  389,  386,  818,  819,  388,  385,  386,  389,  388,  385,  388,  386,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  387,  389,  545,  547,  385,  387,  387,  385,  386,  388,  385,  389,  387,  385,  386,  390,  390,  390,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  390,  390,  388,  386,  545,  547,  388,  810,  811,  810,  811,  385,  386,  385,  388,  389,  390,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  385,  388,  545,  547,  385,  802,  801,  800,  803,  810,  811,  390,  390,  810,  811,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  390,  390,  386,  385,  545,  547,  389,  810,  809,  808,  809,  816,  819,  390,  390,  802,  803,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  390,  388,  545,  547,  386,  818,  819,  818,  819,  387,  386,  385,  389,  810,  811,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  810,  811,  390,  390,  545,  547,  385,  286,  810,  811,  390,  390,  390,  388,  415,  802,  803,  810,  811,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  390,  545,  547,  388,  385,  802,  803,  390,  390,  390,  810,  811,  810,  811,  818,  819,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  390,  390,  545,  547,  389,  387,  810,  811,  390,  390,  390,  802,  803,  818,  819,  385,  387,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  390,  385,  545,  547,  385,  386,  818,  819,  390,  390,  390,  810,  811,  415,  415,  389,  386,  385,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  386,  388,  545,  547,  388,  810,  809,  808,  811,  390,  390,  818,  819,  385,  386,  388,  385,  387,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385,  286,  545,  547,  385,  818,  817,  816,  819,  387,  386,  385,  390,  390,  390,  390,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  286,  386,  545,  547,  810,  809,  808,  811,  390,  385,  388,  390,  390,  390,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  387,  385,  545,  547,  802,  801,  800,  803,  390,  390,  389,  390,  390,  390,  390,  390,  390,  415,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  385,  386,  545,  547,  810,  809,  808,  811,  810,  811,  810,  811,  390,  390,  390,  389,  415,  415,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  388,  387,  545,  547,  818,  819,  802,  801,  800,  801,  800,  803,  810,  811,  385,  386,  387,  415,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  286,  385,  545,  547,  390,  390,  810,  809,  808,  809,  808,  809,  800,  803,  387,  388,  385,  386,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  386,  389,  545,  547,  390,  390,  818,  819,  802,  801,  800,  801,  808,  811,  385,  537,  539,  385,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  286,  385,  545,  547,  390,  390,  390,  390,  810,  809,  808,  809,  816,  819,  386,  545,  547,  389,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385,  386,  545,  547,  385,  390,  390,  390,  818,  819,  818,  819,  386,  385,  388,  545,  547,  388,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  387,  388,  545,  547,  389,  388,  385,  389,  283,  285,  385,  537,  538,  538,  538,  558,  547,  387,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  818,  819,  818,  819,  802,  803,  818,  819,  818,  819,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  386,  385,  545,  547,  385,  386,  387,  286,  385,  386,  388,  545,  540,  554,  554,  554,  555,  386,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  275,  273,  262,  276,  810,  811,  274,  260,  260,  276,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  537,  538,  558,  556,  538,  538,  538,  538,  538,  538,  538,  558,  547,  388,  386,  385,  388,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  272,  385,  256,  264,  818,  819,  258,  268,  248,  264,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  540,  554,  554,  554,  554,  554,  554,  554,  554,  554,  554,  555,  389,  385,  387,  390,  390,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  257,  260,  241,  242,  260,  260,  266,  385,  258,  278,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  386,  385,  388,  387,  385,  386,  389,  385,  387,  388,  385,  386,  390,  390,  390,  390,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  256,  244,  268,  268,  252,  268,  270,  273,  267,  385,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  389,  810,  811,  810,  811,  385,  388,  386,  390,  390,  390,  390,  390,  390,  810,  811,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  256,  264,  810,  811,  272,  385,  810,  811,  257,  276,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  385,  802,  801,  800,  803,  390,  390,  390,  390,  390,  390,  390,  390,  390,  802,  801,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  256,  264,  802,  803,  257,  276,  802,  803,  256,  264,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  388,  810,  809,  808,  811,  810,  811,  810,  811,  390,  390,  390,  390,  390,  810,  809,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  280,  265,  810,  811,  256,  264,  810,  811,  258,  278,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  386,  802,  801,  800,  801,  800,  801,  800,  803,  390,  390,  390,  390,  390,  818,  817,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  385,  272,  802,  803,  280,  278,  802,  803,  272,  385,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  385,  810,  809,  808,  809,  808,  809,  808,  811,  390,  390,  390, 1088, 1089, 1089, 1090,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  274,  266,  810,  811,  810,  811,  810,  811,  257,  276,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  387,  818,  819,  818,  819,  818,  819,  802,  803,  390,  390,  390, 1096, 1097, 1097, 1098,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  803,  280,  278,  802,  801,  800,  801,  800,  803,  280,  278,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  547,  385,  389,  386,  385,  385,  385,  385,  810,  811,  390,  390,  390, 1096, 1097, 1097, 1098,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  811,  810,  811,  810,  809,  808,  809,  808,  811,  810,  811,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  545,  547,  386,  388,  385,  388,  387,  385,  386,  818,  819,  385,  389,  386, 1096, 1097, 1097, 1098,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  545,  556,  538,  538,  538,  538,  538,  538,  538,  538,  539,  386,  385,  388, 1096, 1097, 1097, 1098,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  553,  554,  554,  554,  554,  554,  554,  554,  554,  542,  547,  385,  387,  415, 1096, 1097, 1097, 1098,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  385,  389,  386,  385,  387,  388,  386,  283,  285,  545,  547,  386,  415,  415, 1096, 1097, 1097, 1098,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  810,  811,  810,  811,  810,  811,  810,  811,  385,  553,  555,  385,  810,  811, 1233, 1233, 1233, 1233,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,
       800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  803,  388,  387,  385,  389,  802,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,  800,  801,
       808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  811,  386,  385,  388,  386,  810,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,  808,  809,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0,    0,    0, 1223,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0, 1215,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1184, 1185,    0,    0,    0, 1207,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1185, 1185, 1185, 1185, 1185, 1185,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1128, 1129, 1129, 1129, 1129, 1130,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1178,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1176,    0,    0,    0,    0,    0,    0, 1185, 1185, 1185, 1185, 1186,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0,    0,    0, 1146, 1129, 1130,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1184, 1185, 1185, 1182, 1185, 1185, 1186,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0,    0,    0,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1132,    0,    0,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1206,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1205,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1205,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1205,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0, 1194, 1212, 1212, 1198,    0,    0, 1194, 1212, 1212, 1212, 1212, 1212, 1212, 1213,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1212, 1198,    0,    0, 1194, 1212, 1212, 1212, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1212, 1212, 1212, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1212, 1212, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1212, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1194, 1212, 1198,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1128, 1129, 1129, 1130,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 1136,    0,    0, 1138,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,  804,  805,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  812,  813,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  812,  813, 1115, 1115, 1115, 1115,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,  804,  805,  804,  805,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
       804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,  804,  805,  804,  805,  804,  805,  804,  805,  804,  805,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  804,  805,  804,  805,  804,  805,  804,  805,    0,    0,    0,    0,  804,  805,  804,  805,  804,  805,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  812,  813,  812,  813,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
