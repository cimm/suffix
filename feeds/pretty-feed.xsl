---
layout: null
---
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
      <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <title><xsl:value-of select="atom:feed/atom:title"/></title>
        <link rel="stylesheet" href="{% relbase %}/assets/stylesheets/atom.css" />
      </head>
      <body>
        <header>
          <p>
            <strong>This is a web feed,</strong> also known as an RSS or Atom feed. <strong>Subscribe</strong> by copying the URL from the address bar into your newsreader. <a href="https://aboutfeeds.com">What is a feed?</a>
          </p>
        </header>
        <article>
          <header>
            <h1><xsl:value-of select="atom:feed/atom:title"/></h1>
            <p><xsl:value-of select="atom:feed/atom:description"/></p>
            <p>This preview only shows titles, but the actual feed contains the full content.</p>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="/atom:feed/atom:link[not(@rel)]/@href"/>
              </xsl:attribute>
              Visit website →
            </a>
          </header>
          <xsl:apply-templates select="atom:feed/atom:entry" />
        </article>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:feed/atom:entry">
    <section>
      <h2>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="atom:link/@href"/>
          </xsl:attribute>
          <xsl:value-of select="atom:title"/>
        </a>
      </h2>
      <small>
        <time><xsl:value-of select="atom:updated" /></time>
      </small>
    </section>
  </xsl:template>
</xsl:stylesheet>
