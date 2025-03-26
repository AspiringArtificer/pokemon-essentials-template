event(
  id: 2,
  name: "Kurt",
  x: 7,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 18",
    ),
    commands: [
      *condition(
        self_switch: "C",
        value: :OFF,
        then: [
          text("\\bHello! I'm Kurt!"),
          text("\\bI specialise in turning Apricorns into Poké Balls."),
          *text(
            "\\bIf you like, I can convert one of yours into a Poké ",
            "Ball.",
          ),
          control_self_switch("C", :ON),
        ],
        else: [
          text("\\bHello again."),
        ],
      ),
      text("\\bDo you have an Apricorn for me?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          text("\\bWhich Apricorn would you like me to convert?"),
          script("pbChooseApricorn(8)"),
          *condition(
            script: "pbGet(8) == :NONE",
            then: [
              comment("Player didn't choose an Apricorn."),
              *text(
                "\\bLet me know when you want me to convert an ",
                "Apricorn for you.",
              ),
            ],
            else: [
              comment("Player chose an Apricorn."),
              script("$bag.remove(pbGet(8))"),
              *script(
                <<~'CODE'
                data = GameData::Item.get(pbGet(8))
                pbSet(3, data.name)
                CODE
              ),
              text("\\bOkay. I'll turn your \\v[3] into a Poké Ball for you."),
              text("\\bI should be finished by tomorrow."),
              comment("Convert Apricorn into Ball now."),
              *script(
                <<~'CODE'
                conversion_hash = {
                  :REDAPRICORN    => :LEVELBALL,
                  :YELLOWAPRICORN => :MOONBALL,
                  :BLUEAPRICORN   => :LUREBALL,
                  :GREENAPRICORN  => :FRIENDBALL,
                  :PINKAPRICORN   => :LOVEBALL,
                  :WHITEAPRICORN  => :FASTBALL,
                  :BLACKAPRICORN  => :HEAVYBALL
                }
                CODE
              ),
              *script(
                <<~'CODE'
                conversion_hash.merge!({
                  :YLWAPRICORN => :MOONBALL,
                  :BLUAPRICORN => :LUREBALL,
                  :GRNAPRICORN => :FRIENDBALL,
                  :PNKAPRICORN => :LOVEBALL,
                  :WHTAPRICORN => :FASTBALL,
                  :BLKAPRICORN => :HEAVYBALL
                })
                CODE
              ),
              *script(
                <<~'CODE'
                item = pbGet(8)
                new_item = conversion_hash[item]
                pbSet(8, new_item)
                CODE
              ),
              script("pbSetEventTime"),
            ],
          ),
        ],
        choice2: [
          comment("Player doesn't want to choose an Apricorn."),
          text("\\bCome back when you have an Apricorn for me."),
        ],
      ),
    ],
  ),
  page_1: page(
    self_switch: "B",
    graphic: graphic(
      name: "NPC 18",
    ),
    commands: condition(
      script: "pbGet(8).is_a?(Symbol)",
      then: [
        *text(
          "\\bI've been waiting for you. I've completed the Poké ",
          "Ball you asked me to make.",
        ),
        *condition(
          script: "pbReceiveItem(pbGet(8))",
          then: [
            control_variables(v(8), constant: 0),
            control_self_switch("B", :OFF),
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
          "This only happens when Kurt is given an item that ",
          "couldn't be turned into a Poké Ball on page 1.",
        ),
        *comment(
          "This should never happen. If it does, there is a ",
          "mistake in the conversion_hash on page 1, namely ",
          "that it doesn't contain an \"apricorn => Poké Ball\" pair ",
          "for the item given to Kurt.",
        ),
        *text(
          "\\bI tried making a Poké Ball out of what you gave me, ",
          "but it didn't work.",
        ),
        text("\\bSorry."),
        control_self_switch("B", :OFF),
      ],
    ),
  ),
  page_2: page(
    self_switch: "A",
    graphic: graphic(
      name: "NPC 18",
    ),
    commands: [
      text("\\bI'm still working on your Apricorn. Come back later."),
    ],
  ),
  page_3: page(
    switch1: s(23),
    graphic: graphic(
      name: "NPC 18",
    ),
    trigger: :autorun,
    commands: [
      control_self_switch("A", :OFF),
      control_self_switch("B", :ON),
      script("setTempSwitchOn(\"A\")"),
    ],
  ),
)