<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:param name="title"/>

<xsl:template match="teams|matchMinutes|isResult"/>

<xsl:template match="/">
  <html>
      <head>
          <style>
            a { text-decoration: none; }
            table { width: 100%; }
            td { padding: 2px; border-bottom: 1px solid #999; }
            td { font-size: 11px; font-family: arial; }
            ul, li { margin-left: 0; padding-left: 0; list-style-type: none; }
            small { font-size: 10px; }
        </style>
      </head>
      <body>
          <h1>Man City Vs. Blackburn (FA Cup)</h1>
          <xsl:apply-templates/>
      </body>
  </html>
</xsl:template>


<xsl:template match="actions">
    <table cellspacing="0" cellpadding="0">
        <tr>
            <td>type</td>
            <td>time</td>
            <td>time</td>
            <td>time</td>
            <td>time</td>
            <td>players</td>
            <td>reason</td>
            <td>how</td>
            <td>whereFrom</td>
            <td>whereTo</td>
            <td>type</td>
            <td>distance</td>
            <td>outcome</td>
        </tr>
        <xsl:apply-templates/>
    </table>
</xsl:template>

<xsl:template match="action">
    <tr>
        <td><xsl:value-of select="eventType"/></td>
        <td><xsl:value-of select="matchTime"/></td>
        <td><xsl:value-of select="eventTime"/></td>
        <td><xsl:value-of select="normalTime"/></td>
        <td><xsl:value-of select="addedTime"/></td>
        <td>
            <ul>
                <xsl:apply-templates select="players"/>
            </ul>
        </td>
        <td><xsl:value-of select="reason"/></td>
        <td><xsl:value-of select="how"/></td>
        <td><xsl:value-of select="whereFrom"/></td>
        <td><xsl:value-of select="whereTo"/></td>
        <td><xsl:value-of select="type"/></td>
        <td><xsl:value-of select="distance"/></td>
        <td><xsl:value-of select="outcome"/></td>
    </tr>
</xsl:template>

<xsl:template match="player1|player2|player3|player4">
    <li>
        <strong>
            <a href="http://pads6.pa-sport.com/api/football/player/stats/summary/dxj451p9/{@playerID}/20130101/20150101">
                <xsl:value-of select="."/>
            </a>
        </strong>
        <xsl:text> </xsl:text>
        <small>
            <a href="http://pads6.pa-sport.com/api/football/player/events/dxj451p9/{@playerID}/20130101/20150101">
                events
            </a>
        </small>
        <xsl:text> </xsl:text>
        <small>
            <a href="http://pads6.pa-sport.com/api/football/player/profile/dxj451p9/{@playerID}">
                profile
            </a>
        </small>
        <xsl:text> </xsl:text>
        <small>
            <a href="http://pads6.pa-sport.com/api/football/player/image/dxj451p9/{@playerID}">
                image
            </a>
        </small>
        <small>
            <xsl:value-of select="./@teamName"/>
        </small> 
    </li> 
</xsl:template>

</xsl:stylesheet>
