event(
  id: 3,
  name: "Dr Footstep",
  x: 1,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 07",
    ),
    commands: [
      text("\\bDr. Footstep: Hi! I rate the footprints of Pokémon!"),
      text("\\bDr. Footstep: Can I rate your Pokémon for you?"),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *text(
            "\\bDr. Footstep: Which Pokémon do you want me to ",
            "rate?",
          ),
          script("pbChooseNonEggPokemon(1, 2)"),
          *condition(
            variable: v(1),
            operation: "<",
            constant: 0,
            then: [
              text("\\bDr. Footstep: Maybe next time, then."),
              exit_event_processing,
            ],
          ),
          *script(
            <<~'CODE'
            pkmn = pbGetPokemon(1)
            h = pkmn.happiness
            stage = 0
            stage = 1 if h >= 1
            stage = 2 if h >= 50
            stage = 3 if h >= 100
            stage = 4 if h >= 150
            stage = 5 if h >= 200
            stage = 6 if h >= 255
            pbSet(3, stage)
            CODE
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 0,
            then: [
              *text(
                "\\bDr. Footstep: By any chance, you... Are you a very ",
                "strict person? I feel that your \\v[2] really doesn't like ",
                "you...",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 1,
            then: [
              *text(
                "\\bDr. Footstep: Hmmm... Your \\v[2] may not like you ",
                "very much.",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 2,
            then: [
              *text(
                "\\bDr. Footstep: The relationship is neither good nor ",
                "bad... Your \\v[2] looks neutral.",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 3,
            then: [
              *text(
                "\\bDr. Footstep: Your \\v[2] is a little friendly to you... ",
                "That's what I'm getting.",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 4,
            then: [
              *text(
                "\\bDr. Footstep: Your \\v[2] is friendly to you. It must be ",
                "happy with you.",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 5,
            then: [
              *text(
                "\\bDr. Footstep: Your \\v[2] is quite friendly to you! You ",
                "must be a kind person!",
              ),
            ],
          ),
          *condition(
            variable: v(3),
            operation: "==",
            constant: 6,
            then: [
              *text(
                "\\bDr. Footstep: Your \\v[2] is super friendly to you! I'm ",
                "a bit jealous!",
              ),
              *condition(
                script: "!pbGetPokemon(1).hasRibbon?(:FOOTPRINT)",
                then: [
                  text("\\bDr. Footstep: I shall reward your \\v[2] with a ribbon!"),
                  *script(
                    <<~'CODE'
                    pkmn = pbGetPokemon(1)
                    pkmn.giveRibbon(:FOOTPRINT)
                    CODE
                  ),
                  *text(
                    "\\PN received the Footprint Ribbon.",
                    "\\me[Item get]\\wtnp[20]",
                  ),
                  text("\\PN put the Footprint Ribbon on \\v[2]."),
                ],
              ),
            ],
          ),
        ],
        choice2: [
          text("\\bDr. Footstep: Maybe next time, then."),
        ],
      ),
    ],
  ),
)