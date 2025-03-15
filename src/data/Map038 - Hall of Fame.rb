# Ingido Plateau outside (35)
#   Hall of Fame (38)
map(
  tileset_id: 14,
  autoplay_bgm: true,
  bgm: audio(volume: 80),
  events: [

    event(
      id: 1,
      name: "Hall of Fame autorun",
      x: 2,
      y: 13,
      page_0: page(
        trigger: :autorun,
        commands: [
          *comment(
            "Set various switches and counters.",
            "Also reset stationary Pokémon that reappear each ",
            "time the player defeats the Elite Four.",
          ),
          control_switches(s(12), :ON),
          control_variables(v(13), "+=", constant: 1),
          script("$stats.hall_of_fame_entry_count += 1"),
          control_switches(s(56), :ON),
          *comment(
            "Heal the player's party, and give the party Pokémon ",
            "ribbons for defeating the Elite Four.",
          ),
          recover_all(0),
          *script(
            <<~'CODE'
            $player.pokemon_party.each do |pkmn|
              pkmn.giveRibbon(:CHAMPION)
            end
            CODE
          ),
          *comment(
            "Make the player walk up to the recording station, ",
            "and fade to black.",
          ),
          wait(8),
          *move_route(
            player,
            turn_up,
            move_up,
            move_up,
            move_up,
            move_up,
            move_up,
            move_up,
            move_up,
            skippable: true,
          ),
          wait_completion,
          wait(8),
          change_tone(red: -255, green: -255, blue: -255, frames: 6),
          wait(8),
          comment("Record an entry in the Hall of Fame."),
          script("$stats.set_time_to_hall_of_fame"),
          script("pbHallOfFameEntry"),
          comment("Play the credits."),
          script("$scene = Scene_Credits.new"),
          wait(8),
          comment("Return the player to the entrance of the League."),
          transfer_player(map: 36, x: 13, y: 12, direction: :down, fading: false),
          change_tone(red: 0, green: 0, blue: 0, frames: 6),
        ],
      ),
    ),

  ],
  data: table(
    x: 20,
    y: 15,
    z: 3,
    data: [
      1400, 1401, 1402, 1403, 1404, 1405, 1406, 1407, 1440, 1401, 1442,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1408, 1409, 1410, 1411, 1412, 1413, 1414, 1415, 1448, 1409, 1450,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1416, 1417, 1418, 1419, 1420, 1421, 1422, 1423, 1456, 1457, 1458,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1425, 1439, 1427, 1428, 1429, 1430, 1431, 1439, 1465, 1466,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1447, 1426, 1436, 1437, 1438, 1426, 1447, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1455, 1426, 1426, 1426, 1426, 1426, 1455, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1439, 1426, 1444, 1445, 1446, 1426, 1439, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1447, 1426, 1452, 1453, 1454, 1426, 1447, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1455, 1426, 1460, 1461, 1462, 1426, 1455, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1439, 1426, 1426, 1426, 1426, 1426, 1439, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1424, 1426, 1447, 1426, 1426, 1426, 1426, 1426, 1447, 1426, 1474,  384,  384,  384,  384,  384,  384,  384,  384,  384,
      1432, 1426, 1455, 1426, 1426, 1426, 1426, 1426, 1455, 1426, 1482,  384,  384,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384, 1468, 1426, 1470,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
       384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
         0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    ],
  ),
)
