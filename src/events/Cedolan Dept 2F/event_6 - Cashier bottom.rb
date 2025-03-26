event(
  id: 6,
  name: "Cashier bottom",
  x: 1,
  y: 8,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      *script(
        <<~'CODE'
        pbPokemonMart([
          :POKEBALL, :GREATBALL, :ULTRABALL,
          :ESCAPEROPE,
          :REPEL, :SUPERREPEL, :MAXREPEL,
          :GRASSMAIL, :FLAMEMAIL,
          :BUBBLEMAIL, :SPACEMAIL
        ])
        CODE
      ),
    ],
  ),
)