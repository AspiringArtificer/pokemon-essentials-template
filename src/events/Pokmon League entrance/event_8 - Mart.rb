event(
  id: 8,
  name: "Mart",
  x: 0,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :right,
    ),
    commands: [
      *condition(
        script: "$player.badge_count >= 8",
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL, :GREATBALL, :ULTRABALL,
              :POTION, :SUPERPOTION,
              :HYPERPOTION, :MAXPOTION,
              :FULLRESTORE, :REVIVE,
              :ANTIDOTE, :PARALYZEHEAL,
              :AWAKENING, :BURNHEAL, :ICEHEAL,
              :FULLHEAL,
              :ESCAPEROPE,
              :REPEL, :SUPERREPEL, :MAXREPEL
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *condition(
        script: "$player.badge_count >= 7",
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL, :GREATBALL, :ULTRABALL,
              :POTION, :SUPERPOTION,
              :HYPERPOTION, :MAXPOTION,
              :REVIVE,
              :ANTIDOTE, :PARALYZEHEAL,
              :AWAKENING, :BURNHEAL, :ICEHEAL,
              :FULLHEAL,
              :ESCAPEROPE,
              :REPEL, :SUPERREPEL, :MAXREPEL
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *condition(
        script: "$player.badge_count >= 5",
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL, :GREATBALL, :ULTRABALL,
              :POTION, :SUPERPOTION,
              :HYPERPOTION,
              :REVIVE,
              :ANTIDOTE, :PARALYZEHEAL,
              :AWAKENING, :BURNHEAL, :ICEHEAL,
              :FULLHEAL,
              :ESCAPEROPE,
              :REPEL, :SUPERREPEL, :MAXREPEL
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *condition(
        script: "$player.badge_count >= 3",
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL, :GREATBALL,
              :POTION, :SUPERPOTION,
              :HYPERPOTION,
              :REVIVE,
              :ANTIDOTE, :PARALYZEHEAL,
              :AWAKENING, :BURNHEAL, :ICEHEAL,
              :ESCAPEROPE,
              :REPEL, :SUPERREPEL
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *condition(
        script: "$player.badge_count >= 1",
        then: [
          *script(
            <<~'CODE'
            pbPokemonMart([
              :POKEBALL, :GREATBALL,
              :POTION, :SUPERPOTION,
              :ANTIDOTE, :PARALYZEHEAL,
              :AWAKENING, :BURNHEAL, :ICEHEAL,
              :ESCAPEROPE,
              :REPEL
            ])
            CODE
          ),
          exit_event_processing,
        ],
      ),
      *script(
        <<~'CODE'
        pbPokemonMart([
          :POKEBALL,
          :POTION
        ])
        CODE
      ),
    ],
  ),
)