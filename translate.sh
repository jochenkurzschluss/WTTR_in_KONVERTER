#!/bin/bash
#
# Dies ist ein kleines Übersetzungs script von DO2ITH für curl 'wttr.in'
#
#
#
# PATH für Cron-Umgebung setzen
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#
# Stadt der Wtterinformationen die ausgegeben werden
#
	CITY='Eschershausen'
#
# Pfad zur WX Datei und ArbeitsVariabeln
#
	WORK=""
	WXFILE_FINAL='/usr/local/tnn/textcmd/wx'
	UPDATE=$(date)
	INFO=$(echo "Leztes Update der Wetterdaten")
#
# Pattern wie der string von wttr.in gelanden werden
#
# curl wttr.in/:help
# Usage:
#
#    $ curl wttr.in          # current location
#    $ curl wttr.in/muc      # weather in the Munich airport
#
#Supported location types:
#
#    /paris                  # city name
#    /~Eiffel+tower          # any location (+ for spaces)
#    /Москва                 # Unicode name of any location in any language
#    /muc                    # airport code (3 letters)
#    /@stackoverflow.com     # domain name
#    /94107                  # area codes
#    /-78.46,106.79          # GPS coordinates
#
# Moon phase information:
#
#    /moon                   # Moon phase (add ,+US or ,+France for these cities)
#    /moon@2016-10-25        # Moon phase for the date (@2016-10-25)
#
# Units:
#
#    m                       # metric (SI) (used by default everywhere except US)
#    u                       # USCS (used by default in US)
#    M                       # show wind speed in m/s
#
# View options:
#
#    0                       # only current weather
#    1                       # current weather + today's forecast
#    2                       # current weather + today's + tomorrow's forecast
#    A                       # ignore User-Agent and force ANSI output format (terminal)
#    d                       # restrict output to standard console font glyphs
#    F                       # do not show the "Follow" line
#    n                       # narrow version (only day and night)
#    q                       # quiet version (no "Weather report" text)
#    Q                       # superquiet version (no "Weather report", no city name)
#    T                       # switch terminal sequences off (no colors)
#
# PNG options:
#
#    /paris.png              # generate a PNG file
#    p                       # add frame around the output
#    t                       # transparency 150
#    transparency=...        # transparency from 0 to 255 (255 = not transparent)
#    background=...          # background color in form RRGGBB, e.g. 00aaaa
#
# Options can be combined:
#
#    /Paris?0pq
#    /Paris?0pq&lang=fr
#    /Paris_0pq.png          # in PNG the file mode are specified after _
#    /Rome_0pq_lang=it.png   # long options are separated with underscore
#
# Localization:
#
#    $ curl fr.wttr.in/Paris
#    $ curl wttr.in/paris?lang=fr
#    $ curl -H "Accept-Language: fr" wttr.in/paris
#
# Supported languages:
#
#    am ar af be bn ca da de el et fr fa gl hi hu ia id it lt mg nb nl oc pl pt-br ro ru ta tr th uk vi zh-cn zh-tw (supported)
#    az bg bs cy cs eo es eu fi ga hi hr hy is ja jv ka kk ko ky lv mk ml mr nl fy nn pt pt-br sk sl sr sr-lat sv sw te uz zh zu he (in progress)
#
# Special URLs:
#
#    /:help                  # show this page
#    /:bash.function         # show recommended bash function wttr()
#    /:translation           # show the information about the translators
#
# Das Pattern (Also die Menge und Art der neuen Informationen) definieren
	PATTERN='d&T&F&n&lang=de'
#
# WX Datei Löschen damit sie neu erstellt wird
#
	/bin/rm -f $WXFILE_FINAL
	/bin/touch $WXFILE_FINAL
#
# Daten wie konfiguriert holen
#
	WORK=$(/bin/curl 'wttr.in/'$CITY'?'$PATTERN)
#
#
# Daten nach unklaren Symbolen filtern
WORK=$(/bin/echo "$WORK" | /bin/sed \
-e 's/[─┴│┼┘┐├┤┌└┬°\t]/ /g' \
-e 's/[’]/:/g' \
-e 's/[‘]/,/g' \
-e 's/[→]/>/g' \
-e 's/[╭]/|/g' \
-e 's/[╮]/|/g' \
-e 's/[←]/</g' \
-e 's/[―]/-/g' \
-e 's/[ä]/ae/g' \
-e 's/[ö]/oe/g' \
-e 's/[ü]/ue/g' \
-e 's/[Ä]/Ae/g' \
-e 's/[Ö]/Oe/g' \
-e 's/[Ü]/Ue/g')
#
#
#
# Konvertierte Variable Ausgeben zu debug zwecken
#	/bin/echo $WORK
#	/bin/echo $INFO
#	/bin/echo $UPDATE
#
#
# Finale Ausgabe 
/bin/echo "$WORK" > "$WXFILE_FINAL"
/bin/echo "$INFO" >> "$WXFILE_FINAL"
/bin/echo "$UPDATE" >> "$WXFILE_FINAL"
# Schluss
