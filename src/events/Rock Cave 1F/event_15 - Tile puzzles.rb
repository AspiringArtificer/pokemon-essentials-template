event(
  id: 15,
  name: "Tile puzzles",
  x: 24,
  y: 8,
  page_0: page(
    commands: [
      text("Which tile puzzle do you want to play?"),
      *show_choices(
        choices: ["Alph", "Alph Rotator", "Mystic Square", "Tile Swap"],
        cancellation: 0,
        choice1: [
          *comment(
            "A jigsaw puzzle. All tiles start in trays on either side ",
            "of the grid.",
          ),
          *condition(
            script: "pbTilePuzzle(1, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
        choice2: [
          *comment(
            "A jigsaw puzzle. All tiles start in trays on either side ",
            "of the grid. Each tile can be rotated.",
          ),
          *condition(
            script: "pbTilePuzzle(2, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
        choice3: [
          *comment(
            "Also known as the 15 puzzle. All tiles (except for one) ",
            "start in random places in the grid. Use the empty tile ",
            "space to slide tiles around and rearrange them to ",
            "create the picture. The missing tile is the bottom right ",
            "one in the completed picture.",
          ),
          *condition(
            script: "pbTilePuzzle(3, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
        choice4: [
          *comment(
            "All tiles start in random places in the grid. By choosing ",
            "and swapping pairs of adjacent tiles, unscramble the ",
            "picture.",
          ),
          *condition(
            script: "pbTilePuzzle(4, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
      ),
      *show_choices(
        choices: ["Tile Swap Rotator", "Rubik's Square", "Star Rotator", "Cancel"],
        cancellation: 4,
        choice1: [
          *comment(
            "All tiles start in random places in the grid. By choosing ",
            "and swapping pairs of adjacent tiles, unscramble the ",
            "picture. Each tile can be rotated.",
          ),
          *condition(
            script: "pbTilePuzzle(5, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
        choice2: [
          *comment(
            "All tiles start in random places in the grid. Slide a ",
            "whole row of tiles left/right, or a whole column of tiles ",
            "up/down at a time. The tile that falls off one side of ",
            "the grid appears on the other side. Unscramble the ",
            "picture.",
          ),
          *condition(
            script: "pbTilePuzzle(6, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
        choice3: [
          *comment(
            "All tiles start in their proper places in the grid, but are ",
            "randomly rotated. When one tile is rotated, all tiles ",
            "touching one of its sides are also rotated.",
          ),
          *condition(
            script: "pbTilePuzzle(7, \"Kabuto\")",
            then: [
              text("Puzzle solved!"),
            ],
            else: [
              text("Gave up..."),
            ],
          ),
        ],
      ),
    ],
  ),
)