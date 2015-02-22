<?xml version="1.0"?>
<xsl:stylesheet  version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

 <xsl:template match="/">
	<rss version="2.0">
	  	<channel>
	    	<title>List of objects</title>
	     	<link>http://github.com/nebgor/</link>
	     	<description>watch list of objects in survey</description>
	     	<copyright>© Aparup Banerjee. All Rights Reserved.</copyright>
			<xsl:apply-templates select="SkyObservations"/>
		</channel>
    </rss>
<!--   </body>
 </html> -->
</xsl:template>

<!-- currently invalid time produced. not rfc-822 -->
<xsl:template name="showts-rfc-822"> 
    <xsl:param name="seconds"/> 
    <xsl:variable name="year" select="floor($seconds div (60 * 60 ))"/>
    <xsl:variable name="hours" select="floor($seconds div (60 * 60))"/>
    <xsl:variable name="divisor_for_minutes" select="$seconds mod (60 * 60)"/>
    <xsl:variable name="minutes" select="floor($divisor_for_minutes div 60)"/>
    <xsl:variable name="divisor_for_seconds" select="$divisor_for_minutes mod 60"/>
    <xsl:variable name="secs" select="ceiling($divisor_for_seconds)"/>
    <xsl:choose>
        <xsl:when test="$hours &lt; 10">
            <xsl:text>0</xsl:text><xsl:value-of select="$hours"/><xsl:text>hh</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$hours"/><xsl:text>hh</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="$minutes &lt; 10">
            <xsl:text>0</xsl:text><xsl:value-of select="$minutes"/><xsl:text>mm</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$minutes"/><xsl:text>mm</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="$secs &lt; 10">
            <xsl:text>0</xsl:text><xsl:value-of select="$secs"/><xsl:text>ss</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$secs"/><xsl:text>ss</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="SkyObservations"> 
		<xsl:apply-templates select="SkyObservation"/>
</xsl:template>

<xsl:template match="SkyObservation">
	<item>
		<guid isPermaLink="false"><xsl:value-of select="@id"/></guid>
		<description><xsl:value-of select="type"/>: <xsl:value-of select="name"/></description>
		<link>http://http://localhost/PDSS/XHTML/?a=view&amp;id=<xsl:value-of select="@id" /></link>
		<pubDate>
			<xsl:call-template name="showts-rfc-822">
				<xsl:with-param name="seconds" select="date"/>
			</xsl:call-template>
		</pubDate>
		</item>
</xsl:template>
</xsl:stylesheet>