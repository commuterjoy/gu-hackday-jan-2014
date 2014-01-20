<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
            <script src="/list.min.js"></script>
        </head>
        <body>
            <h1>PA Football API <i>FactBot</i></h1>
            <xsl:apply-templates />
            <script>
                var options = {
                    valueNames: [ 'appearances', 'minutesOnPitch' ]
                };
                var hackerList = new List('eaindex', options);
            </script>
        </body>
    </html>
</xsl:template>

<xsl:template match="statsSummary">
    <ul>
        <xsl:apply-templates />
    </ul>
</xsl:template>

<xsl:template match="statsType">
    <li>
        <xsl:value-of select="description"/>
        -
        <xsl:value-of select="stat/total"/>
    </li>
</xsl:template>

<!-- eaindex -->

<xsl:template match="index">
    <table border="1" id="eaindex">
        <tbody class="list">
            <tr>
                <td></td>
                <xsl:apply-templates select="player[position() = 1]/index/summary/*" mode="th" />
            </tr>
            <xsl:apply-templates />
        </tbody>
    </table>
</xsl:template>

<xsl:template match="summary/*" mode="th">
    <td class="{local-name()}"><xsl:value-of select="local-name()"/></td>
</xsl:template>

<xsl:template match="player">
        <tr>
            <td>
                <a href="/players/{@playerID}">
                    <xsl:value-of select="name"/>
                </a> (<xsl:value-of select="index/finalIndex"/>)
            </td>
            <xsl:apply-templates select="index/summary/*"/>
        </tr>
</xsl:template>


<xsl:template match="summary/*">
    <td>
        <xsl:value-of select="."/>
    </td>
</xsl:template>


</xsl:stylesheet>
