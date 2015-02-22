<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

//Load source XML
$xml = new DOMDocument;

//load data xml
$xml->load('navbar/navbar.xml');
$root = $xml->documentElement;

$xpath = new DOMXPath($xml);
// <dropdown name="favourite">

// toggle tag....
$found=0;
   
if( isset($_REQUEST['tagtype']) && isset($_REQUEST['id']) ) {
	$xquery = '/root/navbar/dropdown[@name="'.	$_REQUEST['tagtype']. '"]/link[@id="'. $_REQUEST['id']. '"]';

	$nodeList = $xpath->query($xquery);
	// var_dump($xquery);
	if ($nodeList->length) {
		//found , remove it.
		echo 'removed from '.$_REQUEST['tagtype'];
	    $node = $nodeList->item(0);
	    $node->parentNode->removeChild($node); 
	    $found=1;
	} 

	if (!$found) {
		// not found, add it.
		$xquery = '/root/navbar/dropdown[@name="'.	$_REQUEST['tagtype']. '"]';
		// var_dump($xquery);
		$nodeList = $xpath->query($xquery);
		$node = $nodeList->item(0); 

		$newnode = $xml->createElement('link');
		$newattr = $xml->createAttribute('id');
		$newattr->value = $_REQUEST['id'];
		$newnode->appendChild($newattr);

		$node->appendChild($newnode);
		echo 'added to '. $_REQUEST['tagtype'];
	}
	$xml->save('navbar/navbar.xml');
}


// //return new (transformed from xml ) xhtml for the menu to be updated with..
// // tranform into a web form for display.
// $xsl = new DOMDocument;
// $xsl->load('navbar/navbar.xsl');

// // Configure the transformer
// $proc = new XSLTProcessor;
// $proc->importStyleSheet($xsl); // attach the xsl rules

// $subxml = new DOMDocument;
// $xquery = '/root/navbar';
// $nodeList = $xpath->query($xquery);
// $node = $nodeList->item(0); 
// var_dump($node->nodeValue);
// $subxml->importNode($node);
// // echo $subxml->saveXML();

// $rendering = $proc->transformToXML($xml);

// echo $rendering;


// //returnraw xml for the menu to be updated with. transformation on client side.
// echo $subxml->saveXML();

?>