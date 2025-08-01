Config { font = "Iosevka 9"
       , additionalFonts = ["Iosevka Extrabold 10"]
       , bgColor = "#2E3440"
       , fgColor = "#D8DEE9"
       , border           = BottomB
       , borderWidth      = 0
       , borderColor      = "#5E81AC"
       , position = Top
       , lowerOnStart = True
       , commands = [
                     Run Date "%A, %d %b %Y <fc=#81A1C1>%H:%M:%S</fc>" "date" 3
                     , Run Kbd      [ ("br", "BR"), ("us", "<fc=#EBCB8B>US</fc>")]
                     , Run MultiCpu [ "--template" , "<fn=1>CPU </fn><total>%"
                                                , "--Low"      , "50"        -- units: %
                                                , "--High"     , "85"        -- units: %
                                                , "--low"      , "#ECEFF4"
                                                , "--normal"   , "#ECEFF4"
                                                , "--high"     , "#BF616A"
                                                ] 10
                     , Run Network "enp0s3" ["-t", "<fn=1>down</fn> <rx>kb <fn=1>up</fn> <tx>kb"] 10 -- Check your network interface with: ip link show
                     , Run Memory   [ "--template" ,"<fn=1>RAM </fn><usedratio>%"] 5
                     -- , Run Com "/bin/bash" ["-c", "XMgetvolume"]  "XVol" 10
                     , Run Com "pamixer" ["--get-volume"]  "vol" 10
                     , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ <fn=1>layout</fn> %kbd% <fc=#4C566A>|</fc> %enp0s3% <fc=#4C566A>|</fc> %multicpu% <fc=#4C566A>|</fc> %memory% <fc=#4C566A>|</fc> <fn=1>vol</fn> %vol% <fc=#4C566A>|</fc> %date% "
       }
