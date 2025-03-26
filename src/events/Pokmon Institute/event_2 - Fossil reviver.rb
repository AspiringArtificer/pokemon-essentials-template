event(
  id: 2,
  name: "Fossil reviver",
  x: 10,
  y: 3,
  page_0: page(
    graphic: graphic(
      name: "trainer_SCIENTIST",
    ),
    commands: [
      *comment(
        "The fossil reviver finishes reviving the Pokémon as ",
        "soon as you step out of the door. See the exit event ",
        "on this map.",
      ),
      *condition(
        self_switch: "B",
        value: :OFF,
        then: [
          text("\\bOh, hello. I'm a scientist."),
          text("\\bI can turn fossils into living, breathing Pokémon!"),
          control_self_switch("B", :ON),
        ],
        else: [
          text("\\bAiyah! You come again!"),
        ],
      ),
      text("\\bDo you have a fossil for me?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\bWhich fossil do you want me to revive?"),
          script("pbChooseFossil(9)"),
          *condition(
            script: "pbGet(9) == :NONE",
            then: [
              comment("Player didn't choose a fossil."),
              *text(
                "\\bLet me know when you want me to revive a ",
                "fossil for you.",
              ),
            ],
            else: [
              comment("Player chose a fossil."),
              script("$bag.remove(pbGet(9))"),
              *script(
                <<~'CODE'
                data = GameData::Item.get(pbGet(9))
                pbSet(3, data.name)
                CODE
              ),
              text("\\bOkay. I'll see if I can revive your \\v[3]."),
              text("\\bCome back later."),
              comment("Convert fossil into species now."),
              *script(
                <<~'CODE'
                conversion_hash = {
                  :HELIXFOSSIL => :OMANYTE,
                  :DOMEFOSSIL  => :KABUTO,
                  :OLDAMBER    => :AERODACTYL,
                  :ROOTFOSSIL  => :LILEEP,
                  :CLAWFOSSIL  => :ANORITH,
                  :SKULLFOSSIL => :CRANIDOS,
                  :ARMORFOSSIL => :SHIELDON
                }
                CODE
              ),
              *script(
                <<~'CODE'
                conversion_hash.merge!({
                  :COVERFOSSIL => :TIRTOUGA,
                  :PLUMEFOSSIL => :ARCHEN,
                  :JAWFOSSIL   => :TYRUNT,
                  :SAILFOSSIL  => :AMAURA
                })
                CODE
              ),
              *script(
                <<~'CODE'
                item = pbGet(9)
                species = conversion_hash[item]
                pbSet(9, species)
                CODE
              ),
              control_self_switch("A", :ON),
              control_switches(s(13), :ON),
            ],
          ),
        ],
        choice2: [
          comment("Player doesn't want to choose a fossil."),
          text("\\bI'll be here if you want my help."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "A",
    graphic: graphic(
      name: "trainer_SCIENTIST",
    ),
    commands: condition(
      script: "pbGet(9).is_a?(Symbol)",
      then: [
        *script(
          <<~'CODE'
          data = GameData::Species.get(
            pbGet(9))
          pbSet(3, data.name)
          CODE
        ),
        *text(
          "\\bWhere have you been? I've finished reviving your",
          "fossil.",
        ),
        text("\\bIt was \\v[3] like I thought."),
        *condition(
          script: "pbAddToParty(pbGet(9), 1)",
          then: [
            script("$stats.revived_fossil_count += 1"),
            control_variables(v(9), constant: 0),
            control_self_switch("A", :OFF),
          ],
          else: [
            *text(
              "\\bYou have no room left. Make room, then come see ",
              "me.",
            ),
          ],
        ),
      ],
      else: [
        *comment(
          "This only happens when the fossil reviver is given an ",
          "item that couldn't be turned into a species on page 1.",
        ),
        *comment(
          "This should never happen. If it does, there is a ",
          "mistake in the conversion_hash on page 1, namely ",
          "that it doesn't contain a \"fossil => species\" pair for ",
          "the item given to the fossil reviver.",
        ),
        text("\\bI managed to revive your fossil."),
        *text(
          "\\bHowever, what I brought back didn't live long...\\1 ",
          "fortunately.",
        ),
        text("\\bSorry."),
        control_self_switch("A", :OFF),
      ],
    ),
  ),
  page_2: page(
    switch1: s(13),
    graphic: graphic(
      name: "trainer_SCIENTIST",
    ),
    commands: [
      text("\\bI told you, come back later."),
    ],
  ),
)