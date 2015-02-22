<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */
$params = array(
    'mvcview' => 'create', //default - change according to pages.
    'type' => 'star',
    'time' => strftime("%Y. %B %d. %A. %X %Z"),
    'unixtime' => time(),
    'displaymessage' => 'Creating..'
);
/////////////////////////////////////////////////////////////

// render app navigation

//Load source XML
$xml = new DOMDocument;

//if submitted, validate new values with xsd then change add xml to data file. (no checking, data is sequential on xpaths when looking up.)
if(isset($_REQUEST['submit'])) {
	//load data xml
	$xml->load('../APP/SkyObs.xml');
    $xpath = new DOMXPath($xml);

    $xquery = '//SkyObservations';
	$nodeList = $xpath->query($xquery);
	$node = $nodeList->item(0); 

	$newnoderoot = $xml->createElement('SkyObservation');
	$newattr = $xml->createAttribute('id');
	$newattr->value = 'a-'. $_POST['date']; //try to make it unique and meaningful

	$newnoderoot->appendChild($newattr);

	$newnode = $xml->createElement('date');
	$newnodetxt = $xml->createTextNode($_POST['date']);
	$newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('coordinate'); // hardcode for now ordType="EQ"
	$newattr = $xml->createAttribute('ordType');
	$newattr->value = 'EQ'; //try to make it unique and meaningful
	$newnode->appendChild($newattr);

	$newnode2 = $xml->createElement('ords');
	$newnode2txt = $xml->createTextNode($_POST['ords']);
	$newnode2->appendChild($newnode2txt);

	$newnode->appendChild($newnode2);
	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('name');
	$newnodetxt = $xml->createTextNode($_POST['name']);
	$newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('notes');
	$newnodetxt = $xml->createTextNode($_POST['notes']);
	$newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('type');
	$newnodetxt = $xml->createTextNode($_POST['type']);
	$newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('hops');
	// $newnodetxt = $xml->createTextNode($_POST['hops']); //@todo
	// $newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);

	$newnode = $xml->createElement('extra');
	// $newnodetxt = $xml->createTextNode($_POST['extra']); //@todo
	// $newnode->appendChild($newnodetxt);

	$newnoderoot->appendChild($newnode);


	$node->appendChild($newnoderoot);

	// var_dump($xml->saveXML());

	if ($xml->schemaValidate('../APP/SkyObservations.xsd') ) {
		$params['displaymessage'] = '<p class="text-success">Submitted changes validated and saved successfully.</p>';
		$xml->save('../APP/SkyObs.xml');
	} else {
		$params['displaymessage'] = '<p class="text-error">Changes not saved. There was a data validation error.</p>';
	}

}



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