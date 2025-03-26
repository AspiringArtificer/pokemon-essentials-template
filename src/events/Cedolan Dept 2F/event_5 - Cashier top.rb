event(
  id: 5,
  name: "Cashier top",
  x: 1,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :right,
    ),
    commands: [
      *script(
        <<~'CODE'
        pbPokemonMart([
          :POTION, :SUPERPOTION,
          :HYPERPOTION, :MAXPOTION,
          :FULLRESTORE, :REVIVE,
          :ANTIDOTE, :PARALYZEHEAL,
          :BURNHEAL, :ICEHEAL,
          :AWAKENING, :FULLHEAL
        ])
        CODE
      ),
    ],
  ),
)