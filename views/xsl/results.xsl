<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="results">
    <xsl:apply-templates />
</xsl:template>

<xsl:template match="teams">
    <p>
        <span>
            <a href="/matches/{@matchID}">Match actions</a>
        </span>
        <xsl:value-of select="homeTeam"/>
        <b>
            <xsl:value-of select="score"/>
        </b>
        Vs.
        <b>
            <xsl:value-of select="score"/>
        </b>
        <xsl:value-of select="awayTeam"/>
    </p>
</xsl:template>

</xsl:stylesheet>
