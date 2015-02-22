<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

function adddatatonodes($xml, $node) {
	if (isset($node->tagName) ) {
		if(isset($_POST[$node->tagName])) { //set if in post.
			$node->nodeValue = $_POST[$node->tagName];
		}

		$chnodes = $node->childNodes;
		foreach ($chnodes as $chnode) {
			if (isset($chnode->tagName) ) {
				$xml = adddatatonodes($xml, $chnode);
			}
		}
	}
	return $xml;
}

$params = array(
    'mvcview' => 'update', //default - change according to pages.
    'type' => 'star',
    'time' => strftime("%Y. %B %d. %A. %X %Z"),
    'unixtime' => time(),
    'displaymessage' => 'Updating..'
);
/////////////////////////////////////////////////////////////

// render app navigation

//Load source XML
$xml = new DOMDocument;


//if submitted, validate new values with xsd then change xml data file.
if(isset($_REQUEST['submit'])) {
	//load data xml
	$xml->load('../APP/SkyObs.xml');
    $xpath = new DOMXPath($xml);
    $xquery = '//SkyObservations/SkyObservation[@id="'. $_REQUEST['id'] .'"]';
    $SkyObs = $xpath->query($xquery);
	foreach ($SkyObs->item(0)->childNodes as $node) {
		if (isset($node->tagName) ) {
	    	$xml = adddatatonodes($xml, $node);
    	}
	}
	if ($xml->schemaValidate('../APP/SkyObservations.xsd') ) {
		$params['displaymessage'] = '<p class="text-success">Submitted changes validated and saved successfully.</p>';
		$xml->save('../APP/SkyObs.xml');
	} else {
		$params['displaymessage'] = '<p class="text-error">Changes not saved. There was a data validation error.</p>';
	}

}

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