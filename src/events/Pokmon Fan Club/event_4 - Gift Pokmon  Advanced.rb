event(
  id: 4,
  name: "Gift Pokémon - Advanced",
  x: 9,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 08",
    ),
    commands: [
      *text(
        "\\rI have a rather special Bulbasaur! Its ability is",
        "something I could only dream of.",
      ),
      *text(
        "\\rI can't look after it, though. Would you like ",
        "Bulbasaur?",
      ),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *comment(
            "pbAddForeignPokemon can only add a Pokémon to ",
            "the player's party, so a space is required.",
          ),
          *condition(
            script: "pbAddForeignPokemon(:BULBASAUR, 10, _I(\"Dorima\"), _I(\"Sauri\"), 1)",
            then: [
              *comment(
                "Editing a foreign Pokémon added with this method ",
                "can only be done afterwards. Remember to add ",
                "\"poke.calcStats\" at the end, just in case a ",
                "modification affects the Pokémon's stats.",
              ),
              *comment(
                "The added Pokémon will always be at the end of the ",
                "player's party, so you can use $Trainer.last_party to ",
                "locate it.",
              ),
              *script(
                <<~'CODE'
                pkmn = $player.last_party
                pkmn.ability_index = 2  # Hidden abil
                pkmn.nature = :MODEST
                pkmn.poke_ball = :CHERISHBALL
                pkmn.shiny = true
                pkmn.calc_stats
                CODE
              ),
              text("\\rTake good care of Sauri!"),
              control_self_switch("A", :ON),
            ],
            else: [
              text("\\rOh, you don't have any space."),
            ],
          ),
        ],
        choice2: [
          text("\\rOh, that's a shame."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "NPC 08",
    ),
    commands: [
      text("\\rI hope you're taking good care of my Sauri!"),
    ],
  ),
)