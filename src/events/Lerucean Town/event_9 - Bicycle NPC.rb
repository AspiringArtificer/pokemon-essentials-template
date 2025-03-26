event(
  id: 9,
  name: "Bicycle NPC",
  x: 13,
  y: 27,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      *comment(
        "This NPC swaps a Lemonade for a Bicycle (because ",
        "Essentials doesn't come with a Bike Voucher item).",
      ),
      *text(
        "\\bHi! I'm super thirsty. Do you have a Lemonade? I'll ",
        "trade you a Bicycle for one. I have too many ",
        "Bicycles.",
      ),
      *condition(
        script: "$bag.has?(:LEMONADE)",
        then: [
          *text(
            "\\bOh, you have a Lemonade? Would you consider ",
            "exchanging it for a Bicycle?",
          ),
          *show_choices(
            choices: ["Yes", "No"],
            cancellation: 2,
            choice1: [
              text("\\bExcellent! Here you go."),
              *condition(
                script: "pbReceiveItem(:BICYCLE)",
                then: [
                  *comment(
                    "There is no need to check whether it's possible to ",
                    "delete a Lemonade from the player's Bag, because ",
                    "the check above made sure there is at least one of ",
                    "them in the Bag, so it can definitely be deleted.",
                  ),
                  script("$bag.remove(:LEMONADE)"),
                  text("\\bThank you! I really needed this."),
                  control_self_switch("A", :ON),
                ],
                else: [
                  *text(
                    "\\bYou have no space in your Bag. I don't want to just ",
                    "take your Lemonade, so come back when I can give ",
                    "you a Bicycle in return.",
                  ),
                ],
              ),
            ],
            choice2: [
              text("\\bThat's too bad. I really am thirsty."),
            ],
          ),
        ],
      ),
    ],
  ),
  page_1: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      *text(
        "\\bAre you enjoying your Bicycle? The Lemonade you ",
        "gave me was just what I needed.",
      ),
    ],
  ),
)