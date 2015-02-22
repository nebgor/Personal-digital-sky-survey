<?php

/* 
 * Copyright (C) 2014 aparup
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/////////////////////////////////////////////////////////////
// render app navigation

//Load source XML
$xml = new DOMDocument;
$xml->load('navbar/navbar.xml');
//echo $xml->schemaValidate('../XML/SkyObservations.xsd');
// tranform into a web form for display.
$xsl = new DOMDocument;
$xsl->load('navbar/navbar.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->setProfiling('xsltprof.log');
$proc->importStyleSheet($xsl); // attach the xsl rules

$rendering = $proc->transformToXML($xml);

echo $rendering;

//Load source navigation XML (for adding or deleting of pages and menu items)
$xml = new DOMDocument;
$xml->load('navbar/navbar.xml');

// if submission, accept form submission too.
if (isset($_REQUEST['submit']) && $_REQUEST['version']) {
//    echo $_REQUEST['version'];
    // transform data and Create/Update/Delete into original XML for storage.
    echo '<br/>received data modification request. adding..<br/>';
}
?>