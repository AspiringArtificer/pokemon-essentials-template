event(
  id: 8,
  name: "Pokédex",
  x: 5,
  y: 4,
  page_0: page(
    graphic: graphic(
      tile_id: 1718,
    ),
    commands: condition(
      script: "!$player.has_pokedex",
      then: [
        play_me(audio(name: "Item get")),
        text("\\PN received a Pokédex!"),
        script("$player.has_pokedex = true"),
        control_self_switch("A", :ON),
      ],
      else: [
        text("You already have a Pokédex."),
      ],
    ),
  ),
  page_1: page(
    self_switch: "A",
  ),
)