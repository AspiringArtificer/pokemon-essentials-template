event(
  id: 8,
  name: "Battle recorder",
  x: 7,
  y: 3,
  page_0: page(
    commands: condition(
      character: player,
      facing: :up,
      then: [
        *show_choices(
          choices: ["Battle Factory rules", "Play recorded battle", "Cancel"],
          cancellation: 3,
          choice1: [
            label("Choices"),
            text("Which heading do you want to read?"),
            *show_choices(
              choices: ["Basic Rules", "Swapping", "Exit"],
              cancellation: 5,
              choice1: [
                *text(
                  "In the Battle Factory, you fight using Pokémon ",
                  "provided for you. You must use three Pokémon out of ",
                  "a choice of six.",
                ),
                *text(
                  "Pokémon in later rounds will be stronger than in ",
                  "earlier rounds, both yours and your opponents'.",
                ),
                jump_label("Choices"),
              ],
              choice2: [
                *text(
                  "When you defeat a Trainer, you may swap one of ",
                  "your Pokémon for one of theirs.",
                ),
                *text(
                  "You can't check the details of the Trainer's Pokémon ",
                  "before you choose one to gain in a swap. You will ",
                  "have to remember what it was like from the battle.",
                ),
                *text(
                  "Your team will remain in the same order even after a ",
                  "swap. For example, if you swap away your second ",
                  "Pokémon, the new Pokémon will now be second.",
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
  ),
)