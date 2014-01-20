<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

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

          <h2>Ranking</h2>

          <xsl:variable name="goals" select="//statsType[description='Goals']/stat/total" />
          <xsl:variable name="assists" select="//statsType[description='Assists']/stat/total" />
          <xsl:variable name="crosses" select="//statsType[description='Crosses']/stat/total" />
          <xsl:variable name="shots.on" select="//statsType[description='Shots Off Target']/stat/total" />
          <xsl:variable name="shots.off" select="//statsType[description='Shots On Target']/stat/total" />
          <xsl:variable name="dismissals" select="//statsType[description='Dismissals']/stat/total" />
          <xsl:variable name="subs.off" select="//statsType[description='Substitutions Off']/stat/total" />

          <p>
             
              <xsl:value-of select="
                  ($goals * 10) + 
                  ($assists * 5) +
                  ($crosses * 2) + 
                  ($shots.on * 3) + 
                  ($shots.on * 2) + 
                  ($dismissals * 10) -
                  ($subs.off * 3)
                  "/>
              
          </p>
          
          <h2>Data</h2>
          <table>
            <tr>
                <td>type</td>
                <td>home</td>
                <td>away</td>
                <td>total</td>
            </tr>
            <xsl:apply-templates select="//statsType"/>
          </table>
      </body>
  </html>
</xsl:template>

<xsl:template match="statsType">

    <tr>
        <td><xsl:value-of select="description"/></td>
        <td><xsl:value-of select="stat/homeTotal"/></td>
        <td><xsl:value-of select="stat/awayTotal"/></td>
        <td><xsl:value-of select="stat/total"/></td>
    </tr>
</xsl:template>

</xsl:stylesheet>
