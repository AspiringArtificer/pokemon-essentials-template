event(
  id: 6,
  name: "BP shop top",
  x: 8,
  y: 5,
  page_0: page(
    graphic: graphic(
      name: "NPC 19",
      direction: :left,
    ),
    commands: [
      *script(
        <<~'CODE'
        pbBattlePointShop([
          :SCOPELENS, :WIDELENS, :ZOOMLENS,
          :WISEGLASSES, :MUSCLEBAND,
          :BINDINGBAND,
          :RAZORCLAW, :RAZORFANG,
          :AIRBALLOON, :IRONBALL, :TOXICORB,
          :FLAMEORB, :LIFEORB,
          :WHITEHERB, :POWERHERB,
          :ABSORBBULB, :CELLBATTERY,
          :REDCARD, :EJECTBUTTON, :RARECANDY
        ])
        CODE
      ),
    ],
  ),
)