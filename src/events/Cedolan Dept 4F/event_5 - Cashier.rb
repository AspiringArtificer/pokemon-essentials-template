event(
  id: 5,
  name: "Cashier",
  x: 3,
  y: 13,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :up,
    ),
    commands: [
      *script(
        <<~'CODE'
        pbPokemonMart([
          :POKEDOLL,
          :AIRMAIL, :TUNNELMAIL, :BLOOMMAIL,
          :FIRESTONE, :THUNDERSTONE,
          :WATERSTONE, :LEAFSTONE
        ])
        CODE
      ),
    ],
  ),
)