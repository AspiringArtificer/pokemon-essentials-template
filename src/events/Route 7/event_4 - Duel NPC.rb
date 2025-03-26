event(
  id: 4,
  name: "Duel NPC",
  x: 34,
  y: 14,
  page_0: page(
    graphic: graphic(
      name: "trainer_BLACKBELT",
    ),
    commands: [
      text("\\bHaiiiii-yaaaaaah!"),
      memorize_bgm_bgs,
      fade_out_bgm(seconds: 1),
      wait(20),
      play_bgm(audio(name: "Battle trainer")),
      *comment(
        "Duel Minigame, based on the version written by Alael, ",
        "modified for Pokémon Essentials.",
      ),
      *comment(
        "The duel takes place in a row of 4 tiles, with the ",
        "player and opponent using the centre two. Make ",
        "sure you have enough space.",
      ),
      *comment(
        "3 texts for defense, 3 for precise attacks, 3 for fierce ",
        "attacks, 3 for special attacks.",
      ),
      script("$speeches = []"),
      *script(
        <<~'CODE'
        $speeches.push(
          _I("I shall block all your 
        attacks!"),
          _I("Nothing can pierce my armor!"),
          _I("Behold my dodging skills!")
        )
        CODE
      ),
      *script(
        <<~'CODE'
        $speeches.push(
         _I("I'll show you my fighting 
        skills!"),
          _I("Awe at the perfection of my 
        skills!"),
          _I("I'll deliver a perfect blow!")
        )
        CODE
      ),
      *script(
        <<~'CODE'
        $speeches.push(
          _I("Feel my power!"),
          _I("AAAAHHHH!"),
          _I("I'll attack with all my 
        strength!")
        )
        CODE
      ),
      *script(
        <<~'CODE'
        $speeches.push(
          _I("Face my secret technique!"),
          _I("This is my secret technique!"),
          _I("Evil Blade Strike!")
        )
        CODE
      ),
      *comment(
        "The opponent in a duel needs a trainer type to be ",
        "defined in trainertypes.txt. This is used to display a ",
        "name and graphic for the opponent.",
        "The opponent does NOT need to appear in ",
        "trainers.txt, though.",
      ),
      *condition(
        script: "pbDuel(:BLACKBELT, \"Dan\", get_self, $speeches)",
        then: [
          fade_out_bgm(seconds: 1),
          wait(20),
          restore_bgm_bgs,
          text("\\bYou won, good job."),
        ],
        else: [
          fade_out_bgm(seconds: 1),
          wait(20),
          restore_bgm_bgs,
          text("You lost, too bad."),
        ],
      ),
    ],
  ),
)