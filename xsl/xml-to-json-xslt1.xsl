<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:json="http://www.w3.org/2005/xpath-functions"
  exclude-result-prefixes="json">

  <xsl:output indent="yes" omit-xml-declaration="yes"/>

  <xsl:param name="debug-ast">false</xsl:param>

  <xsl:variable name="ast">
    <json>
      <value>
        <object>
          <TOKEN>{</TOKEN>
          <xsl:for-each select="/json:map/*">
            <xsl:apply-templates select="."/>
            <xsl:if test="following-sibling::*">
              <TOKEN>,</TOKEN>
            </xsl:if>
          </xsl:for-each>
          <TOKEN>}</TOKEN>
        </object>
      </value>
      <eof/>
    </json>
  </xsl:variable>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="$debug-ast = 'true'">
        <xsl:copy-of select="$ast"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$ast"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="json:map[not(@key)]">
    <object>
      <TOKEN>{</TOKEN>
      <xsl:for-each select="*">
        <xsl:apply-templates select="."/>
        <xsl:if test="following-sibling::*">
          <TOKEN>,</TOKEN>
        </xsl:if>
      </xsl:for-each>
      <TOKEN>}</TOKEN>
    </object>
  </xsl:template>

  <xsl:template match="json:map[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <object>
          <TOKEN>{</TOKEN>
          <xsl:for-each select="*">
            <xsl:apply-templates select="."/>
            <xsl:if test="following-sibling::*">
              <TOKEN>,</TOKEN>
            </xsl:if>
          </xsl:for-each>
          <TOKEN>}</TOKEN>
        </object>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="json:array[not(@key)]">
    <array>
      <TOKEN>[</TOKEN>
      <xsl:for-each select="*">
        <value>
          <xsl:apply-templates select="."/>
        </value>
        <xsl:if test="following-sibling::*">
          <TOKEN>,</TOKEN>
        </xsl:if>
      </xsl:for-each>
      <TOKEN>]</TOKEN>
    </array>
  </xsl:template>

  <xsl:template match="json:array[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <array>
          <TOKEN>[</TOKEN>
          <xsl:for-each select="*">
            <value>
              <xsl:apply-templates select="."/>
            </value>
            <xsl:if test="following-sibling::*">
              <TOKEN>,</TOKEN>
            </xsl:if>
          </xsl:for-each>
          <TOKEN>]</TOKEN>
        </array>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="json:string[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <string>
          <xsl:text>"</xsl:text>
          <xsl:value-of select="."/>
          <xsl:text>"</xsl:text>
        </string>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="json:number[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <number>
          <xsl:value-of select="."/>
        </number>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="json:boolean[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <TOKEN>
          <xsl:value-of select="."/>
        </TOKEN>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="json:null[@key]">
    <pair>
      <xsl:apply-templates select="@key"/>
      <value>
        <TOKEN>null</TOKEN>
      </value>
    </pair>
  </xsl:template>

  <xsl:template match="@key">
    <string>
      <xsl:text>"</xsl:text>
      <xsl:value-of select="."/>
      <xsl:text>"</xsl:text>
    </string>
    <TOKEN>:</TOKEN>
  </xsl:template>

</xsl:stylesheet>
