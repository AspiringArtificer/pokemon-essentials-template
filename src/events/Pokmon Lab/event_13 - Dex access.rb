event(
  id: 13,
  name: "Dex access",
  x: 3,
  y: 10,
  page_0: page(
    graphic: graphic(
      name: "trainer_SCIENTIST",
      direction: :right,
    ),
    commands: [
      *comment(
        "The numbers used for $Trainer.pokedex.lock(x) and ",
        "$Trainer.pokedex.unlock(x) are the ones defined in ",
        "the PBS file \"regionaldexes.txt\" for the ",
        "corresponding Regional Dex.",
        "The National Dex is not defined in that PBS file. It ",
        "uses the number -1 here.",
      ),
      label("Start"),
      *text(
        "\\bI can control your Pokédex access. What do you ",
        "want me to do?",
      ),
      *show_choices(
        choices: ["Kanto Dex access", "Johto Dex access", "National Dex access", "Exit"],
        cancellation: 4,
        choice1: [
          text("\\bWhat about it?"),
          *show_choices(
            choices: ["Unlock Kanto Dex", "Lock Kanto Dex", "Exit"],
            cancellation: 3,
            choice1: [
              script("$player.pokedex.unlock(0)"),
              text("\\bThe Kanto Dex was unlocked."),
            ],
            choice2: [
              script("$player.pokedex.lock(0)"),
              text("\\bThe Kanto Dex was locked."),
            ],
            choice3: [
              jump_label("Start"),
            ],
          ),
        ],
        choice2: [
          text("\\bWhat about it?"),
          *show_choices(
            choices: ["Unlock Johto Dex", "Lock Johto Dex", "Exit"],
            cancellation: 3,
            choice1: [
              script("$player.pokedex.unlock(1)"),
              text("\\bThe Johto Dex was unlocked."),
            ],
            choice2: [
              script("$player.pokedex.lock(1)"),
              text("\\bThe Johto Dex was locked."),
            ],
            choice3: [
              jump_label("Start"),
            ],
          ),
        ],
        choice3: [
          text("\\bWhat about it?"),
          *show_choices(
            choices: ["Unlock National Dex", "Lock National Dex", "Exit"],
            cancellation: 3,
            choice1: [
              script("$player.pokedex.unlock(-1)"),
              control_switches(s(29), :ON),
              text("\\bThe National Dex was unlocked."),
            ],
            choice2: [
              script("$player.pokedex.lock(-1)"),
              control_switches(s(29), :OFF),
              text("\\bThe National Dex was locked."),
            ],
            choice3: [
              jump_label("Start"),
            ],
          ),
        ],
      ),
    ],
  ),
)