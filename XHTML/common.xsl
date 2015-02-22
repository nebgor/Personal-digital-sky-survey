<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="1.0">
    <xsl:param name="time" />
    <xsl:param name="displaymessage"/>
    <xsl:param name="mvcview"/>
    <xsl:param name="id"/>
    <xsl:include href="../APP/XSLT/SkyObs_view.xsl"/>

    <xsl:output method="html"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>

    <xsl:template match="/">
        <!-- use xsl conditions to load according to mvcview. default to 'view'.-->
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:apply-templates select="document('navbar/navbar.xml')/root/projectname"/>
                <!-- need internet -->
<!--                <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
                <script src="//code.jquery.com/jquery-2.1.1.min.js"/>
                <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"/>-->
                
                <!-- for aeroplane / observation site (no internet) @todo get correction versions, these were scavagened from around the laptop-->
                <link href="../lib/css/bootstrap.min.css" rel="stylesheet"/>
                <script type="text/javascript" src="../lib/js/jquery-2.1.1.min.js"/>
                <script type="text/javascript" src="../lib/js/bootstrap.min.js"/>
            </head>
            <body>
                <xsl:copy>
                    <xsl:apply-templates select="document('navbar/navbar.xml')/root"/> 
                </xsl:copy>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="projectname"> <!-- overridden in navbar.xsl -->
        <title>common</title>
    </xsl:template>

    <xsl:template match="postnav"> <!-- placeholder for additional static content, error messages? -->
<!--         <p>
            <xsl:value-of select="$mvcview"/>
        </p> -->
        <!-- <p> -->
            <xsl:value-of select="$displaymessage"  disable-output-escaping="yes" />
        <!-- </p>  -->
    </xsl:template>

    <xsl:template match="content"> <!-- placeholder for additional static content, error messages? -->
        <xsl:choose>
            <xsl:when test="$mvcview = 'view'">
<!--                 <xsl:choose>
                    <xsl:when test="$id = '0'"> -->
                        <xsl:apply-templates select="document('../APP/SkyObs.xml')/SkyObservations">
                            <xsl:with-param name="id" />
                        </xsl:apply-templates>
                    <!-- </xsl:when>
                    <xsl:when test="not($id = '0')">
                        <p>single object (id: <xsl:value-of select="$id"/>)</p>
                        <p>object node: <xsl:value-of select="document('../APP/SkyObs.xml')/SkyObservations"/>)</p>
                        <xsl:apply-templates select="document('../APP/SkyObs.xml')/SkyObservations/Skyobservation[@id='$id']/*"/>
                    </xsl:when>
                </xsl:choose> -->
            </xsl:when>
            <xsl:when test="$mvcview = 'update'">
                <xsl:apply-templates select="document('../APP/SkyObs.xml')/SkyObservations" mode="form"/>
            </xsl:when>
            <xsl:when test="$mvcview = 'create'">
                <xsl:variable name="xsd" select="document('../APP/SkyObservations.xsd')"/>
                <!-- <xsl:apply-templates select="$xsd//xs:simpleType[@name = 'objType']/xs:restriction" mode="form"/> -->
                <xsl:apply-templates select="$xsd//xs:element[@name='SkyObservation']" mode="form"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="document('../APP/SkyObs.xml')/SkyObservations" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  

    <xsl:template match="footer"> <!-- placeholder for additional static content, footer? -->

        <p>copyright Aparup Banerjee</p>
    </xsl:template>

</xsl:stylesheet>