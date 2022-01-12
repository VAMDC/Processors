<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcs="http://vamdc.org/xml/xsams/1.0/cases/dcs" xmlns:asymcs="http://vamdc.org/xml/xsams/1.0/cases/asymcs" xmlns:asymos="http://vamdc.org/xml/xsams/1.0/cases/asymos" xmlns:gen="http://vamdc.org/xml/xsams/1.0/cases/gen" xmlns:hunda="http://vamdc.org/xml/xsams/1.0/cases/hunda" xmlns:hundb="http://vamdc.org/xml/xsams/1.0/cases/hundb" xmlns:lpcs="http://vamdc.org/xml/xsams/1.0/cases/lpcs" xmlns:lpos="http://vamdc.org/xml/xsams/1.0/cases/lpos" xmlns:ltos="http://vamdc.org/xml/xsams/1.0/cases/ltos" xmlns:ltcs="http://vamdc.org/xml/xsams/1.0/cases/ltcs" xmlns:nltcs="http://vamdc.org/xml/xsams/1.0/cases/nltcs" xmlns:nltos="http://vamdc.org/xml/xsams/1.0/cases/nltos" xmlns:sphcs="http://vamdc.org/xml/xsams/1.0/cases/sphcs" xmlns:sphos="http://vamdc.org/xml/xsams/1.0/cases/sphos" xmlns:stcs="http://vamdc.org/xml/xsams/1.0/cases/stcs" version="2.0">

    <xsl:strip-space elements="*"/> 
    
    <xsl:template name="caseValue">
	<xsl:param name="case"/>
	<xsl:if test="$case/@caseID = 'dcs'">
	    <xsl:call-template name="dcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'asymcs'">
	    <xsl:call-template name="asymcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'asymos'">
	    <xsl:call-template name="asymosCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'gen'">
	    <xsl:call-template name="genCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'hunda'">
	    <xsl:call-template name="hundaCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'hundb'">
	    <xsl:call-template name="hundbCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'lpcs'">
	    <xsl:call-template name="lpcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'lpos'">
	    <xsl:call-template name="lposCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'ltos'">
	    <xsl:call-template name="ltosCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'ltcs'">
	    <xsl:call-template name="ltcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'nltcs'">
	    <xsl:call-template name="nltcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'nltos'">
	    <xsl:call-template name="nltosCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'sphcs'">
	    <xsl:call-template name="sphcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'sphos'">
	    <xsl:call-template name="sphosCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/@caseID = 'stcs'">
	    <xsl:call-template name="stcsCase">
		<xsl:with-param name="case" select="$case"/>
	    </xsl:call-template>
	</xsl:if>
    </xsl:template>
    
    <!-- Test de chaque case -->
    
    <xsl:template name="stcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/stcs:QNs/stcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:li"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:l">
      <xsl:call-template name="displaylQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:l"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vibInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:K">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:K"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:rotSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:rovibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:I">
      <xsl:call-template name="displayIQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/stcs:QNs/stcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:parity"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="$case/stcs:QNs/stcs:tau">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:tau"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:if test="$case/stcs:QNs/stcs:epsilon">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:epsilon"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="sphosCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/sphos:QNs/sphos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:elecSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:li"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:rotSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:rovibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:sym">
      <xsl:call-template name="displaysymQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:sym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphos:QNs/sphos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:parity"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="sphcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/sphcs:QNs/sphcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:li"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:rotSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:rovibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:sym">
      <xsl:call-template name="displaysymQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:sym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/sphcs:QNs/sphcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:parity"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="nltosCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/nltos:QNs/nltos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:elecSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v3"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:Ka"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:Kc"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltos:QNs/nltos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="nltcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/nltcs:QNs/nltcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v3"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:Ka"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:Kc"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/nltcs:QNs/nltcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="ltosCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/ltos:QNs/ltos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:elecRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:Lambda"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:l2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:l2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v3"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltos:QNs/ltos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="ltcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/ltcs:QNs/ltcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:l2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:l2"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v3"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:J">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:J"/>
	</xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:I">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:I"/>
	</xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:F1">
    <xsl:call-template name="displaySimpleQn">
	<xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F1"/>
    </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:F2">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F2"/>
	</xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/ltcs:QNs/ltcs:F">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F"/>
	</xsl:call-template>
    </xsl:if>

    <xsl:if test="$case/ltcs:QNs/ltcs:r">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:r"/>
	</xsl:call-template>
    </xsl:if>

    <xsl:if test="$case/ltcs:QNs/ltcs:parity">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:parity"/>
	</xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:kronigParity">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:kronigParity"/>
	</xsl:call-template>
    </xsl:if>

    <xsl:if test="$case/ltcs:QNs/ltcs:asSym">
	<xsl:call-template name="displaySimpleQn">
	    <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:asSym"/>
	</xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="lposCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/lpos:QNs/lpos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:elecRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:Lambda"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:li"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:l">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:l"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vibInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:vibRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vibRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpos:QNs/lpos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- needs to be tested-->
  <xsl:template name="lpcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/lpcs:QNs/lpcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:li"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:l">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:l"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:vibRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:I">
      <xsl:call-template name="displayIQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/lpcs:QNs/lpcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- test OK -->
  <xsl:template name="hundbCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/hundb:QNs/hundb:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:elecRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:Lambda"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:v">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:v"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:SpinComponentLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:SpinComponentLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:F1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hundb:QNs/hundb:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- test OK-->
  <xsl:template name="hundaCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/hunda:QNs/hunda:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:elecRefl"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Lambda"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:Sigma">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Sigma"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:Omega">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Omega"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:v">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:v"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:F1"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:parity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:kronigParity"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/hunda:QNs/hunda:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:asSym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- test OK -->
  <xsl:template name="genCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/gen:QNs/gen:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/gen:QNs/gen:QN">
      <xsl:call-template name="displayGenericQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:QN"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/gen:QNs/gen:Sym">
      <xsl:call-template name="displayGenericQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:Sym"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- test OK-->
  <xsl:template name="asymosCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/asymos:QNs/asymos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:elecSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:elecInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:S"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vi"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vibInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:N"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Ka"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Kc"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:rotSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:rovibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymos:QNs/asymos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:parity"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- test OK-->
  <xsl:template name="asymcsCase">
    <xsl:param name="case"/>
    <xsl:if test="$case/asymcs:QNs/asymcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:ElecStateLabel"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:ElecStateLabel">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:v"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:vibInv"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:vibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:J"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Ka"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Kc"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:rotSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:rovibSym"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:I"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Fj"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:F"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:r"/>
      </xsl:call-template>
    </xsl:if>
    
    <xsl:if test="$case/asymcs:QNs/asymcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:parity"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
    <xsl:template name="dcsCase">
	<xsl:param name="case"/>
	<xsl:if test="$case/dcs:QNs/dcs:ElecStateLabel">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:ElecStateLabel"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:v">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:v"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:J">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:J"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:I">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:I"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:F1">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:F1"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:F">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:F"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:r">
	    <xsl:call-template name="displayrQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:r"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:parity">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:parity"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:kronigParity">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:kronigParity"/>
	    </xsl:call-template>
	</xsl:if>
	<xsl:if test="$case/dcs:QNs/dcs:asSym">
	    <xsl:call-template name="displaySimpleQn">
		<xsl:with-param name="qn" select="$case/dcs:QNs/dcs:asSym"/>
	    </xsl:call-template>
	</xsl:if>
    </xsl:template>


    <xsl:template name="displaySimpleQn">
	<xsl:param name="qn"/>
	<td><xsl:value-of select="$qn"/></td>
    </xsl:template>
    <xsl:template name="displayrQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	   <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displayvQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displayliQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displayIQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displaylSpinQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	   <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displayFjQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displayGenericQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displaylQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	   <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    <xsl:template name="displaysymQn">
	<xsl:param name="qn"/>
	<xsl:for-each select="$qn">
	    <td><xsl:value-of select="."/></td>
	</xsl:for-each>
    </xsl:template>
    
  </xsl:stylesheet>
