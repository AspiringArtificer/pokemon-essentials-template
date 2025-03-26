event(
  id: 14,
  name: "Pokémon-checking NPC",
  x: 1,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "trainer_SCIENTIST",
      direction: :right,
    ),
    commands: [
      label("Choices"),
      text("Choose a topic."),
      *show_choices(
        choices: ["What is your first Pokémon?", "Is a Celebi in your party?", "Give a Celebi", "Cancel"],
        cancellation: 4,
        choice1: [
          *comment(
            "Get the first able Pokémon in the party, and store its ",
            "party index in Game Variable 1.",
            "Stores -1 if it can't find an able Pokémon in the party.",
            "An \"able\" Pokémon is a non-Egg, non-fainted ",
            "Pokémon.",
          ),
          script("pbFirstAblePokemon(1)"),
          *condition(
            variable: v(1),
            operation: "<",
            constant: 0,
            then: [
              text("You don't have any able Pokémon with you."),
            ],
            else: [
              *comment(
                "Retrieve the Pokémon whose party index is in ",
                "Game Variable 1.",
                "Store that Pokémon's name in Game Variable 2.",
              ),
              *script(
                <<~'CODE'
                pkmn = pbGetPokemon(1)
                pbSet(2, pkmn.name)
                CODE
              ),
              text("\\v[2] is the first Pokémon in your party."),
            ],
          ),
          jump_label("Choices"),
        ],
        choice2: [
          comment("Counts fainted Pokémon, but not Eggs."),
          *condition(
            script: "$player.has_species?(:CELEBI)",
            then: [
              text("You have a Celebi in your party."),
            ],
            else: [
              text("You don't have a Celebi in your party."),
            ],
          ),
          jump_label("Choices"),
        ],
        choice3: [
          *comment(
            "Gives the player a Level 20 Celebi.",
            "If it can't be added to the party, it is stored in the PC ",
            "instead.",
            "To only let the Pokémon be added to the party, use ",
            "pbAddToParty instead.",
          ),
          *comment(
            "See the Pokémon Fan Club events for more ",
            "examples.",
          ),
          script("pbAddPokemon(:CELEBI, 20)"),
        ],
      ),
    ],
  ),
)