event(
  id: 5,
  name: "BP shop bottom",
  x: 8,
  y: 6,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :left,
    ),
    commands: [
      *script(
        <<~'CODE'
        pbBattlePointShop([
          :PROTEIN, :CALCIUM, :IRON,
          :ZINC, :CARBOS, :HPUP,
          :POWERBRACER, :POWERBELT,
          :POWERLENS, :POWERBAND,
          :POWERANKLET, :POWERWEIGHT,
          :CHOICEBAND, :CHOICESPECS,
          :CHOICESCARF,
          :FOCUSBAND, :FOCUSSASH
        ])
        CODE
      ),
    ],
  ),
)