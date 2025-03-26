event(
  id: 5,
  name: "Battle recorder",
  x: 9,
  y: 3,
  page_0: page(
    commands: condition(
      character: player,
      facing: :up,
      then: [
        *show_choices(
          choices: ["Play recorded battle", "Exit"],
          cancellation: 2,
          choice1: [
            *condition(
              script: "$PokemonGlobal.lastbattle != nil",
              then: [
                script("pbPlayLastBattle"),
              ],
              else: [
                text("There is no battle recorded."),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
)