event(
  id: 4,
  name: "Normal meteor",
  x: 11,
  y: 9,
  page_0: page(
    commands: condition(
      script: "$player.has_species?(:DEOXYS)",
      then: [
        text("Deoxys is reacting to the meteor..."),
        *text(
          "Would you like to bring the Deoxys in your party ",
          "closer to the meteor?",
        ),
        *show_choices(
          choices: ["Yes", "No"],
          cancellation: 2,
          choice1: [
            *script(
              <<~'CODE'
              $player.pokemon_party.each do |pkmn|
                next if !pkmn.isSpecies?(:DEOXYS)
                pkmn.form = 0
                pbSet(1, pkmn.name)
                break
              end
              CODE
            ),
            text("\\v[1] has changed to have balanced stats!"),
          ],
          choice2: [
            text("Left the meteor alone."),
          ],
        ),
      ],
      else: [
        text("It's a regular-looking rock."),
      ],
    ),
  ),
)