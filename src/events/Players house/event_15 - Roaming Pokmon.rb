event(
  id: 15,
  name: "Roaming Pokémon",
  x: 5,
  y: 1,
  page_0: page(
    graphic: graphic(
      tile_id: 1721,
    ),
    commands: [
      label("Start"),
      text("Choose a roaming Pokémon."),
      *show_choices(
        choices: ["Latias/Latios", "Kyogre", "Entei", "Cancel"],
        cancellation: 4,
        choice1: [
          *condition(
            switch: s(53),
            value: :ON,
            then: [
              text("Switch 53 is on. Latias and Latios are roaming."),
            ],
            else: [
              *text(
                "Switch 53 is off. Latias and Latios are not roaming. ",
                "Do you want to make Latias and Latios roam?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  control_switches(s(53), :ON),
                  text("Latias and Latios are now roaming."),
                ],
              ),
            ],
          ),
          jump_label("Start"),
        ],
        choice2: [
          *condition(
            switch: s(54),
            value: :ON,
            then: [
              text("Switch 54 is on. Kyogre is roaming."),
            ],
            else: [
              *text(
                "Switch 54 is off. Kyogre is not roaming. Do you want ",
                "to make Kyogre roam?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  control_switches(s(54), :ON),
                  text("Kyogre is now roaming."),
                ],
              ),
            ],
          ),
          jump_label("Start"),
        ],
        choice3: [
          *condition(
            switch: s(55),
            value: :ON,
            then: [
              text("Switch 55 is on. Entei is roaming."),
            ],
            else: [
              *text(
                "Switch 55 is off. Entei is not roaming. Do you want to ",
                "make Entei roam?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  control_switches(s(55), :ON),
                  text("Entei is now roaming."),
                ],
              ),
            ],
          ),
          jump_label("Start"),
        ],
      ),
    ],
  ),
)