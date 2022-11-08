#!/bin/sh

: "${HTDOCS:=/www}"

html_escape() {
    var="$1"
    var="${var//&/&amp;}"
    var="${var//</&lt;}"
    var="${var//>/&gt;}"
    var="${var//\"/&quot;}"
    var="${var//\'/&apos;}"
    echo "${var}"
}

if [[ -n "$(type -p base64)" ]] ; then
  base64enc() {
    base64 -w 0
  }
elif [[ -n "$(type p openssl)" ]] ; then
  base64enc() {
    openssl enc -A -base64
  }
else
  echo "Missing base64 (coreutils-base64 or openssl) for encoding."
fi

html_header() {
    cat <<__EOF__
<!DOCTYPE html>
<html lang="en-US">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="refresh" content="360" />
  <title>Wifi Access</title>
</head>
<body bgcolor="#000">
  <div style='text-align:center;color:#fff;font-size:28px;font-weight:500;font-family: "LM Mono Proportional","Courier New",Courier,monospace;'>
    <h1 style="margin-block-end: unset;">WIFI ACCESS</h1>
    <div style="display: flex; flex-wrap: wrap; justify-content: center">
__EOF__
}

html_wifi() {
    cat <<__EOF__
      <div style="margin: 4%; flex: 1 1 0; word-break: break-all;">
        <p style="margin-block-start: unset";>SSID: <b>$(html_escape "${ssid}")</b></p>
        <p>PSK: <b>$(html_escape "${psk}")</b></p>
        <img style="width: min(80vw,40vh,20em)" src="data:image/svg+xml;base64,$(echo "WIFI:T:WPA;S:${ssid};P:${psk};;" | qrencode --svg-path -t SVG -o - | base64enc)"/>
      </div>
__EOF__
}

html_footer() {
    cat <<__EOF__
    </div>
  </div>
</body>
</html>
__EOF__
}

{
    html_header
    for wifi in wifinet1 wifinet2; do
        ssid="$(uci get wireless."$wifi".ssid)"
        psk="$(uci get wireless."$wifi".key)"
        html_wifi $wifi
    done
    html_footer
} > ${HTDOCS}/wifi.html

# vim: et sw=2 ts=2
