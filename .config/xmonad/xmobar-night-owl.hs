Config
  { font = "Iosevka 9",
    additionalFonts = ["Iosevka Extrabold 10"],
    bgColor = "#011627",
    fgColor = "#d6deeb",
    border = BottomB,
    borderWidth = 0,
    borderColor = "#102a44",
    position = Top,
    lowerOnStart = True,
    overrideRedirect = True,
    commands =
      [ Run Date "%A, %d %b %Y <fc=#82aaff>%H:%M:%S</fc>" "date" 3,
        Run Kbd [("br", "BR"), ("us", "<fc=#ffeb95>US</fc>")],
        Run
          MultiCpu
          [ "--template",
            "<fn=1>CPU </fn><total>%",
            "--Low",
            "50", -- units: %
            "--High",
            "85", -- units: %
            "--low",
            "#ECEFF4",
            "--normal",
            "#ECEFF4",
            "--high",
            "#ef5350"
          ]
          10,
        Run Network "enp4s0" ["-t", "<fn=1>down</fn> <rx>kb <fn=1>up</fn> <tx>kb"] 10, -- Check your network interface with: ip link show
        Run Memory ["--template", "<fn=1>RAM </fn><usedratio>%"] 5,
        -- , Run Com "/bin/bash" ["-c", "XMgetvolume"]  "XVol" 10
        Run Com "pamixer" ["--get-volume"] "vol" 10,
        Run XPropertyLog "_XMONAD_TRAYPAD",
        Run StdinReader
      ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ <fn=1>layout</fn> %kbd% <fc=#c792ea>|</fc> %enp4s0% <fc=#c792ea>|</fc> %multicpu% <fc=#c792ea>|</fc> %memory% <fc=#c792ea>|</fc> <fn=1>vol</fn> %vol% <fc=#c792ea>|</fc> %date%%_XMONAD_TRAYPAD% "
  }
