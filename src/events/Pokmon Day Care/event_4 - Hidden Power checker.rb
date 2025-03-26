event(
  id: 4,
  name: "Hidden Power checker",
  x: 6,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "trainer_BIRDKEEPER",
      direction: :left,
    ),
    commands: [
      *text(
        "\\bI'll tell you what type your Pokémon's Hidden Power ",
        "will be.",
      ),
      text("\\bMy own hidden power lets me do that."),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          script("pbChooseNonEggPokemon(1, 3)"),
          *condition(
            variable: v(1),
            operation: ">=",
            constant: 0,
            then: [
              *comment(
                "The below scripts check whether the chosen Pokémon ",
                "knows or is able to learn Hidden Power (by level ",
                "up/TM/Move Tutor).",
                "Game Variable 2 will contain the name of Hidden ",
                "Power's type if it is learnable, or \"\" if it can't be ",
                "learned.",
              ),
              *script(
                <<~'CODE'
                move = :HIDDENPOWER
                pkmn = pbGetPokemon(1)
                data = pkmn.species_data
                compatible = false
                if pkmn.hasMove?(move) ||
                   pkmn.compatible_with_move?(move)
                  compatible = true
                end
                CODE
              ),
              *script(
                <<~'CODE'
                # Check level-up moves
                if !compatible
                  lvm = pkmn.getMoveList
                  if lvm.any? { |m| m[1] == move }
                    compatible = true
                  end
                end
                CODE
              ),
              *script(
                <<~'CODE'
                # Get type's name
                if compatible
                  type = pbHiddenPower(pkmn)[0]
                  nm = GameData::Type.get(type).name
                  pbSet(2, nm)
                else
                  pbSet(2, "")
                end
                CODE
              ),
              *condition(
                script: "pbGet(2) == \"\"",
                then: [
                  *text(
                    "\\bOh, no. This Pokémon can't learn the move Hidden ",
                    "Power in the first place.",
                  ),
                ],
                else: condition(
                  script: "pbGetPokemon(1).hasMove?(:HIDDENPOWER)",
                  then: [
                    text("\\bThis Pokémon's Hidden Power is the \\v[2] type."),
                  ],
                  else: [
                    *text(
                      "\\bIf this Pokémon were to learn Hidden Power, the ",
                      "move's type would be \\v[2].",
                    ),
                  ],
                ),
              ),
            ],
            else: [
              comment("No Pokémon was chosen."),
              jump_label("Cancel"),
            ],
          ),
        ],
        choice2: [
          label("Cancel"),
          *text(
            "\\bIf you want to know, ask me, and I'll activate my ",
            "hidden power for you.",
          ),
        ],
      ),
    ],
  ),
)