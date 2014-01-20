<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="playerAppearances">

    <style>
        @import url('/style.css');
    </style>

    <h2 class="sub">Fact me</h2>

    <p class="card">
        <strong><xsl:value-of select="//player/name" /></strong> has made
        <xsl:value-of select="//totals/appearances" /> appearances this season.
            He started <xsl:value-of select="//totals/started" /> matches, 
                 and came off the bench <xsl:value-of select="//totals/substitutedOn" /> times.
    </p>

</xsl:template>

</xsl:stylesheet>
