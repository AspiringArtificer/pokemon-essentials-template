event(
  id: 2,
  name: "North door right",
  x: 27,
  y: 6,
  page_0: page(
    graphic: graphic(
      pattern: 3,
    ),
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      transfer_player(map: 30, x: 5, y: 8, direction: :up, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
  page_1: page(
    switch1: s(22),
    graphic: graphic(
      pattern: 3,
    ),
    trigger: :autorun,
    commands: [
      *condition(
        script: "get_self.onEvent?",
        then: [
          script("Followers.hide_followers"),
          *move_route(
            player,
            route_play_se(audio(name: "Door exit", volume: 80)),
            move_down,
            skippable: true,
          ),
          wait_completion,
          script("Followers.put_followers_on_player"),
        ],
      ),
      script("setTempSwitchOn(\"A\")"),
    ],
  ),
)