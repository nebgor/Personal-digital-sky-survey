<?xml version="1.0"?>
<xsl:stylesheet  version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns="http://www.w3.org/1999/xhtml" >

 <xsl:template match="/">
	<xsl:apply-templates select="SkyObservations"/>
</xsl:template>


	<xsl:template match="SkyObservations"> 
        <svg  width="940" height="380"  xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"> <!-- right-ascension (hours) * 40 , declination (degrees) -->
    		<xsl:apply-templates select="SkyObservation"/>
    		<line x1="1" y1="1" x2="920" y2="1" style="stroke:rgb(99,99,99);stroke-width:2"/>
    		<line x1="1" y1="360" x2="920" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>
    		<line x1="1" y1="1" x2="1" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>
    		<line x1="920" y1="1" x2="920" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>

	        <text x="0" y="376" font-size="20" font-family="arial"  fill="black">| 0 (hour angle)</text>
	        <text x="890" y="376" font-size="20" font-family="arial"  fill="black">24 |</text>
	        <text x="930" y="0" font-size="20" font-family="arial"  fill="black" style="writing-mode: tb;">|0 declination (degrees)</text>
	        <text x="930" y="324" font-size="20" font-family="arial"  fill="black" style="writing-mode: tb;">360|</text>

	    </svg>
	</xsl:template>

	<xsl:template match="SkyObservation">

        <xsl:variable name="xcord" select="substring-before(coordinate/ords, ',')"/>
        <xsl:variable name="ycord" select="substring-after(coordinate/ords, ',')"/>
        <a  xmlns:xlink="http://www.w3.org/1999/xlink">
        	<xsl:attribute name="xlink:href">./?a=view&amp;id=<xsl:value-of select="@id" /></xsl:attribute>

        <xsl:choose>
            <xsl:when test="type = 'STAR'">
                <circle r="20" style="stroke:black;stroke-width:2" >
                    <xsl:attribute name="cx"><xsl:value-of select="40*$xcord" /></xsl:attribute>
                    <xsl:attribute name="cy"><xsl:value-of select="$ycord" /></xsl:attribute>
                </circle>
            </xsl:when>
            <xsl:when test="type = 'PLANET'">
                <circle r="10" style="stroke:black;stroke-width:2" >
                    <xsl:attribute name="cx"><xsl:value-of select="40*$xcord" /></xsl:attribute>
                    <xsl:attribute name="cy"><xsl:value-of select="$ycord" /></xsl:attribute>
                </circle>
            </xsl:when>
            <xsl:when test="type = 'GALAXY'">
                <ellipse rx="60" ry="20" style="stroke:black;stroke-width:2;fill:none" >
                    <xsl:attribute name="cx"><xsl:value-of select="40*$xcord" /></xsl:attribute>
                    <xsl:attribute name="cy"><xsl:value-of select="$ycord" /></xsl:attribute>
                </ellipse>
            </xsl:when>
            <xsl:when test="type = 'NEBULA'">
                <ellipse rx="20" ry="10" style="stroke:black;stroke-width:2" >
                    <xsl:attribute name="cx"><xsl:value-of select="40*$xcord" /></xsl:attribute>
                    <xsl:attribute name="cy"><xsl:value-of select="$ycord" /></xsl:attribute>
                </ellipse>
            </xsl:when>
            <xsl:when test="type = 'CLUSTER'">
                <circle r="30" style="stroke:black;stroke-width:2;fill:none" >
                    <xsl:attribute name="cx"><xsl:value-of select="40*$xcord" /></xsl:attribute>
                    <xsl:attribute name="cy"><xsl:value-of select="$ycord" /></xsl:attribute>
                </circle>
            </xsl:when>
        </xsl:choose>

    	</a>

        <text font-size="20" font-family="arial"  fill="red">
			<xsl:attribute name="x"><xsl:value-of select="40*$xcord" /></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$ycord" /></xsl:attribute>
			<xsl:value-of select="@id" />
   		</text>

	</xsl:template>

</xsl:stylesheet>