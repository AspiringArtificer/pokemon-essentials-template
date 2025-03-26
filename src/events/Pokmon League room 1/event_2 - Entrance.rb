event(
  id: 2,
  name: "Entrance",
  x: 6,
  y: 12,
  page_0: page(
    trigger: :event_touch,
    commands: [
      *move_route(
        player,
        route_wait(8),
        through_on,
        move_up,
        move_up,
        move_up,
        move_up,
        move_up,
        through_off,
        skippable: true,
      ),
      wait_completion,
      play_se(audio(name: "Door enter")),
      script("setTempSwitchOn(\"A\")"),
    ],
  ),
  page_1: page(
    switch1: s(21),
    graphic: graphic(
      name: "e4wall",
    ),
  ),
)