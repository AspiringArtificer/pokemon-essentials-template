event(
  id: 7,
  name: "Battle recorder",
  x: 8,
  y: 3,
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
        choices: ["Battle Palace rules", "Play recorded battle", "Cancel"],
        cancellation: 3,
        choice1: [
          label("Top"),
          text("Which heading do you want to read?"),
          *show_choices(
            choices: ["Battle basics", "Pokémon nature", "Pokémon moves", "Underpowered"],
            cancellation: 0,
            choice1: [
              *text(
                "In the Battle Palace, Pokémon are required to think by ",
                "themselves.",
              ),
              *text(
                "Unlike in the wild, Pokémon that live with people ",
                "behave differently depending on their nature.",
              ),
              jump_label("Choices"),
            ],
            choice2: [
              *text(
                "Depending on its nature, a Pokémon may prefer to ",
                "attack no matter what.",
              ),
              *text(
                "Another Pokémon may prefer to protect itself from ",
                "harm.",
              ),
              *text(
                "Yet another may enjoy vexing or confounding its ",
                "foes.",
              ),
              *text(
                "A Pokémon's nature determines which moves it is ",
                "good at using, and which moves it has trouble using.",
              ),
              jump_label("Choices"),
            ],
            choice3: [
              *text(
                "There are offensive moves that deal direct damage ",
                "on the foe.",
              ),
              *text(
                "There are defensive moves that are used to prepare ",
                "for enemy attacks or used to heal HP and so on.",
              ),
              *text(
                "And there are other somewhat-odd moves that may ",
                "enfeeble the foe with status problems including ",
                "poison and paralysis.",
              ),
              *text(
                "Pokémon will consider using moves in these three ",
                "categories.",
              ),
              jump_label("Choices"),
            ],
            choice4: [
              *text(
                "When not taking commands from its Trainer, a ",
                "Pokémon may be unable to effectively use certain ",
                "kinds of moves.",
              ),
              *text(
                "A Pokémon is not good at using any move that it ",
                "dislikes.",
              ),
              *text(
                "If a Pokémon only knows moves that don't conform ",
                "to its nature, it will often be unable to live up to its ",
                "potential.",
              ),
              jump_label("Choices"),
            ],
          ),
          *show_choices(
            choices: ["When in danger", "Exit"],
            cancellation: 2,
            choice1: [
              *text(
                "Depending on its nature, a Pokémon may start using ",
                "moves that don't match its nature when it is in ",
                "trouble.",
              ),
              *text(
                "If a Pokémon begins behaving oddly in a pinch, watch ",
                "it carefully.",
              ),
              jump_label("Choices"),
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