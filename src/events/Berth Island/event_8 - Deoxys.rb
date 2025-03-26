event(
  id: 8,
  name: "Deoxys",
  x: 14,
  y: 12,
  page_0: page(
    graphic: graphic(
      name: "Pokemon 12",
    ),
    commands: [
      script("Pokemon.play_cry(:DEOXYS)"),
      wait(15),
      control_switches(s(32), :ON),
      script("WildBattle.start(:DEOXYS, 30)"),
      control_switches(s(32), :OFF),
      control_self_switch("A", :ON),
    ],
  ),
  page_1: page(
    self_switch: "A",
  ),
)