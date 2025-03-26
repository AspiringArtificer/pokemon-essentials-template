event(
  id: 5,
  name: "Cashier",
  x: 10,
  y: 9,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :up,
    ),
    commands: [
      *script(
        <<~'CODE'
        pbPokemonMart([
          :TM21, :TM27,
          :TM87, :TM78,
          :TM12, :TM41,
          :TM20, :TM28,
          :TM76, :TM55,
          :TM72, :TM79
        ])
        CODE
      ),
    ],
  ),
)