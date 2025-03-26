event(
  id: 4,
  name: "Effort ribbon giver",
  x: 2,
  y: 4,
  page_0: page(
    graphic: graphic(
      name: "NPC 04",
    ),
    commands: [
      *comment(
        "Looks at the total EVs of the lead Pokémon, and ",
        "rewards a ribbon to it if the total is maxed (equal to ",
        "Pokemon::EV_LIMIT, which is 510 by default).",
      ),
      *script(
        <<~'CODE'
        pkmn = $player.first_pokemon
        total = 0
        pkmn.ev.each_value { |v| total += v }
        maxed = 0
        if total >= Pokemon::EV_LIMIT
          maxed = 1
        end
        maxed = 2 if pkmn.hasRibbon?(:EFFORT)
        pbSet(1, pkmn.name)
        pbSet(2, maxed)
        CODE
      ),
      text("\\rOh?\\nYour \\v[1]..."),
      *condition(
        variable: v(2),
        operation: "==",
        constant: 2,
        then: [
          comment("Pokémon already has an Effort Ribbon."),
          text("\\rOh! Your \\v[1], that Effort Ribbon looks good on it!"),
        ],
        else: condition(
          variable: v(2),
          operation: "==",
          constant: 1,
          then: [
            *comment(
              "Pokémon has full EVs and does not already have an ",
              "Effort Ribbon - give it that ribbon.",
            ),
            text("\\rWent for it stupendously!"),
            text("\\rAs its reward, please give it this Effort Ribbon."),
            *script(
              <<~'CODE'
              pkmn = $player.first_pokemon
              pkmn.giveRibbon(:EFFORT)
              CODE
            ),
            *text(
              "\\PN received the Effort Ribbon.",
              "\\me[Item get]\\wtnp[20]",
            ),
            text("\\PN put the Effort Ribbon on \\v[1]."),
          ],
          else: [
            comment("Pokémon does not have full EVs."),
            text("\\rYou have to go for it a little harder."),
            text("\\rIf you do, I'll give your Pokémon something nice."),
          ],
        ),
      ),
    ],
  ),
)