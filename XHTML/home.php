<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

$params = array(
    'mvcview' => 'view', //default - change according to pages.
    'type' => 'star',
    'time' => strftime("%Y. %B %d. %A. %X %Z"),
    'unixtime' => time(),
    'displaymessage' => 'Welcome',
    'id' => '0'
);
/////////////////////////////////////////////////////////////
// render app navigation

//Load source XML
$xml = new DOMDocument;

// tranform into a web form for display.
$xsl = new DOMDocument;
$xsl->load('navbar/navbar.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules
$proc->setParameter('', $params);

$rendering = $proc->transformToXML($xml);

echo $rendering;

// // tranform SVG MAP into a web form for display.
// $xml = new DOMDocument;
// $xml->load('../APP/SkyObs.xml');
// $xsl = new DOMDocument;
// $xsl->load('../APP/XSLT/SkyObs_svg.xsl');

// // Configure the transformer
// $proc = new XSLTProcessor;
// $proc->importStyleSheet($xsl); // attach the xsl rules
// $proc->setParameter('', $params);

// $rendering = $proc->transformToXML($xml);

// echo $rendering;

?>