<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

    <p>
        Name: <xsl:value-of select="//player/name" />
    </p>
    <p>
        Appearances: <xsl:value-of select="//totals/appearances" />
            (starts <xsl:value-of select="//totals/started" />, 
                subtitute starts <xsl:value-of select="//totals/substitutedOn" />,
                dismissals <xsl:value-of select="//totals/dismissals" />)
    </p>    
    <hr/>
</xsl:template>

</xsl:stylesheet>
