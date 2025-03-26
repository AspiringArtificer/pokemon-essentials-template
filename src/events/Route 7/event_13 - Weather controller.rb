event(
  id: 13,
  name: "Weather controller",
  x: 49,
  y: 20,
  page_0: page(
    graphic: graphic(
      name: "NPC 21",
    ),
    commands: [
      *text(
        "\\bI can control the weather. Which weather would ",
        "you like to see?",
      ),
      *show_choices(
        choices: ["None", "Rain", "Heavy rain", "Storm"],
        cancellation: 0,
        choice1: [
          weather_effect(weather: :none, power: 5, frames: 20),
        ],
        choice2: [
          weather_effect(weather: :rain, power: 9, frames: 20),
        ],
        choice3: [
          comment("Heavy rain is like storm but with no lightning flashes."),
          *script(
            <<~'CODE'
            $game_screen.weather(
              :HeavyRain, 9, 20
            )
            CODE
          ),
        ],
        choice4: [
          weather_effect(weather: :storm, power: 9, frames: 20),
        ],
      ),
      *show_choices(
        choices: ["Snow", "Blizzard", "Sandstorm"],
        cancellation: 0,
        choice1: [
          weather_effect(weather: :snow, power: 9, frames: 20),
        ],
        choice2: [
          *script(
            <<~'CODE'
            $game_screen.weather(
              :Blizzard, 9, 20
            )
            CODE
          ),
        ],
        choice3: [
          *script(
            <<~'CODE'
            $game_screen.weather(
              :Sandstorm, 9, 20
            )
            CODE
          ),
        ],
      ),
      *show_choices(
        choices: ["Sun", "Fog"],
        cancellation: 5,
        choice1: [
          script("$game_screen.weather(:Sun, 9, 20)"),
          *text(
            "\\bThis weather can occur even at night, but doesn't ",
            "negate the day/night shading. It's better if you don't ",
            "use it.",
          ),
        ],
        choice2: [
          script("$game_screen.weather(:Fog, 9, 20)"),
        ],
      ),
      *text(
        "\\bNote that the weather metadata for this map is set, ",
        "even though its probability is 0. This prevents the ",
        "weather from lingering when you leave this map.",
      ),
    ],
  ),
)