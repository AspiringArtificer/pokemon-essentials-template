event(
  id: 7,
  name: "Battle recorder",
  x: 13,
  y: 8,
  page_0: page(
    commands: [
      *condition(
        character: player,
        facing: :up,
        else: [
          exit_event_processing,
        ],
      ),
      *show_choices(
        choices: ["Stadium Cup rules", "Play recorded battle", "Cancel"],
        cancellation: 3,
        choice1: [
          label("Top"),
          text("Which heading would you like to read?"),
          *show_choices(
            choices: ["Stadium Cups", "Pika Cup", "Fancy Cup", "Poké Cup"],
            cancellation: 0,
            choice1: [
              *text(
                "This facility lets you conduct battles similar to Stadium ",
                "championships.",
              ),
              *text(
                "This facility holds battles for Pika Cup, Fancy Cup,",
                "Poké Cup, and Little Cup. Each cup has its own rules ",
                "and restrictions.",
              ),
              jump_label("Top"),
            ],
            choice2: [
              text("The Pika Cup is open to Pokémon level 15 to 20."),
              *text(
                "Choose three Pokémon to enter.\\n",
                "However, the total level of all three can't be higher ",
                "than 50.",
              ),
              text("Also, certain exotic kinds of Pokémon may not enter."),
              jump_label("Top"),
            ],
            choice3: [
              text("The Fancy Cup is open to baby Pokémon level 25 to 30."),
              *text(
                "Choose three Pokémon to enter.\\n",
                "However, the total level of all three can't be higher ",
                "than 80.",
              ),
              *text(
                "Also, very huge or very tall Pokémon may not enter",
                "the Fancy Cup.",
              ),
              *text(
                "The height limit is 2 meters, and the weight limit is 20",
                "kilograms for the Fancy Cup.",
              ),
              jump_label("Top"),
            ],
            choice4: [
              text("The Poké Cup is open to Pokémon level 50 to 55."),
              *text(
                "Choose three Pokémon to enter.\\n",
                "However, the total level of all three can't be higher",
                "than 155.",
              ),
              text("Also, certain exotic kinds of Pokémon may not enter."),
              jump_label("Top"),
            ],
          ),
          *show_choices(
            choices: ["Little Cup", "Battle rules", "Exit"],
            cancellation: 3,
            choice1: [
              *text(
                "The Little Cup is open to baby Pokémon at level 5",
                "that are capable of evolving.",
              ),
              *text(
                "Choose three Pokémon to enter a single battle,",
                "or four for a double battle.",
              ),
              *text(
                "Also, in the Little Cup, moves that deal a set",
                "amount of damage, like Dragon Rage and SonicBoom,",
                "will always miss.",
              ),
              jump_label("Top"),
            ],
            choice2: [
              text("In Stadium Cups, there are several rules to keep in mind."),
              *text(
                "First, two Pokémon in the same team can't be both",
                "asleep or both frozen at the same time.",
              ),
              *text(
                "Also, you can't choose two of the same kind of",
                "Pokémon, or two Pokémon holding the same item.",
              ),
              *text(
                "Finally, if a Pokémon uses Selfdestruct or Explosion to",
                "make all remaining Pokémon faint at the same time, that",
                "Pokémon's trainer loses.",
              ),
              jump_label("Top"),
            ],
          ),
        ],
        choice2: [
          *condition(
            script: "$PokemonGlobal.lastbattle != nil",
            then: [
              script("pbPlayLastBattle"),
            ],
            else: [
              text("There is no battle recorded."),
            ],
          ),
        ],
      ),
    ],
  ),
)