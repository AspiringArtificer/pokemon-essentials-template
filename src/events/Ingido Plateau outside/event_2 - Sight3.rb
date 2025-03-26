event(
  id: 2,
  name: "Sight(3)",
  x: 15,
  y: 22,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
      direction: :right,
    ),
    trigger: :event_touch,
    commands: condition(
      character: this,
      facing: :right,
      then: [
        script("pbNoticePlayer(get_self)"),
        text("\\bI stopped you as you walked past."),
        *text(
          "\\bHaving \"Sight(3)\" as my event's name, and the ",
          "\"Event Touch\" trigger, tells me to activate whenever ",
          "you enter any of the three tiles in front of me.",
        ),
        *text(
          "\\bpbExclaim makes me exclaim. pbNoticePlayer does ",
          "the same thing, as well as make me approach you.",
        ),
        *text(
          "\\bTrainers use these features by default, but other ",
          "NPCs like me can use them too. Roadblock events in ",
          "particular love to use them.",
        ),
        *text(
          "\\bShall I turn you back like a real roadblock, or should ",
          "I deactivate myself?",
        ),
        *show_choices(
          choices: ["Roadblock", "Deactivate"],
          cancellation: 0,
          choice1: [
            text("\\bCome back when Game Switch 5 is ON."),
            *move_route(
              player,
              turn_down,
              move_forward,
            ),
            wait_completion,
          ],
          choice2: [
            *text(
              "\\bOkay. I'll fulfil my roadblock condition myself, by ",
              "turning the Game Switch I depend on (5) to ON.",
            ),
            control_switches(s(5), :ON),
            *comment(
              "When a \"Control Switches\" event command is used, ",
              "all events on the map refresh themselves in case ",
              "they should now use a different page. However, this ",
              "also erases their forced move routes.",
            ),
            *comment(
              "The refresh waits until the next frame to happen, but ",
              "without the wait, the \"Set Move Route\" command ",
              "below will have also run before then, and its move ",
              "route would be erased. This is why we wait briefly ",
              "now, to allow the refresh to happen before setting ",
              "this event's move route.",
            ),
            wait(1),
          ],
        ),
        *move_route(
          this,
          turn_left,
          move_left,
          move_left,
          move_left,
          turn_right,
          skippable: true,
        ),
        wait_completion,
        *text(
          "\\bBecause I was moved by pbNoticePlayer and then ",
          "moved again by a Move Route, I need to update my ",
          "current location in memory.",
        ),
        *text(
          "\\bThis matters if you save and reload the game on ",
          "this map after I've moved. See my event for the ",
          "command you need to use.",
        ),
        *comment(
          "The memorised location of an event is only changed ",
          "when pbNoticePlayer is used for it. The purpose of ",
          "this memorisation is solely to ensure that the event ",
          "stays in the same place when saving and reloading on ",
          "the same map.",
        ),
        *comment(
          "To update the memorised location of an event which ",
          "was moved by pbNoticePlayer and then moved by ",
          "other means, use the below line of code.",
        ),
        script("$PokemonMap.addMovedEvent(get_self)"),
      ],
      else: [
        *text(
          "\\bI'm keeping guard here as a trusted roadblock ",
          "event.",
        ),
        *move_route(
          this,
          turn_right,
        ),
        wait_completion,
      ],
    ),
  ),
  page_1: page(
    switch1: s(5),
    graphic: graphic(
      name: "NPC 01",
      direction: :right,
    ),
    commands: [
      *text(
        "\\bRoadblock events don't normally set the conditions ",
        "they wait for (Game Switch 5 in my case), but I did.",
      ),
    ],
  ),
)