event(
  id: 6,
  name: "Cashier bottom",
  x: 1,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
    ),
    commands: [
      *script(
        <<~'CODE'
        pbPokemonMart([
          :XATTACK,
          :XDEFENSE,
          :XSPEED,
          :XSPATK,
          :XSPDEF,
          :XACCURACY,
          :GUARDSPEC,
          :DIREHIT
        ])
        CODE
      ),
    ],
  ),
)