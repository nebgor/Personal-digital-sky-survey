<?php
// tranform SVG MAP into a web form for display.
$xml = new DOMDocument;
$xml->load('../APP/SkyObs.xml');
$xsl = new DOMDocument;
$xsl->load('../APP/XSLT/SkyObs_svg.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->importStyleSheet($xsl); // attach the xsl rules

$rendering = $proc->transformToXML($xml);

if (!headers_sent()) {
	header("Content-type: image/svg+xml");
}
echo $rendering;
?>