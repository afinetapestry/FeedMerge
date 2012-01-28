<?php

date_default_timezone_set("UTC");

function server() {
	$s = empty($_SERVER["HTTPS"]) ? ''
		: ($_SERVER["HTTPS"] == "on") ? "s"
		: "";
	$protocol = strleft(strtolower($_SERVER["SERVER_PROTOCOL"]), "/").$s;
	$port = ($_SERVER["SERVER_PORT"] == "80") ? ""
		: (":".$_SERVER["SERVER_PORT"]);
	return $protocol."://".$_SERVER['SERVER_NAME'].$port;
}
function strleft($s1, $s2) {
	return substr($s1, 0, strpos($s1, $s2));
}

function item_sort($a, $b) {
	$aTime = strtotime($a->pubDate);
	$bTime = strtotime($b->pubDate);

	if ($aTime < $bTime) {return 1;}
	if ($aTime == $bTime) {return 0;}
	if ($aTime > $bTime) {return -1;}
}

include "config.php";

$feeds = array();
$feedTitle = "";
$feedLink = server() . $_SERVER['REQUEST_URI'];
$feedDescription = "";

if (!isset($_GET['i'])) {die("No instance specified.");}

try {
	$pdo = new PDO($dsn, $username, $password);
	
	$pdo->beginTransaction();
	
	$instance = $pdo->prepare("SELECT name, description FROM instance WHERE id = :id");
	$instance->bindParam(":id", $_GET['i'], PDO::PARAM_INT);
	$instance->execute();
	$instance->bindColumn("name", $name);
	$instance->bindColumn("description", $description);
	
	if (!$instance->fetch(PDO::FETCH_ASSOC)) {die("PDO Fetch fail");}
	
	$feedTitle = $name;
	$feedDescription = $description;
	
	$sources = $pdo->prepare("SELECT url FROM sources WHERE instance = :id");
	$sources->bindParam(":id", $_GET['i'], PDO::PARAM_INT);
	$sources->execute();
	$sources->bindColumn("url", $url);
	
	while ($sources->fetch(PDO::FETCH_ASSOC)) {array_push($feeds, $url);}
	
	$pdo->commit();
} catch (Exception $e) {
	die("Fail: " . $e);
}

$items = array();

foreach ($feeds as $feed) {
	$x = new SimpleXMLElement(file_get_contents($feed));
	
	$items = array_merge($items, $x->xpath("//item"));
}

usort($items, "item_sort");

header("Content-type: text/xml; charset=UTF-8");

echo '<?xml version="1.0" encoding="UTF-8"?>', PHP_EOL;
echo '<?xml-stylesheet href="rss.xsl" type="text/xsl" media="screen"?>', PHP_EOL;
echo '<rss xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:slash="http://purl.org/rss/1.0/modules/slash/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#" version="2.0">', PHP_EOL;
echo '<channel>', PHP_EOL;
echo '<title>', $feedTitle, '</title>', PHP_EOL;
echo '<link>', $feedLink, '</link>', PHP_EOL;
echo '<description>', $feedDescription,'</description>', PHP_EOL;
echo '<atom10:link xmlns:atom10="http://www.w3.org/2005/Atom" rel="self" type="text/xml" href="', server() . $_SERVER['REQUEST_URI'], '" />', PHP_EOL;
echo '<lastBuildDate>', date('D, d M Y H:i:s T'), '</lastBuildDate>', PHP_EOL;

foreach ($items as $item) {
	echo $item->asXML(), PHP_EOL;
}

echo '</channel>', PHP_EOL;
echo '</rss>';

?>
