event(
  id: 1,
  name: "Professor",
  x: 6,
  y: 3,
  page_0: page(
    graphic: graphic(
      name: "phone001",
    ),
    commands: [
      *text(
        "\\bOak: You should battle with your Pokémon to make ",
        "it strong.",
      ),
      *condition(
        script: "$player.has_pokegear",
        then: [
          *text(
            "\\bOak: If you register me in your Pokégear, you can ",
            "call me any time to rate your Pokédex completion.",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              script("Phone.add(4, \"Professor Oak\", 1)"),
              text("\\bOak: Please let me know how you get on!"),
            ],
            choice2: [
              *text(
                "\\bOak: Oh, okay. Let me know if you change your ",
                "mind.",
              ),
            ],
          ),
        ],
      ),
    ],
  ),
  page_1: page(
    switch1: s(3),
    graphic: graphic(
      name: "phone001",
    ),
    commands: [
      text("\\bOak: Well, which one do you want?"),
    ],
  ),
)