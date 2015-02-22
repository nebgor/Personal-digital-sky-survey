<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

/////////////////////////////////////////////////////////////
// render app navigation

//Load source XML
$xml = new DOMDocument;

// tranform SVG MAP into a web form for display.
$xml = new DOMDocument;
$xml->load('../APP/SkyObs.xml');
$xsl = new DOMDocument;
$xsl->load('../APP/XSLT/SkyObs_rss.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules

$rendering = $proc->transformToXML($xml);

header('Content-Type: text/xml');
echo $rendering;
?>