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
        <style type="text/css">*{box-sizing:border-box}body{background-color:#fff;color:#24292e;font-family:system-ui;line-height:1.5}a{color:#0366d6;text-decoration:none}a:hover{text-decoration:underline}nav,article{max-width:40rem;margin:1rem auto;padding:1rem;display:block;}nav{background-color:#fff5b1;}p{margin:0}h1,h2{margin-top:0;margin-bottom:1rem;font-weight:600;line-height:1.25}h1{padding-bottom:.3em;font-size:2em}h1 svg{padding-right:.25rem;vertical-align:text-bottom;width:1.2em;height:1.2em}h2{font-size:1.25em;margin-bottom:0}header{padding-top:2rem;padding-bottom:2rem}section{padding-bottom:2rem}muted{color:#586069}</style>
      </head>
      <body>
        <nav>
          <p>
            <strong>This is a web feed,</strong> also known as an RSS or Atom feed. <strong>Subscribe</strong> by copying the URL from the address bar into your newsreader. <a href="https://aboutfeeds.com">What is a feed?</a>
          </p>
        </nav>
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
