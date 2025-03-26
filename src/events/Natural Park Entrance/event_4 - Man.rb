event(
  id: 4,
  name: "Man",
  x: 6,
  y: 2,
  page_0: page(
    graphic: graphic(
      name: "NPC 01",
    ),
    commands: condition(
      script: "pbIsWeekday(1, 2, 4, 6)",
      then: [
        *comment(
          "Today is Tuesday (2), Thursday (4) or Saturday (6), ",
          "and the Bug Contest is running today. The weekday's ",
          "name is put in Game Variable 1.",
        ),
        *condition(
          script: "pbBugContestState.pbContestHeld?",
          then: [
            *text(
              "\\bWe hope you'll take part in a Bug-Catching Contest ",
              "in the future!",
            ),
            exit_event_processing,
          ],
        ),
        text("\\bToday's \\v[1]."),
        text("\\bThat means the Bug-Catching Contest is on today."),
        text("\\bThe rules are simple."),
        *text(
          "\\bUsing one of your Pokémon, catch a Bug-type ",
          "Pokémon to be judged.",
        ),
        text("\\bWould you like to give it a try?"),
        *show_choices(
          choices: ["Yes", "No"],
          cancellation: 2,
          choice1: [
            *condition(
              script: "pbBoxesFull?",
              then: [
                text("\\bSorry, your PC boxes are full."),
                exit_event_processing,
              ],
            ),
            *text(
              "\\bYou are only allowed to take 1 Pokémon into the ",
              "Contest.",
            ),
            *text(
              "\\bPlease choose which Pokémon you want to enter ",
              "with.",
            ),
            *comment(
              "Opens a screen for choosing an able Pokémon (i.e. a ",
              "non-egg, non-fainted Pokémon).",
              "The party index of the chosen Pokémon is put in ",
              "Game Variable 1, and the chosen Pokémon's name is ",
              "put in Game Variable 2.",
            ),
            script("pbChooseAblePokemon(1, 2)"),
            *condition(
              variable: v(1),
              operation: "<",
              constant: 0,
              then: [
                comment("Cancelled choosing a Pokémon."),
                text("\\bOK. We hope you'll take part in the future."),
                exit_event_processing,
              ],
              else: [
                text("\\bYou will be entering with \\v[2], then."),
                text("\\bWe'll hold your other Pokémon while you compete."),
                *text(
                  "\\PN's Pokémon were left with the Contest ",
                  "Helper.\\se[Pkmn exp full]\\wtnp[20]",
                ),
                text("\\bHere are the Sport Balls for the Contest."),
                text("\\PN received 20 Sport Balls.\\me[Item get]\\wtnp[40]"),
                *text(
                  "\\bThe person who gets the strongest bug Pokémon is ",
                  "the winner.",
                ),
                text("\\bYou have 20 minutes."),
                text("\\bIf you run out of Sport Balls, you're done."),
                *text(
                  "\\bYou can keep the last Pokémon you catch as your ",
                  "own.",
                ),
                *text(
                  "\\bGo out and catch the strongest Bug-type Pokémon ",
                  "you can find!",
                ),
                *comment(
                  "- Set the map ID and X/Y coordinates of the spot the ",
                  "player is teleported to at the end for judging.",
                  "- Set the map IDs of reception maps which, if you ",
                  "enter them, will not immediately end the contest ",
                  "(those maps should prompt the player to go back into ",
                  "the contest's map or to end the contest).",
                ),
                *comment(
                  "- Set the map ID of the map where the contest takes ",
                  "place (there can only be one). NPC participants have ",
                  "random wild Pokémon found on this map.",
                  "- Set the party index of the Pokémon chosen by the ",
                  "player to use in the contest.",
                  "- Start the contest with 20 Sport Balls.",
                ),
                *script(
                  <<~'CODE'
                  contest = pbBugContestState
                  contest.pbSetJudgingPoint(30, 5, 6)
                  contest.pbSetReception(
                    "BugContestReception"
                  )
                  contest.pbSetContestMap(
                    "BugContest"
                  )
                  contest.pbSetPokemon(pbGet(1))
                  contest.pbStart(20)
                  CODE
                ),
                *move_route(
                  player,
                  through_on,
                  move_down,
                  move_right,
                  move_right,
                  move_right,
                  move_right,
                  move_right,
                  change_opacity(0),
                  through_off,
                ),
                wait_completion,
                play_se(audio(name: "Door exit", volume: 80)),
                change_tone(red: -255, green: -255, blue: -255, frames: 6),
                wait(8),
                *move_route(
                  player,
                  change_opacity(255),
                ),
                transfer_player(map: 28, x: 8, y: 24, direction: :retain, fading: false),
                change_tone(red: 0, green: 0, blue: 0, frames: 6),
                exit_event_processing,
              ],
            ),
          ],
          choice2: [
            text("\\bOK. We hope you'll take part in the future."),
          ],
        ),
      ],
      else: [
        comment("Today is not a Contest day."),
        *text(
          "\\bWe hold contests regularly in the Park. You should ",
          "give it a shot.",
        ),
      ],
    ),
  ),
  page_1: page(
    switch1: s(26),
    graphic: graphic(
      name: "NPC 01",
    ),
    trigger: :autorun,
    commands: [
      *comment(
        "Event page called when the contest is still in ",
        "progress.",
      ),
      wait(20),
      *text(
        "\\bYou still have some time left. Do you want to finish ",
        "now?",
      ),
      *show_choices(
        choices: ["Yes", "No"],
        cancellation: 2,
        choice1: [
          *text(
            "\\bOK. Please wait in the pavillion for the ",
            "announcement of the winners.",
          ),
          script("pbBugContestState.pbStartJudging"),
        ],
        choice2: [
          text("\\bOK. Please go back outside and finish up."),
          *move_route(
            player,
            turn_right,
            route_wait(4),
            change_opacity(0),
          ),
          wait_completion,
          play_se(audio(name: "Door exit", volume: 80)),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          *move_route(
            player,
            change_opacity(255),
          ),
          transfer_player(map: 28, x: 8, y: 24, direction: :retain, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ],
  ),
)