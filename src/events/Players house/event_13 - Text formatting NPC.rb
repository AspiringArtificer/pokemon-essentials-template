event(
  id: 13,
  name: "Text formatting NPC",
  x: 10,
  y: 7,
  page_0: page(
    graphic: graphic(
      name: "NPC 07",
      direction: :left,
    ),
    commands: [
      label("Start"),
      text("Choose a text option."),
      *show_choices(
        choices: ["Text colours", "Text formatting", "Insert text/in-line graphics", "Graphic and info windows"],
        cancellation: 0,
        choice1: [
          *text(
            "\\bThis is the text of a male character.",
            "\\rThis is the text of a female character.",
          ),
          *text(
            "\\pgThis text is the colour of the player's gender. ",
            "\\pogThis text is the colour of the opposite gender to ",
            "the player.",
          ),
          *text(
            "\\c[0]Default, \\c[1]blue, \\c[2]red, \\c[3]green, \\c[4]cyan, ",
            "\\c[5]magenta, \\c[6]yellow, \\c[7]grey, \\c[8]white, ",
            "\\c[9]purple, \\c[10]orange, \\c[11]dark, \\c[12]light.",
          ),
          jump_label("Start"),
        ],
        choice2: [
          *text(
            "<b>Bold text,</b> <i>italic text,</i> <u>underlined ",
            "text,</u> <s>strikethrough text,</s> <outln>outline ",
            "text,</outln> <outln2>thicker outline text.</outln2>",
          ),
          *text(
            "<fn=Power Clear Bold>Power Clear Bold text,</fn> ",
            "<fs=25>size 25 text,</fs> <fs=40>size 40 text,</fs> ",
            "<o=128>half-transparent text.</o>",
          ),
          *text(
            "This is a line\\n break. Text is \\n<r>right-aligned until ",
            "next line\\n break. Text is <ac>centred</ac> here. ",
            "Text is <ar>right-aligned</ar> here.",
          ),
          jump_label("Start"),
        ],
        choice3: [
          *text(
            "\\PN is the player's name, \\PM is the player's money, ",
            "\\v[12] is the content of Game Variable 12.",
          ),
          *text(
            "This is <icon=bagPocket3> bagPocket3 from the ",
            "folder Graphics/Icons. Icons shown this ",
            "way are not padded.",
          ),
          jump_label("Start"),
        ],
        choice4: [
          text("\\GThe money window is shown."),
          text("\\CNThe coins window is shown."),
          *text(
            "\\G\\CNThe money and coins windows are both ",
            "shown. The coins window must be shown second.",
          ),
          *text(
            "\\f[introBoy]The introBoy picture from the ",
            "Graphics/Pictures folder is shown.",
          ),
          *text(
            "\\ff[introBoy]The introBoy picture is shown again, but ",
            "cropped to the top-left 96x96 pixels of it.",
          ),
          jump_label("Start"),
        ],
      ),
      *show_choices(
        choices: ["Message box appearance", "Text speed and audio", "Audio", "Cancel"],
        cancellation: 4,
        choice1: [
          *text(
            "\\w[signskin]The windowskin has changed to ",
            "\"signskin\" here.",
          ),
          *text(
            "\\l[3]This message box has 3 lines to it rather than 2, ",
            "so more text can be shown at once. Lorem ipsum ",
            "dolor sit amet, consectetur adipisicing elit.",
          ),
          text("\\wuThis message box is at the top."),
          text("\\wmThis message box is in the middle."),
          *text(
            "\\wuThis message box is\\wm jumping around the ",
            "screen\\wd in a rather off-putting way.",
          ),
          text("\\opThis message box slides on-screen at the start."),
          text("\\clThis message box slides off-screen at the end."),
          jump_label("Start"),
        ],
        choice2: [
          text("\\ts[]This text appeared instantly!"),
          text("\\ts[5]This text is slow to appear."),
          *text(
            "Slow text speed is 4, normal speed is 2, fast speed ",
            "is 1. It takes this many 1/80ths of a second for the ",
            "next character in a message to appear.",
          ),
          jump_label("Start"),
        ],
        choice3: [
          *text(
            "\\se[Pkmn move learnt]Sound effect \"Pkmn move ",
            "learnt\" was played.",
          ),
          *text(
            "Music effect \"Item get\" will be played.",
            "\\me[Item get]",
          ),
          jump_label("Start"),
        ],
      ),
      *text(
        "A complete list of all message options is available on ",
        "the wiki.",
      ),
    ],
  ),
)