event(
  id: 9,
  name: "Mom",
  x: 7,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 28",
      direction: :left,
    ),
    commands: condition(
      self_switch: "A",
      value: :ON,
      then: [
        *text(
          "\\rRemember to read the wiki for further information.  ",
          "An Internet shortcut to the wiki can be found in the ",
          "project's main folder.",
        ),
      ],
      else: [
        *script(
          <<~'CODE'
          $player.has_pokegear = true
          $player.has_running_shoes = true
          CODE
        ),
        play_me(audio(name: "Item get")),
        text("You received a Pokégear and Running Shoes."),
        control_self_switch("A", :ON),
      ],
    ),
  ),
  page_1: page(
    switch1: s(1),
    graphic: graphic(
      name: "NPC 28",
      direction: :left,
    ),
    trigger: :autorun,
    commands: [
      *comment(
        "Every map you can end up in after having all your ",
        "Pokémon faint (typically Poké Centers and home) ",
        "must have an Autorun event in it like this one.",
        "This event fully heals all the player's Pokémon, says ",
        "something to that effect, and turns the \"Starting ",
        "over\" switch OFF again.",
      ),
      *comment(
        "For convenience, this can be a single page in an ",
        "NPC's event (e.g. Mom, a nurse).",
      ),
      *text(
        "\\rOh... Are you all right? Well, you'll have better luck ",
        "this time.",
      ),
      recover_all(0),
      *text(
        "[This message was triggered by the \"Starting Over\" ",
        "Game Switch being ON. Now turning that Game ",
        "Switch off.]",
      ),
      control_switches(s(1), :OFF),
    ],
  ),
)