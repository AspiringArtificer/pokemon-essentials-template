event(
  id: 2,
  name: "Cave entrance",
  x: 55,
  y: 16,
  page_0: page(
    graphic: graphic(
      pattern: 3,
    ),
    trigger: :player_touch,
    commands: [
      play_se(audio(name: "Door exit", volume: 80)),
      change_tone(red: 255, green: 255, blue: 255, gray: 255, frames: 6),
      wait(8),
      script("pbCaveEntrance"),
      transfer_player(map: 49, x: 19, y: 20, direction: :retain, fading: false),
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
            move_right,
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