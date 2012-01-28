<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html lang="en">
<head>
<title><xsl:value-of select="/rss/channel/title"/> by FeedMerge</title>
<link href="rss.css" rel="stylesheet"/>
</head>
<body>
<div id="header" class="box">
<h1><xsl:value-of select="/rss/channel/title"/></h1>
<p><xsl:value-of select="/rss/channel/description"/></p>
</div>
<div id="content">
<ul>
<xsl:for-each select="rss/channel/item">
<li><a href="{link}"><xsl:value-of select="title"/></a></li>        
</xsl:for-each>
</ul>
</div>
<div id="footer" class="box">
<p>Powered by FeedMerge.</p>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
