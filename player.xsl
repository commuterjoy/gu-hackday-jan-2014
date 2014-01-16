<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

          <h2>Goals</h2>
          <strong><xsl:value-of select="//goals/goal/player"/></strong> has scored
          <xsl:value-of select="count(//goals/goal)"/> goals from
          <xsl:value-of select="count(//event[eventType='Shot'])"/> shots.

          <h2>Appendage prowess</h2>
          <ul>
              <li>
                  <xsl:value-of select="count(//event[how='Left Foot'])"/> left foot
                  (goals <xsl:value-of select="count(//event[how='Left Foot' and outcome='Goal'])"/>) 
              </li>
              <li>
                  <xsl:value-of select="count(//event[how='Right Foot'])"/> right foot
                  (goals <xsl:value-of select="count(//event[how='Right Foot' and outcome='Goal'])"/>) 
              
              </li>
              <li>
                  <xsl:value-of select="count(//event[how='Head'])"/> head
                  (goals <xsl:value-of select="count(//event[how='Head' and outcome='Goal'])"/>) 
              </li>
          </ul>

      </body>
  </html>
</xsl:template>

</xsl:stylesheet>
