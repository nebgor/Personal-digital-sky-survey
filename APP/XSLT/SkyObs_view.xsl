<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : SkyObs_crud_form.xsl
    Created on : 12 August 2014, 1:52 AM
    Author     : aparup
    Description:
        Purpose is to transform xml for CRUD via xhtml form
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns="http://www.w3.org/2000/svg">
    <xsl:param name="id" />
    <!-- for mvcview=='update'..., skyobs_form is mode="form" -->
    <xsl:include href="SkyObs_form.xsl"/> 
    <xsl:output method="html"/>

    <xsl:variable name="xsd" select="document('../SkyObservations.xsd')"/>
   
    <xsl:template match="SkyObservations">
<!--         <fieldset>
            <legend>Object types</legend>
            <ul>
            <xsl:apply-templates
              select="$xsd//xs:simpleType[@name = 'objType']/xs:restriction/xs:enumeration"/>
            </ul>
        </fieldset> -->
          <!-- <xsl:message> -->
            <xsl:for-each select="ancestor-or-self::*">
              <xsl:value-of select="name(.)"/> /
            </xsl:for-each>
<!--           </xsl:message> -->
        <fieldset>
            <legend>Observations journal</legend>
            <xsl:apply-templates select="SkyObservation"/>
        </fieldset>
        <hr/>
       <script type="text/javascript">
        function toggletag(ajaxurl) {
            $.ajax({
              url: ajaxurl,
              context: document.body
                  }).done(function( data ) {
                        alert(data);
                        location.reload();
                    });
        }
<!--                 function xmltomenu(data, xsldata) {
            parser=new DOMParser();
            xml=parser.parseFromString(data,"text/xml");
            xsl=parser.parseFromString(xsldata,"text/xml");
            alert(xsldata);
            xslproc = new XSLTProcessor();
            xslproc.importStylesheet(xsl);
            transdata = xslproc.transformToFragment(xml, document);
            alert(transdata);

        } -->
        </script>
    </xsl:template>
<!-- 
    <xsl:template match="Skyobservation[@id='id']">
        <fieldset>
            <legend>Single object journal</legend>
            <xsl:apply-templates select="SkyObservation"/>
        </fieldset>
        <hr/>
    </xsl:template> -->

    <xsl:template match="SkyObservation">
        <xsl:choose>
            <xsl:when test="$id = '0'">
               <table>
                   <xsl:attribute name="class">table</xsl:attribute>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Hops</th>
                            <th>Toggle in menu</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a>
                                    <xsl:attribute name="href">./?a=view&amp;id=<xsl:value-of select="@id" /></xsl:attribute>
                                    <xsl:value-of select="name" />
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="type" />
                            </td>
                            <td>
                                <xsl:for-each select="hops/id">
                                    <a>
                                        <xsl:attribute name="href">./?a=view&amp;id=<xsl:value-of select="." /></xsl:attribute>
                                        [<xsl:value-of select="//SkyObservation[@id=current()]/name" />]
                                    </a>
                                </xsl:for-each>
                            </td>
                            <td>
                                <button>
                                    <xsl:attribute name="onclick">toggletag("./?a=tag&amp;tagtype=favourite&amp;id=<xsl:value-of select="@id" />");</xsl:attribute>
                                    Favourite
                                </button>
                                <button>
                                    <xsl:attribute name="onclick">toggletag("./?a=tag&amp;tagtype=exploring&amp;id=<xsl:value-of select="@id" />");</xsl:attribute>
                                    Exploring
                                </button>
                            </td>
                        </tr>
                    </tbody>
               </table>
            </xsl:when>
            <xsl:when test="@id = $id">
               <table>
                   <xsl:attribute name="class">table</xsl:attribute>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Type</th>
                            <th>Hops</th>
                            <th>Notes</th>
                            <th>Extra</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a>
                                    <xsl:attribute name="href">./?a=view&amp;id=<xsl:value-of select="@id" /></xsl:attribute>
                                    <xsl:value-of select="name" />
                                </a>
                            </td>
                            <td>
                                <xsl:value-of select="type" />
                            </td>
                            <td>
                                <xsl:for-each select="hops/id">
                                    <a>
                                        <xsl:attribute name="href">./?a=view&amp;id=<xsl:value-of select="." /></xsl:attribute>
                                        [<xsl:value-of select="//SkyObservation[@id=current()]/name" />]
                                    </a>
                                </xsl:for-each>
                            </td>
                            <td>
                                <xsl:value-of select="notes" />
                            </td>
                            <td>
                                <xsl:for-each select="extra/*">
                                    <p>
                                        <xsl:value-of select="local-name()" />:<xsl:value-of select="." />
                                    </p>
                                </xsl:for-each>
                            </td>
                        </tr>
                    </tbody>
               </table>

                <xsl:variable name="xcord" select="substring-before(coordinate/ords, ',')"/>
                <xsl:variable name="ycord" select="substring-after(coordinate/ords, ',')"/>

               <svg  width="940" height="380"> <!-- right-ascension (hours) * 40 , declination (degrees) -->
                    <line x1="1" y1="1" x2="920" y2="1" style="stroke:rgb(99,99,99);stroke-width:2"/>
                    <line x1="1" y1="360" x2="920" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>
                    <line x1="1" y1="1" x2="1" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>
                    <line x1="920" y1="1" x2="920" y2="360" style="stroke:rgb(99,99,99);stroke-width:2"/>
                    <text x="0" y="376" font-size="20" font-family="arial"  fill="black">| 0 (hour angle)</text>
                    <text x="890" y="376" font-size="20" font-family="arial"  fill="black">24 |</text>
                    <text x="930" y="0" font-size="20" font-family="arial"  fill="black" style="writing-mode: tb;">|0 declination (degrees)</text>
                    <text x="930" y="324" font-size="20" font-family="arial"  fill="black" style="writing-mode: tb;">360|</text>
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
               </svg>
            </xsl:when>
        </xsl:choose>
   </xsl:template>

    <xsl:template match="xs:enumeration">
        <!--<xsl:copy>-->
            <li>
                <xsl:value-of select="@value" />
            </li>
        <!--</xsl:copy>-->
    </xsl:template>
</xsl:stylesheet>
