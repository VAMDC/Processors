<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:svg="http://www.w3.org/2000/svg"
     version="1.0" xmlns:xsams="http://vamdc.org/xml/xsams/1.0">

  
  
  <xsl:template match="/">
    <svg:svg>
      <xsl:apply-templates/>
    </svg:svg>
  </xsl:template>

  <xsl:variable name="wlmin"><xsl:call-template name="wlmin"/></xsl:variable>
  <xsl:variable name="wlmax"><xsl:call-template name="wlmax"/></xsl:variable>
  <xsl:variable name="wlrange" select="$wlmax - $wlmin"/>
  <xsl:variable name="extent">1000</xsl:variable>
  

  <xsl:template match="xsams:Value[ancestor::xsams:Wavelength]">

    <!-- Work out the horizontal position for the line graphic. -->
    <xsl:variable name="scale"><xsl:value-of select="500 div $extent"/></xsl:variable>
    <xsl:variable name="x" select="((number(.) - $wlmin) * $extent div $wlrange) + 2"/>

    <!-- Set the label text. Include the wavelength and the source. -->
    <xsl:variable name="sourceref"><xsl:value-of select="ancestor::Experimental/@sourceRef"/></xsl:variable>
    <xsl:variable name="text">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="/XSAMSData/Sources/Source[@sourceID=$sourceref]/Authors/Author/Name"/>
    </xsl:variable>

    <!-- Draw the line. -->
    <xsl:element name="svg:line">
      <xsl:attribute name="x1"><xsl:value-of select="$x"/></xsl:attribute>
      <xsl:attribute name="x2"><xsl:value-of select="$x"/></xsl:attribute>
      <xsl:attribute name="y1">10</xsl:attribute>
      <xsl:attribute name="y1">60</xsl:attribute>
      <xsl:attribute name="style">stroke:#006600;</xsl:attribute>
    </xsl:element>

    <!-- Write a label under the line, rotated 60 degrees. -->
    <xsl:element name="svg:text">
      <xsl:attribute name="x"><xsl:value-of select="$x"/></xsl:attribute>
      <xsl:attribute name="y"><xsl:value-of select="70"/></xsl:attribute>
      <xsl:attribute name="transform">
        <xsl:text>rotate(60,</xsl:text>
        <xsl:value-of select="$x"/>
        <xsl:text>,70)</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="style">font-size:10px;</xsl:attribute>
      <xsl:value-of select="$text"/>
    </xsl:element>
      <xsl:element name="svg:text">
        <xsl:attribute name="x"><xsl:value-of select="$x"/></xsl:attribute>
        <xsl:attribute name="y"><xsl:value-of select="70"/></xsl:attribute>
        <xsl:attribute name="transform">
        <xsl:text>rotate(90,</xsl:text>
                <xsl:value-of select="$x"/>
                <xsl:text>,70)</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="style">font-size:10px;</xsl:attribute>
            <xsl:value-of select="Value"/>
        </xsl:element>
  </xsl:template>

  <!-- Finds the maximum wavelength of any line. -->
  <xsl:template name="wlmax">
    <xsl:for-each select="//xsams:Value[ancestor::xsams:Wavelength]">
      <xsl:sort data-type="number" order="descending" />
      <xsl:if test="position() = 1">
        <xsl:value-of select="number(.)" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <!-- Finds the minimum wavelength of any line. -->
  <xsl:template name="wlmin">
    <xsl:for-each select="//xsams:Value[ancestor::xsams:Wavelength]">
      <xsl:sort data-type="number" order="ascending" />
      <xsl:if test="position() = 1">
        <xsl:value-of select="number(.)" />
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="text()|attribute::*"/>

</xsl:stylesheet>
