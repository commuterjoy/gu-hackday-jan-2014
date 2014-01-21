<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- imports -->
<xsl:import href="appearances.xsl"/>
<xsl:import href="player.xsl"/>

<xsl:output method="html"/>

<!-- entry point -->
<xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <html>
        <head>
            <meta charset="utf-8" />
            <title>The Guardian</title>
            <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link rel="stylesheet" type="text/css" href="/style.css" />
        </head>
        <body>
            <h1>PA Football API <i>FactBot</i></h1>
            <xsl:apply-templates />
        </body>
    </html>
</xsl:template>

</xsl:stylesheet>
