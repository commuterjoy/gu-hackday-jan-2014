<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="matches">
    
        <p class="card">
          <strong><xsl:value-of select="//goals/goal/player"/></strong> has scored
          <xsl:value-of select="count(//goals/goal)"/> goals from
          <xsl:value-of select="count(//event[eventType='Shot'])"/> shots, 
          a <xsl:value-of select="round((count(//goals/goal) div count(//event[eventType='Shot']))*100)"/>% success
          rate.
        </p>

        <h2 class="sub">Appendage prowess</h2>

        <p class="card">
          <strong><xsl:value-of select="//goals/goal/player"/></strong> has scored
          scored <xsl:value-of select="count(//event[how='Head' and outcome='Goal'])"/>
          goals with his <i>head</i> this season, from <xsl:value-of select="count(//event[how='Head'])"/> attempts.
        </p>

        <p class="card">
          Since his signing <strong><xsl:value-of select="//goals/goal/player"/></strong> has scored
          scored <xsl:value-of select="count(//event[how='Left Foot' and outcome='Goal'])"/>
          goals with his <i>left foot</i> and <xsl:value-of select="count(//event[how='Right Foot' and outcome='Goal'])"/> goals with his
          <i>right</i>.
        </p>
        
        <p class="card">
          <xsl:variable name="shots.left" select="count(//event[how='Left Foot'])"/>
          <xsl:variable name="goals.left" select="count(//event[how='Left Foot' and outcome='Goal'])"/>
          <xsl:variable name="shots.right" select="count(//event[how='Right Foot'])"/>
          <xsl:variable name="goals.right" select="count(//event[how='Right Foot' and outcome='Goal'])"/>
      
          <xsl:choose>
              <xsl:when test="($goals.left div $shots.left) > ($goals.right div $shots.right)">
                  <strong><xsl:value-of select="//goals/goal/player"/></strong> goals-to-shots ratio 
                  is higher with his <i>left foot</i> than his right, with <xsl:value-of select="$goals.left"/> from 
                  <xsl:value-of select="$shots.left"/> shots.
              </xsl:when>
              <xsl:otherwise>
                  <strong><xsl:value-of select="//goals/goal/player"/></strong> goals-to-shots ratio 
                  is higher with his <i>right foot</i> than his left, with <xsl:value-of select="$goals.right"/> goals from 
                  <xsl:value-of select="$shots.right"/> shots.
              </xsl:otherwise>
          </xsl:choose>

      </p>

</xsl:template>

</xsl:stylesheet>
