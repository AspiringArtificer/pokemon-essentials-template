# Cedolan City (7)
#   Pokémon Institute (11)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Cedolan City", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 7,
      y: 10,
      page_0: page(
        trigger: :player_touch,
        commands: [
          *comment(
            "This command makes the fossil reviver finish reviving ",
            "a Pokémon.",
          ),
          control_switches(s(13), :OFF),
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 7, x: 35, y: 28, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

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
    ),

    event(
      id: 3,
      name: "PC",
      x: 1,
      y: 1,
      page_0: page(
        commands: [
          script("pbPokeCenterPC"),
        ],
      ),
    ),

    event(
      id: 4,
      name: "Fossil combiner",
      x: 5,
      y: 3,
      page_0: page(
        graphic: graphic(
          name: "trainer_SCIENTIST",
        ),
        commands: [
          *comment(
            "The fossil combiner is from Gen 8. They take two ",
            "different fossil items and produce a Pokémon based ",
            "on the combination. This is a relatively ",
            "straightforward \"choose an item from each of two ",
            "lists, add a Pokémon based on what was chosen\".",
          ),
          *condition(
            self_switch: "B",
            value: :OFF,
            then: [
              *text(
                "\\bHello, huh! My name is Carl Ess. I can turn ",
                "combinations of partial Fossils into living, breathing ",
                "Pokémon!",
              ),
              control_self_switch("B", :ON),
            ],
          ),
          comment("================================"),
          *comment(
            "Check whether the player has at least one top fossil ",
            "and at least one bottom fossil. The result of this ",
            "check could have been stored in a Game Switch ",
            "rather than a Game Variable, because it's just \"yes or ",
            "no\", but there are no Game Switches for temporary ",
            "values and I didn't feel like makng one just for this.",
          ),
          *script(
            <<~'CODE'
            top = $bag.has?(:FOSSILIZEDBIRD) ||
                  $bag.has?(:FOSSILIZEDFISH)
            btm = $bag.has?(:FOSSILIZEDDRAKE) ||
                  $bag.has?(:FOSSILIZEDDINO)
            pbSet(1, (top && btm) ? 1 : 0)
            CODE
          ),
          *condition(
            variable: v(1),
            operation: "==",
            constant: 1,
            then: [
              *comment(
                "The choice of top fossil will be stored in Game Variable ",
                "1 (1=Bird, 2=Fish, 0=Quit).",
                "The choice of bottom fossil will be stored in Game ",
                "Variable 2 (1=Drake, 2=Dino, 0=Quit).",
              ),
              control_variables(v(1), constant: 0),
              *text(
                "\\bHm? You've got some Fossils there, huh. Will you ",
                "show them to me, Carl Ess?",
              ),
              *show_choices(
                choices: ["Yes", "No"],
                cancellation: 2,
                choice1: [
                  label("Start choices"),
                  comment("================================"),
                  comment("Choose the top half."),
                  *condition(
                    script: "$bag.has?(:FOSSILIZEDBIRD) && $bag.has?(:FOSSILIZEDFISH)",
                    then: [
                      *text(
                        "\\bWhich of your Fossils do you think stands up to the ",
                        "high standards of Carl Ess?",
                      ),
                      *show_choices(
                        choices: ["Fossilized Bird", "Fossilized Fish", "Quit"],
                        cancellation: 3,
                        choice1: [
                          control_variables(v(1), constant: 1),
                        ],
                        choice2: [
                          control_variables(v(1), constant: 2),
                        ],
                        choice3: [
                          jump_label("Quit"),
                        ],
                      ),
                    ],
                    else: condition(
                      script: "$bag.has?(:FOSSILIZEDBIRD)",
                      then: [
                        *text(
                          "\\bWhich of your Fossils do you think stands up to the ",
                          "high standards of Carl Ess?",
                        ),
                        *show_choices(
                          choices: ["Fossilized Bird", "Quit"],
                          cancellation: 2,
                          choice1: [
                            control_variables(v(1), constant: 1),
                          ],
                          choice2: [
                            jump_label("Quit"),
                          ],
                        ),
                      ],
                      else: [
                        *text(
                          "\\bWhich of your Fossils do you think stands up to the ",
                          "high standards of Carl Ess?",
                        ),
                        *show_choices(
                          choices: ["Fossilized Fish", "Quit"],
                          cancellation: 2,
                          choice1: [
                            control_variables(v(1), constant: 2),
                          ],
                          choice2: [
                            jump_label("Quit"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  comment("================================"),
                  comment("Choose the bottom half."),
                  *condition(
                    script: "$bag.has?(:FOSSILIZEDDRAKE) && $bag.has?(:FOSSILIZEDDINO)",
                    then: [
                      *text(
                        "\\bWhich of your Fossils do you think will pique the ",
                        "curiosity of Carl Ess?",
                      ),
                      *show_choices(
                        choices: ["Fossilized Drake", "Fossilized Dino", "Quit"],
                        cancellation: 3,
                        choice1: [
                          control_variables(v(2), constant: 1),
                        ],
                        choice2: [
                          control_variables(v(2), constant: 2),
                        ],
                        choice3: [
                          jump_label("Quit"),
                        ],
                      ),
                    ],
                    else: condition(
                      script: "$bag.has?(:FOSSILIZEDDRAKE)",
                      then: [
                        *text(
                          "\\bWhich of your Fossils do you think will pique the ",
                          "curiosity of Carl Ess?",
                        ),
                        *show_choices(
                          choices: ["Fossilized Drake", "Quit"],
                          cancellation: 2,
                          choice1: [
                            control_variables(v(2), constant: 1),
                          ],
                          choice2: [
                            jump_label("Quit"),
                          ],
                        ),
                      ],
                      else: [
                        *text(
                          "\\bWhich of your Fossils do you think will pique the ",
                          "curiosity of Carl Ess?",
                        ),
                        *show_choices(
                          choices: ["Fossilized Dino", "Quit"],
                          cancellation: 2,
                          choice1: [
                            control_variables(v(2), constant: 2),
                          ],
                          choice2: [
                            jump_label("Quit"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                choice2: [
                  jump_label("Quit"),
                ],
              ),
            ],
            else: [
              comment("================================"),
              comment("Player doesn't have at least one fossil for each end."),
              *text(
                "\\bCome see me when you have some interesting ",
                "Fossils.",
              ),
              exit_event_processing,
            ],
          ),
          comment("================================"),
          *comment(
            "Determine which Pokémon will be revived from the ",
            "chosen fossils. Its species is stored in Game Variable ",
            "14.",
          ),
          *condition(
            variable: v(1),
            operation: "==",
            constant: 1,
            then: condition(
              variable: v(2),
              operation: "==",
              constant: 1,
              then: [
                comment("Bird + Drake = Dracozolt"),
                *text(
                  "\\bSo I should restore the Fossilized Bird and the ",
                  "Fossilized Drake together, huh?",
                ),
                *show_choices(
                  choices: ["Yes, please", "I want to try something else", "Quit"],
                  cancellation: 3,
                  choice1: [
                    script("pbSet(14, :DRACOZOLT)"),
                  ],
                  choice2: [
                    jump_label("Start choices"),
                  ],
                  choice3: [
                    jump_label("Quit"),
                  ],
                ),
              ],
              else: [
                comment("Bird + Dino = Arctozolt"),
                *text(
                  "\\bSo I should restore the Fossilized Bird and the ",
                  "Fossilized Dino together, huh?",
                ),
                *show_choices(
                  choices: ["Yes, please", "I want to try something else", "Quit"],
                  cancellation: 3,
                  choice1: [
                    script("pbSet(14, :ARCTOZOLT)"),
                  ],
                  choice2: [
                    jump_label("Start choices"),
                  ],
                  choice3: [
                    jump_label("Quit"),
                  ],
                ),
              ],
            ),
            else: condition(
              variable: v(2),
              operation: "==",
              constant: 1,
              then: [
                comment("Fish + Drake = Dracovish"),
                *text(
                  "\\bSo I should restore the Fossilized Fish and the ",
                  "Fossilized Drake together, huh?",
                ),
                *show_choices(
                  choices: ["Yes, please", "I want to try something else", "Quit"],
                  cancellation: 3,
                  choice1: [
                    script("pbSet(14, :DRACOVISH)"),
                  ],
                  choice2: [
                    jump_label("Start choices"),
                  ],
                  choice3: [
                    jump_label("Quit"),
                  ],
                ),
              ],
              else: [
                comment("Fish + Dino = Arctovish"),
                *text(
                  "\\bSo I should restore the Fossilized Fish and the ",
                  "Fossilized Dino together, huh?",
                ),
                *show_choices(
                  choices: ["Yes, please", "I want to try something else", "Quit"],
                  cancellation: 3,
                  choice1: [
                    script("pbSet(14, :ARCTOVISH)"),
                  ],
                  choice2: [
                    jump_label("Start choices"),
                  ],
                  choice3: [
                    jump_label("Quit"),
                  ],
                ),
              ],
            ),
          ),
          comment("================================"),
          *comment(
            "Create the Pokémon from the chosen fossils, and ",
            "give it to the player.",
          ),
          *condition(
            script: "GameData::Species.exists?(pbGet(14))",
            then: [
              *comment(
                "Fossils can be combined and will make a Pokémon. ",
                "Remove the fossil items and add the Pokémon.",
              ),
              *condition(
                variable: v(1),
                operation: "==",
                constant: 1,
                then: [
                  script("$bag.remove(:FOSSILIZEDBIRD)"),
                ],
                else: [
                  script("$bag.remove(:FOSSILIZEDFISH)"),
                ],
              ),
              *condition(
                variable: v(2),
                operation: "==",
                constant: 1,
                then: [
                  script("$bag.remove(:FOSSILIZEDDRAKE)"),
                ],
                else: [
                  script("$bag.remove(:FOSSILIZEDDINO)"),
                ],
              ),
              *text(
                "\\bOK. Restoration time. Let's unravel the mystery of ",
                "these Fossils!",
              ),
              text("\\bAll right, I'll stick 'em together! Here... we... GO!"),
              wait(20),
              *text(
                "\\bObjective complete. It seems the restoration was a ",
                "great success.",
              ),
              *text(
                "\\bYes, I can see it in its eyes. This is a Pokémon that ",
                "walked the face of Essen in ancient times! Please ",
                "take and care for this Pokémon, huh.",
              ),
              *condition(
                script: "pbAddToParty(pbGet(14), 1)",
                then: [
                  script("$stats.revived_fossil_count += 1"),
                  control_variables(v(14), constant: 0),
                  comment("Pokémon was added!"),
                ],
                else: [
                  *comment(
                    "The Pokémon couldn't be added to the party. Keep its ",
                    "species in Game Variable 14 and turn Self Switch A ",
                    "on, to let the player collect it once they have space in ",
                    "their party. See page 2 of this event.",
                  ),
                  *text(
                    "\\bOh, you don't have space in your party, huh. Make ",
                    "some room and then come back here for your ",
                    "Pokémon.",
                  ),
                  control_self_switch("A", :ON),
                ],
              ),
            ],
            else: [
              comment("The species to be revived is not defined. Do nothing."),
              control_variables(v(14), constant: 0),
              text("\\bOh. They don't seem to work together."),
            ],
          ),
          exit_event_processing,
          comment("================================"),
          label("Quit"),
          text("\\bMaybe some other time, then."),
        ],
      ),
      page_1: page(
        self_switch: "A",
        graphic: graphic(
          name: "trainer_SCIENTIST",
        ),
        commands: [
          *text(
            "\\bHuh, have you made some room for your Pokémon ",
            "yet?",
          ),
          *condition(
            script: "pbAddToParty(pbGet(14), 1)",
            then: [
              script("$stats.revived_fossil_count += 1"),
              control_variables(v(14), constant: 0),
              control_self_switch("A", :OFF),
            ],
            else: [
              *text(
                "\\bYou haven't. Make some room and then come back ",
                "here.",
              ),
            ],
          ),
        ],
      ),
    ),

    event(
      id: 5,
      name: "Old Amber",
      x: 11,
      y: 6,
      page_0: page(
        graphic: graphic(
          tile_id: 1726,
        ),
        commands: condition(
          script: "pbItemBall(:OLDAMBER)",
          then: [
            control_self_switch("A", :ON),
          ],
        ),
      ),
      page_1: page(
        self_switch: "A",
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       520,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  521,  523,  542,  542,  542,  542,  542,
       528,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  529,  531,  542,  542,  542,  542,  542,
       593,  593,  617,  617,  617,  617,  617,  617,  617,  617,  617,  617,  593,  593,  618,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       593,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  584,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

       520, 1693,    0, 1789, 1790, 1791, 1789, 1790, 1791, 1789, 1790, 1788, 1784, 1785,  523,    0,    0,    0,    0,    0,
       528, 1701,    0, 1797, 1798, 1799, 1797, 1798, 1799, 1797, 1798, 1796, 1792, 1793,  531,    0,    0,    0,    0,    0,
       536, 1709,    0, 1805, 1806, 1807, 1805, 1806, 1807, 1805, 1806, 1804, 1800, 1801,  539,    0,    0,    0,    0,    0,
      1744,    0, 1924, 1925, 1926,    0,    0,    0,    0,    0,    0,    0,    0, 1744, 1744,    0,    0,    0,    0,    0,
      1744,    0, 1916, 1917, 1918,    0,    0, 1907, 1907,    0,    0, 1924, 1925, 1926,    0,    0,    0,    0,    0,    0,
         0,    0,    0, 1662,    0,    0, 1662, 1931, 1931, 1662,    0, 1932, 1933, 1934, 1662,    0,    0,    0,    0,    0,
         0,    0, 1924, 1925, 1926,    0, 1662, 1931, 1931, 1662,    0, 1932, 1933, 1934,    0,    0,    0,    0,    0,    0,
         0,    0, 1916, 1917, 1918,    0,    0, 1939, 1939,    0,    0, 1916, 1917, 1918, 1662,    0,    0,    0,    0,    0,
         0,    0,    0, 1662,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0, 1245, 1246, 1247,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1856, 1857, 1860,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1864, 1865, 1868,    0,    0, 1872,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0, 1880, 1875,    0,    0,    0, 1724,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1856, 1857, 1860,    0,    0, 1871, 1883,    0,    0,    0,    0, 1732,    0,    0,    0,    0,    0,    0,
         0,    0, 1864, 1865, 1868,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
