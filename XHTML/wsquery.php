<?php

/* 
 * Copyright (C) 2014 Aparup Banerjee
 */

header('Content-Type: text/xml');

if (!isset($_REQUEST['xquery']) || empty($_REQUEST['xquery'])) {
	echo '<?xml version="1.0"?><error>Missing parameter/data: "xquery"</error>';
	exit(1);
}
/////////////////////////////////////////////////////////////

// render app navigation

//Load source XML
$xml = new DOMDocument;

//load data xml
$xml->load('../APP/SkyObs.xml');
$xpath = new DOMXPath($xml);
$xquery = $_REQUEST['xquery'];
// var_dump($xquery);
$SkyObs='';

$SkyObs = $xpath->query($xquery);

// var_dump($SkyObs->item(0));

echo '<'. $SkyObs->item(0)->tagName. ' '; 
	foreach ($SkyObs->item(0)->attributes as $attr) {
		echo $attr->name. '="'. $attr->value . '"';
	}
echo ' >';

	foreach ($SkyObs->item(0)->childNodes as $el) {
		if ($el instanceof DOMElement)  {
			// var_dump($el);
			echo '<'. $el->nodeName. ' ';
				foreach ($el->attributes as $attr) {
					echo $attr->name. '="'. $attr->value . '"';
				}
			echo ' />';
		}
	}

echo '</'. $SkyObs->item(0)->tagName. '>'; 

$xmlreturn = new DOMDocument;
$xmlreturn

?>