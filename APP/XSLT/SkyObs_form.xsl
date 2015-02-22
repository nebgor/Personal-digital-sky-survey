<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : SkyObs_form.xsl
    Created on : 12 August 2014, 1:52 AM
    Author     : aparup
    Description:
        Purpose is to transform xml for CRUD via xhtml form
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xsl:output method="html"/>

    <!-- <xsl:variable name="xsd" select="document('../SkyObservations.xsd')"/> -->

    <xsl:template match="SkyObservations" mode="form">
<!--         <fieldset>
            <legend>Object types</legend>
            <ul>
            <xsl:apply-templates
              select="$xsd//xs:simpleType[@name = 'objType']/xs:restriction" mode="form"/>
            </ul>
        </fieldset> -->
        <fieldset>
            <legend>Observations journal</legend>
        </fieldset>
            <xsl:apply-templates select="SkyObservation" mode="form"/>
        <hr/>
    </xsl:template>

    <xsl:template match="SkyObservation|xs:element[@name='SkyObservation']" mode="form">
       <form>
            <xsl:attribute name="method">post</xsl:attribute>
            <xsl:attribute name="action">.</xsl:attribute>
            <xsl:attribute name="role">form</xsl:attribute>
            <xsl:attribute name="class">form-inline</xsl:attribute>
            <div>
                <xsl:attribute name="class">form-group</xsl:attribute>
                <label><xsl:attribute name="for">name</xsl:attribute>Name:</label>
                <input>
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:attribute name="class">form-control</xsl:attribute>
                    <xsl:attribute name="id">name</xsl:attribute>
                    <xsl:attribute name="name">name</xsl:attribute>
                    <xsl:attribute name="value"><xsl:value-of select="name" /></xsl:attribute>
                </input>
            </div>
            <div>
                <xsl:attribute name="class">form-group</xsl:attribute>
                    <!-- <xsl:value-of select="type" /> -->
                    <!-- <xsl:variable name="selectedtype" select="type"/> -->
                    <!-- <xsl:value-of select="$selectedtype" /> -->
                    <xsl:apply-templates select="$xsd//xs:simpleType[@name = 'objType']/xs:restriction" mode="form">
                        <xsl:with-param name="type" select="type"/>
                    </xsl:apply-templates>
            </div>
            <div>
                <xsl:attribute name="class">form-group</xsl:attribute>
                <label><xsl:attribute name="for">ords</xsl:attribute>Coordinate:</label>
                <input>
                    <xsl:attribute name="type">text</xsl:attribute>
                    <xsl:attribute name="class">form-control</xsl:attribute>
                    <xsl:attribute name="id">ords</xsl:attribute>
                    <xsl:attribute name="name">ords</xsl:attribute>
                    <xsl:attribute name="value"><xsl:value-of select="coordinate/ords" /></xsl:attribute>
                </input>
            </div>
            <div>
                <xsl:attribute name="class">form-group</xsl:attribute>
                <label><xsl:attribute name="for">notes</xsl:attribute>Notes:</label>
                <input>
                    <xsl:attribute name="type">textarea</xsl:attribute>
                    <xsl:attribute name="class">form-control</xsl:attribute>
                    <xsl:attribute name="id">notes</xsl:attribute>
                    <xsl:attribute name="name">notes</xsl:attribute>
                    <xsl:attribute name="value"><xsl:value-of select="notes" /></xsl:attribute>
                </input>
            </div>
            <input>
                <xsl:attribute name="type">hidden</xsl:attribute>
                <xsl:attribute name="id">date</xsl:attribute>
                <xsl:attribute name="name">date</xsl:attribute>
                <xsl:attribute name="value"><xsl:value-of select="$unixtime" /></xsl:attribute>
            </input>
            <input>
                <xsl:attribute name="type">hidden</xsl:attribute>
                <xsl:attribute name="id">id</xsl:attribute>
                <xsl:attribute name="name">a</xsl:attribute>
                <xsl:attribute name="value"><xsl:value-of select="$mvcview" /></xsl:attribute>
            </input>
            <input>
                <xsl:attribute name="type">hidden</xsl:attribute>
                <xsl:attribute name="id">id</xsl:attribute>
                <xsl:attribute name="name">id</xsl:attribute>
                <xsl:attribute name="value"><xsl:value-of select="@id" /></xsl:attribute>
            </input>
            <input type="submit" name="submit" class="btn btn-default">Submit</input>
       </form>
    </xsl:template>      

    <xsl:template match="xs:restriction" mode="form">
        <xsl:param name="type"/>
        <label><xsl:attribute name="for">type</xsl:attribute>Type:</label>
<!--         <p><xsl:value-of select="$type"/></p> -->
        <select>
            <xsl:attribute name="class">form-control</xsl:attribute>
            <xsl:attribute name="name">type</xsl:attribute>
            <xsl:attribute name="id">type</xsl:attribute>
            <xsl:for-each select="xs:enumeration">
                <option>
                    <xsl:attribute name="value"><xsl:value-of select="@value" /></xsl:attribute>
                    <xsl:if test="$type = @value">
                        <xsl:attribute name="selected">true</xsl:attribute>
                    </xsl:if>
                   <xsl:value-of select="@value"/>
                </option>
            </xsl:for-each>
        </select>
    </xsl:template>
</xsl:stylesheet>
