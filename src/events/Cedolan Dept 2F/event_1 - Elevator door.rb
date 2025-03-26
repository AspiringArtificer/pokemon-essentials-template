event(
  id: 1,
  name: "Elevator door",
  x: 6,
  y: 1,
  page_0: page(
    graphic: graphic(
      name: "doors9",
    ),
    trigger: :player_touch,
    commands: [
      *comment(
        "This sets the player's current floor, so that the ",
        "elevator knows how many floors to go up/down (this ",
        "affects the wall animation).",
      ),
      control_variables(v(10), constant: 2),
      *move_route(
        this,
        route_play_se(audio(name: "Door slide")),
        route_wait(2),
        turn_left,
        route_wait(2),
        turn_right,
        route_wait(2),
        turn_up,
        route_wait(2),
        skippable: true,
      ),
      wait_completion,
      *move_route(
        player,
        through_on,
        move_up,
        through_off,
        skippable: true,
      ),
      wait_completion,
      change_transparent_flag(:transparent),
      script("Followers.follow_into_door"),
      wait_completion,
      *move_route(
        this,
        route_wait(2),
        turn_right,
        route_wait(2),
        turn_left,
        route_wait(2),
        turn_down,
        route_wait(2),
        skippable: true,
      ),
      wait_completion,
      change_tone(red: -255, green: -255, blue: -255, frames: 6),
      wait(8),
      change_transparent_flag(:normal),
      transfer_player(map: 20, x: 2, y: 5, direction: :up, fading: false),
      change_tone(red: 0, green: 0, blue: 0, frames: 6),
    ],
  ),
  page_1: page(
    switch1: s(22),
    graphic: graphic(
      name: "doors9",
    ),
    trigger: :autorun,
    commands: [
      *condition(
        script: "get_self.onEvent?",
        then: [
          change_transparent_flag(:transparent),
          script("Followers.hide_followers"),
          *move_route(
            this,
            route_play_se(audio(name: "Door slide")),
            route_wait(2),
            turn_left,
            route_wait(2),
            turn_right,
            route_wait(2),
            turn_up,
            route_wait(2),
            skippable: true,
          ),
          wait_completion,
          change_transparent_flag(:normal),
          *move_route(
            player,
            move_down,
            skippable: true,
          ),
          wait_completion,
          script("Followers.put_followers_on_player"),
          *move_route(
            this,
            turn_right,
            route_wait(2),
            turn_left,
            route_wait(2),
            turn_down,
            route_wait(2),
            skippable: true,
          ),
          wait_completion,
        ],
      ),
      script("setTempSwitchOn(\"A\")"),
    ],
  ),
)