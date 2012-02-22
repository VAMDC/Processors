<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xsams="http://vamdc.org/xml/xsams/0.3">
    
    <xsl:output method="text" indent="no"/>
    <xsl:strip-space elements="*"/>
   
   <xsl:decimal-format name="fixnan" NaN="0" />

    <xsl:key name="atomicState" match="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState" use="@stateID"/>
    <xsl:key name="molecularState" match="/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState" use="@stateID"/>

    <xsl:variable name="newline"><xsl:text>
</xsl:text></xsl:variable>

    <xsl:template match="/xsams:XSAMSData/xsams:Processes/xsams:Radiative">

       <xsl:variable name="the_max">
         <xsl:for-each select="./xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength/xsams:Value">
           <xsl:sort data-type="number" order="descending"/>
           <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
         </xsl:for-each>
       </xsl:variable>
       <xsl:variable name="the_min">
         <xsl:for-each select="./xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength/xsams:Value">
           <xsl:sort data-type="number" order="ascending"/>
           <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
         </xsl:for-each>
       </xsl:variable>

        <xsl:value-of select="format-number($the_min,'###0000.0000')"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="format-number($the_max,'###0000.0000')"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="count(//xsams:RadiativeTransition)"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$newline"/>
        <xsl:value-of select="$newline"/>
        <xsl:value-of select="$newline"/>

        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="xsams:RadiativeTransition">
        <xsl:variable name="lowerStateId" select="xsams:LowerStateRef"/>
        <xsl:variable name="upperStateId" select="xsams:UpperStateRef"/>
                <xsl:variable name="lowerState" select="key('atomicState', $lowerStateId)"/>
                <xsl:variable name="upperState" select="key('atomicState', $upperStateId)"/>

                <xsl:text>'</xsl:text>
                <xsl:value-of select="$lowerState/../../../xsams:ChemicalElement/xsams:ElementSymbol"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="1 + $lowerState/../xsams:IonCharge"/>
                <xsl:text>', </xsl:text>
                <xsl:value-of select='format-number(./xsams:EnergyWavelength/xsams:Wavelength/xsams:Value, "###0000.0000", "fixnan")'/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select='format-number(1.239841930E-4 * $lowerState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value, "00.0000", "fixnan")'/>
                <xsl:text>, 0.0, </xsl:text>
                <xsl:value-of select='format-number(./xsams:Probability/xsams:Log10WeightedOscillatorStrength/xsams:Value, "0.000", "fixnan")'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='format-number(./xsams:Broadening[@name="natural"]/xsams:Lineshape[@name="lorentzian"]/xsams:LineshapeParameter[@name="log(gamma)"]/xsams:Value, "00.000", "fixnan")'/>
                <xsl:text>,</xsl:text>
                <xsl:value-of select='format-number(./xsams:Broadening[@name="pressure"]/xsams:Lineshape[@name="lorentzian"]/xsams:LineshapeParameter[@name="log(gamma)"]/xsams:Value, "0.000", "fixnan")'/>
                <xsl:text>,    0.000, 0.000, 0.000, ''</xsl:text>
                <xsl:value-of select="$newline"/>
    </xsl:template>
    <xsl:template match="text()|@*"/>
</xsl:stylesheet>
