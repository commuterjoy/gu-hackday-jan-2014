<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>
<xsl:template match="/">
    <h2 class="sub">Form</h2>

    <p class="card">
        He's scored <i><xsl:value-of select="count(//match[position() &lt; 5]/events/goals/goal)"/></i> goals
        in the last five matches he's played and <i><xsl:value-of select="count(//match[position() &gt; 5 and position() &lt; 11]/events/goals/goal)"/></i> 
        in the five before that. 
    </p>
</xsl:template>

<!-- goals -->
<xsl:template match="match">
    <p>
        <big class="goals goals-{count(events/goals/goal)}">
            <xsl:value-of select="count(events/goals/goal)"/> goals
        </big>
        <xsl:text> </xsl:text>

        <xsl:value-of select="@date"/>
        <xsl:text> </xsl:text>

        <a href="/api/football/match/actions/dxj451p9/{@matchID}?xsl=actions.xsl">
            <big><xsl:value-of select="homeTeam/name"/></big>
            <xsl:text> </xsl:text>
            <strong>
                <xsl:value-of select="homeTeam/score"/>
            </strong>
            v
            <strong>
                <xsl:value-of select="awayTeam/score"/>
            </strong>
            <xsl:text> </xsl:text>
            <big><xsl:value-of select="awayTeam/name"/></big>
        </a> 
        
        <xsl:text> </xsl:text>
        <i><xsl:value-of select="competition"/> (<xsl:value-of select="round"/>)</i>
    </p>
</xsl:template>

<xsl:template match="text()|homeTeam|awayTeam|bookings|dismissals|substitutions|other|competition|stage|round"></xsl:template>
    
<xsl:template match="goals">
    <p>
        Goals: <xsl:value-of select="count(goal)"/>
    </p>
</xsl:template>

</xsl:stylesheet>
