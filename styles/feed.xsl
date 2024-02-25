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
        <link rel="stylesheet" href="{% relbase %}/styles/fonts.css" />
        <link rel="stylesheet" href="{% relbase %}/styles/shared.css" />
        <link rel="stylesheet" href="{% relbase %}/styles/main.css" />
      </head>
      <body>
        <div class="alert">
          <p>
            <strong>This is a web feed,</strong> also known as an <abbr title="Really Simple Syndication">RSS</abbr> or Atom feed. It is meant for news readers, not humans.  <strong>Subscribe</strong> by copying the <abbr title="Uniform Resource Locator">URL</abbr> from the address bar into your news reader.<br/><a href="https://aboutfeeds.com">What is a feed?</a>
          </p>
        </div>
        <article>
          <header>
            <h1>
              <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" class="rss-accent" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 11a9 9 0 0 1 9 9"></path><path d="M4 4a16 16 0 0 1 16 16"></path><circle cx="5" cy="19" r="1"></circle></svg>
	      Web Feed Preview
            </h1>
          </header>
          <h2><xsl:value-of select="atom:feed/atom:title"/></h2>
	  <hr/>
          <p><xsl:value-of select="atom:feed/atom:description"/></p>
          <p>This preview only shows titles, but the actual feed contains the full content.</p>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="/atom:feed/atom:link[not(@rel)]/@href"/>
            </xsl:attribute>
            Visit website →
          </a>
          <h2>Most Recent Articles</h2>
          <hr/>
          <xsl:apply-templates select="atom:feed/atom:entry" />
        </article>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:feed/atom:entry">
    <section>
      <h3>
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="atom:link/@href"/>
          </xsl:attribute>
          <xsl:value-of select="atom:title"/>
        </a>
      </h3>
      <small>
        <time property="datePublished"><xsl:value-of select="atom:updated" /></time>
      </small>
    </section>
  </xsl:template>
</xsl:stylesheet>
