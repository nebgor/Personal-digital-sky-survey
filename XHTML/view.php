<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

$params = array(
    'mvcview' => 'view', //default - change according to pages.
    'type' => 'star',
    'time' => strftime("%Y. %B %d. %A. %X %Z"),
    'unixtime' => time(),
    'displaymessage' => 'Viewing',
    'id' => isset($_REQUEST['id'])?$_REQUEST['id']:'0'
);
/////////////////////////////////////////////////////////////
// render app navigation

//Load source XML
$xml = new DOMDocument;

// now loaded in xsl via document() call for lesser php calls.
//$xml->load('navbar/navbar.xml');
//echo $xml->schemaValidate('../XML/SkyObservations.xsd');

// tranform into a web form for display.
$xsl = new DOMDocument;
$xsl->load('navbar/navbar.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules
$proc->setParameter('', $params);

$rendering = $proc->transformToXML($xml);

echo $rendering;

?>
<hr/>
<h1>Map of all objects (click object to view details of it)</h1>
<?php include('svg.php');?>
<hr/>