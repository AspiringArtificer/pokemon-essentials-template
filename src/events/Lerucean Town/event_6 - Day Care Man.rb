event(
  id: 6,
  name: "Day Care Man",
  x: 26,
  y: 11,
  page_0: page(
    graphic: graphic(
      name: "NPC 18",
    ),
    commands: condition(
      script: "DayCare.egg_generated?",
      then: [
        text("\\bAh, it's you!"),
        *text(
          "\\bWe were raising your Pokémon, and my goodness, ",
          "were we surprised!",
        ),
        text("\\bYour Pokémon was holding an Egg!"),
        *text(
          "\\bWe don't know how it got there, but your Pokémon ",
          "had it.",
        ),
        text("\\bYou do want it, don't you?"),
        *show_choices(
          choices: ["Yes", "No"],
          cancellation: 2,
          choice1: [
            label("ReceiveEgg"),
            *condition(
              script: "$player.party_full?",
              then: [
                *text(
                  "\\bYou have no room for it right now... Come back ",
                  "when you've made room.",
                ),
                exit_event_processing,
              ],
            ),
            *text(
              "\\me[Egg get]\\PN received the Egg from the Day-Care ",
              "Man.",
            ),
            text("\\bYou take good care of it."),
            script("DayCare.collect_egg"),
          ],
          choice2: [
            text("\\bI really will keep it. You do want this Egg, yes?"),
            *show_choices(
              choices: ["Yes", "No"],
              cancellation: 2,
              choice1: [
                jump_label("ReceiveEgg"),
              ],
              choice2: [
                text("\\bWell all right then, I'll take it. Thank you."),
                text("\\bThat is, I don't think we'll ever find another..."),
                *text(
                  "\\bNo, no, I'm sure we'll find another one. I'm definitely ",
                  "sure of it!",
                ),
                script("DayCare.reset_egg_counters"),
                exit_event_processing,
              ],
            ),
          ],
        ),
      ],
      else: [
        *condition(
          script: "DayCare.count == 0",
          then: [
            text("\\bI'm the Day-Care Man."),
            *text(
              "\\bI help take care of the precious Pokémon of ",
              "trainers.",
            ),
            *text(
              "\\bAny Pokémon you'd like to have raised you can ",
              "leave in my wife's care.",
            ),
          ],
        ),
        *condition(
          script: "DayCare.count == 1",
          then: [
            script("DayCare.get_details(-1, 3, -1)"),
            text("\\bAh, it's you!\\nGood to see you!"),
            text("\\bYour \\v[3] is doing just fine."),
          ],
        ),
        *condition(
          script: "DayCare.count == 2",
          then: [
            *script(
              <<~'CODE'
              DayCare.get_details(0, 3, -1)
              DayCare.get_details(1, 4, -1)
              DayCare.get_compatibility(5)
              CODE
            ),
            text("\\bAh, it's you!\\nGood to see you!"),
            text("\\bYour \\v[3] and \\v[4] are doing just fine."),
            *condition(
              variable: v(5),
              operation: "==",
              constant: 0,
              then: [
                *text(
                  "\\bThe two play with other Pokémon rather than with ",
                  "each other...",
                ),
              ],
            ),
            *condition(
              variable: v(5),
              operation: "==",
              constant: 1,
              then: [
                text("\\bThe two don't seem to like each other much."),
              ],
            ),
            *condition(
              variable: v(5),
              operation: "==",
              constant: 2,
              then: [
                text("\\bThe two seem to get along."),
              ],
            ),
            *condition(
              variable: v(5),
              operation: "==",
              constant: 3,
              then: [
                text("\\bThe two seem to get along very well."),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
)