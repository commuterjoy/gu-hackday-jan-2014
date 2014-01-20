<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>
<xsl:template match="/">
    <style>
        .goals { color: #ccc; }
        [class=~goals-] { background-color: #ccff33; color: #333; } /* 3+ goals */ 
        .goals-1 { color: #33aa00; }
        .goals-2 { color: #33dd00; }
        .goals-3 { background-color: #ccff33; color: #333; }
    </style>
    <xsl:apply-templates/>
    <hr/>
</xsl:template>

<!-- goals -->
<xsl:template match="match">
    <p>
        <big class="goals goals-{count(events/goals/goal)}">
            <xsl:value-of select="count(events/goals/goal)"/> goals
        </big>
        <xsl:text> </xsl:text>

        <xsl:value-of select="events/substitution/substitution[playerOff/@playerID='325121']"/>

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
