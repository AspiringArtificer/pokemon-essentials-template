event(
  id: 2,
  name: "Vending machine size(3,1)",
  x: 17,
  y: 7,
  page_0: page(
    commands: condition(
      character: player,
      facing: :up,
      then: [
        label("Start"),
        *text(
          "It's a vending machine.\\nWhich drink would you like?",
          "\\G",
        ),
        *show_choices(
          choices: ["Fresh Water - $200", "Soda Pop - $300", "Lemonade - $350", "Cancel"],
          cancellation: 4,
          choice1: [
            *condition(
              gold: 200,
              operation: ">=",
              then: condition(
                script: "$bag.can_add?(:FRESHWATER)",
                then: [
                  change_gold("-=", constant: 200),
                  script("$stats.drinks_bought += 1"),
                  script("$bag.add(:FRESHWATER)"),
                  play_se(audio(name: "Vending machine dispense", volume: 80)),
                  text("\\GA Fresh Water dropped down!"),
                  control_variables(v(1), random: 0..10),
                  *condition(
                    variable: v(1),
                    operation: "==",
                    constant: 0,
                    then: condition(
                      script: "$bag.can_add?(:FRESHWATER)",
                      then: [
                        script("$stats.drinks_won += 1"),
                        script("$bag.add(:FRESHWATER)"),
                        play_se(audio(name: "Vending machine dispense", volume: 80)),
                        text("\\GBonus! Another Fresh Water dropped down."),
                      ],
                    ),
                  ),
                  jump_label("Start"),
                ],
                else: [
                  text("\\GYou have no room left in the Bag."),
                ],
              ),
              else: [
                text("\\GYou don't have enough money."),
              ],
            ),
          ],
          choice2: [
            *condition(
              gold: 300,
              operation: ">=",
              then: condition(
                script: "$bag.can_add?(:SODAPOP)",
                then: [
                  change_gold("-=", constant: 300),
                  script("$stats.drinks_bought += 1"),
                  script("$bag.add(:SODAPOP)"),
                  play_se(audio(name: "Vending machine dispense", volume: 80)),
                  text("\\GA Soda Pop dropped down!"),
                  control_variables(v(1), random: 0..10),
                  *condition(
                    variable: v(1),
                    operation: "==",
                    constant: 0,
                    then: condition(
                      script: "$bag.can_add?(:SODAPOP)",
                      then: [
                        script("$stats.drinks_won += 1"),
                        script("$bag.add(:SODAPOP)"),
                        play_se(audio(name: "Vending machine dispense", volume: 80)),
                        text("\\GBonus! Another Soda Pop dropped down."),
                      ],
                    ),
                  ),
                  jump_label("Start"),
                ],
                else: [
                  text("\\GYou have no room left in the Bag."),
                ],
              ),
              else: [
                text("\\GYou don't have enough money."),
              ],
            ),
          ],
          choice3: [
            *condition(
              gold: 350,
              operation: ">=",
              then: condition(
                script: "$bag.can_add?(:LEMONADE)",
                then: [
                  change_gold("-=", constant: 350),
                  script("$stats.drinks_bought += 1"),
                  script("$bag.add(:LEMONADE)"),
                  play_se(audio(name: "Vending machine dispense", volume: 80)),
                  text("\\GA Lemonade dropped down!"),
                  control_variables(v(1), random: 0..10),
                  *condition(
                    variable: v(1),
                    operation: "==",
                    constant: 0,
                    then: condition(
                      script: "$bag.can_add?(:LEMONADE)",
                      then: [
                        script("$stats.drinks_won += 1"),
                        script("$bag.add(:LEMONADE)"),
                        play_se(audio(name: "Vending machine dispense", volume: 80)),
                        text("\\GBonus! Another Lemonade dropped down."),
                      ],
                    ),
                  ),
                  jump_label("Start"),
                ],
                else: [
                  text("\\GYou have no room left in the Bag."),
                ],
              ),
              else: [
                text("\\GYou don't have enough money."),
              ],
            ),
          ],
          choice4: [
            text("\\GDecided not to buy a drink."),
          ],
        ),
      ],
    ),
  ),
)