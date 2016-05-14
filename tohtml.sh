#!/bin/dash

CONTENT=$(pandoc -t html5 $1)

TITLE=$2

cat << EOF
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" type="text/css" href="/home/fuyuki/src/web/css/style.css">
        <title>$TITLE</title>
    </head>
    <body>
        <main>

            <br><br><br>
            <h1>$TITLE</h1>

            $CONTENT

        </main>
    </body>
</html>
EOF
