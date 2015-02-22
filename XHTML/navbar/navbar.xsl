<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:include href="../common.xsl"/> <!-- main xsl - includes all passed in params needed, globally here on. -->
    <xsl:output method="html"/>

    <xsl:template match="projectname">
        <title><xsl:value-of select="@value" /></title>
    </xsl:template>

    <xsl:variable name="projname" select="document('navbar.xml')/root/projectname/@value" />

    <xsl:template match="navbar">
        <!-- Static navbar -->
        <div class="navbar navbar-default navbar-static-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                  <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                  </button>
                  <a class="navbar-brand" href="#"><xsl:value-of select="$projname"/></a>
                </div>
                <div class="navbar-collapse collapse">
                  <ul class="nav navbar-nav">
                    <xsl:apply-templates/>
                  </ul>
                  <ul class="nav navbar-nav navbar-right">
                      <li><a href='#'><xsl:value-of select="$time"/></a></li>
                  </ul>
                </div>
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="link">
    <!-- links depend on index.php trivial routing -->
      <xsl:choose>
        <xsl:when test="../@name='favourite' or ../@name='exploring'">  
          <li>
            <a>
              <xsl:attribute name="href">./?a=view&amp;id=<xsl:value-of select="@id" /></xsl:attribute>
               <xsl:value-of select="document('../../APP/SkyObs.xml')/SkyObservations/Skyobservation[@id='./@id']"/>
              (<xsl:value-of select="@id" />)
            </a>
          </li>
        </xsl:when>
        <xsl:otherwise>
          <li><a href="index.php?a={@action}"><xsl:value-of select="@action" /></a></li>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:template>
    
    <xsl:template match="dropdown">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown"><xsl:value-of select="@name" /><span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <xsl:apply-templates />
<!--        <li class="dropdown-header">Favourites to be dynamically added</li> -->
          </ul>
        </li>
    </xsl:template>
</xsl:stylesheet>