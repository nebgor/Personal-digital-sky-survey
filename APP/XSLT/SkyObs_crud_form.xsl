<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : SkyObs_crud_form.xsl
    Created on : 12 August 2014, 1:52 AM
    Author     : aparup
    Description:
        Purpose is to transform xml for CRUD via xhtml form
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output method="html"/>

    <xsl:variable name="xsd" select="document('../XML/SkyObservations.xsd')"/>
   
    <xsl:template match="/">
        <html>
            <head>
                <title>Create/Read/Update/Delete</title>
                <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet"/>
                <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="SkyObservations">
         <form name="entries" method="post">
            <select name="type">
                <xsl:apply-templates select="/SkyObservations/SkyObservation/type"/>
            </select>
            <input class="button" type="submit" name="submit" />
            <hr/>
            <xsl:apply-templates select="SkyObservation"/>

         </form>
    </xsl:template>

   <xsl:template match="/SkyObservations/SkyObservation/type">
      <xsl:copy>
         <xsl:for-each select="*">
            <xsl:variable name="eltName" select="local-name()"/>
            <xsl:copy-of select="." />
            <availableOptions>
               <xsl:variable name="optionType"
                  select="$xsd//xs:element[@name = $eltName]/@type"/>
               <xsl:apply-templates
                  select="$xsd//xs:simpleType[@name = $optionType]/
                       xs:restriction/xs:enumeration"/>
            </availableOptions>
         </xsl:for-each>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="xs:enumeration">
      <option>
          <xsl:attribute name="value">
              <xsl:value-of select="@value" />
          </xsl:attribute>
      </option>
   </xsl:template>

   <xsl:template match="SkyObservation">
        <!-- simple list of xml data -->
        <xsl:for-each select="SkyObservations/SkyObservation">
        <a href="#"><xsl:value-of select="name" /></a><br/>
        </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>
