# Route 1 (5)
#   Kurt's house (6)
map(
  tileset_id: 3,
  autoplay_bgm: true,
  bgm: audio(name: "Route 1", volume: 80),
  events: [

    event(
      id: 1,
      name: "Exit",
      x: 6,
      y: 8,
      page_0: page(
        trigger: :player_touch,
        commands: [
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          transfer_player(map: 5, x: 11, y: 6, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

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
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
       404,  404,  404,  404,  404,  404,  404,  404,  404,  404,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       412,  412,  412,  412,  412,  412,  412,  412,  412,  412,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1065, 1942,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
      1057, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048, 1048,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,
       542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,  542,

         0,    0, 1530, 1531,    0, 1712,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1569, 1570, 1538, 1539,    0, 1720,    0, 1908, 1909, 1910,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1577, 1578, 1546, 1547,    0, 1728,    0, 1940, 1941, 1911,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1168, 1169, 1169, 1169, 1169, 1170,    0, 1662, 1919,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0, 1176, 1177, 1177, 1177, 1177, 1178,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1770, 1184, 1185, 1185, 1185, 1185, 1186,    0,    0, 1770,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
      1778,    0,    0,    0,    0, 1245, 1246, 1247,    0, 1778,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0, 1253, 1254, 1255,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0, 1895,    0, 1894,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0, 1732,    0,    0, 1902,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1674, 2083, 2085, 1675,    0,    0,    0, 1732,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0, 1674, 2091, 2093, 1675,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
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
