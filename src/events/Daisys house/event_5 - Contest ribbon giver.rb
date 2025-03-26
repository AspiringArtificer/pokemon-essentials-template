event(
  id: 5,
  name: "Contest ribbon giver",
  x: 3,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "trainer_LADY",
    ),
    commands: [
      *comment(
        "Gives or upgrades a contest ribbon for the lead ",
        "Pokémon.",
        "The method upgradeRibbon either upgrades an ",
        "existing ribbon to the next one listed, or gives the ",
        "first ribbon if the Pokémon has none of them.",
        "Returns nil if couldn't add/upgrade a ribbon.",
      ),
      text("\\rHi! I'm the Contest Lady!"),
      text("\\rI give out contest ribbons. Do you want one?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *script(
            <<~'CODE'
            pkmn = $player.first_pokemon
            ret = pkmn.upgradeRibbon(
              :HOENNCOOL,
              :HOENNCOOLSUPER,
              :HOENNCOOLHYPER,
              :HOENNCOOLMASTER
            )
            CODE
          ),
          *script(
            <<~'CODE'
            pbSet(1, ret || :NONE)
            pbSet(2, pkmn.name)
            if ret
              data = GameData::Ribbon.get(ret)
              pbSet(3, data.name)
            end
            CODE
          ),
          *condition(
            script: "pbGet(1) == :NONE",
            then: [
              *text(
                "\\rSorry, your \\v[2] already has the highest ranked ",
                "Cool Ribbon.",
              ),
            ],
            else: [
              *text(
                "\\PN received the \\v[3].",
                "\\me[Item get]\\wtnp[40]",
              ),
              text("\\PN put the \\v[3] on \\v[2]."),
            ],
          ),
        ],
        choice2: [
          text("\\rThat's your choice."),
        ],
      ),
    ],
  ),
)