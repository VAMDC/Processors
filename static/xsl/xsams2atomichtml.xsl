<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xsams="http://vamdc.org/xml/xsams/1.0">
    
	<xsl:output method="html" indent="no"/>
	<xsl:strip-space elements="*"/>

	<xsl:decimal-format name="fixnan" NaN="" />

	<xsl:key name="atomicState" match="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState" use="@stateID"/>
	<xsl:key name="molecularState" match="/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState" use="@stateID"/>

	<xsl:variable name="newline"><xsl:text>
	</xsl:text></xsl:variable>
	
	<xsl:variable name="stateEnergyUnit">
	 <xsl:for-each select="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value/@units">
	   <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
	 </xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="ionizationEnergyUnit">
	 <xsl:for-each select="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:IonizationEnergy/xsams:Value/@units">
	   <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
	 </xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="component">
	 <xsl:for-each select="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicComposition">
	   <xsl:if test="position()=1"><xsl:value-of select="count(./Component)"/></xsl:if>
	 </xsl:for-each>
	</xsl:variable>

    <xsl:template match="/xsams:XSAMSData/xsams:Processes/xsams:Radiative">
		
	<!--  start html -->
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
		<head>
			<link rel="stylesheet" href="http://localhost:8000/static/css/tablesorter/style.css" type="text/css" media="print, projection, screen" />
			<script type="text/javascript" src="http://localhost:8000/static/js/jquery.js"></script>
			<script type="text/javascript" src="http://localhost:8000/static/js/jquery.tablesorter.min.js"></script>
			<script type="text/javascript" src="http://localhost:8000/static/js/xsl_transform.js"></script>
		</head>
	<body>
	<!-- end html -->
	
	
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

       
	<!-- start html -->
	<!-- table header -->
	<table id="myTable" class="tablesorter">
		<thead>
		<tr>
			<th id="c1">Spec Ion<div class="remove hideable"><button>X</button></div></th>
			<th id="c2">Wavelength(A)<div class="remove hideable"><button>X</button></div></th>
			<th id="c3">Wavenumber<div class="remove hideable"><button>X</button></div></th>
			<th id="c4">Energy<div class="remove hideable"><button>X</button></div></th>
			<th id="c5">Frequency<div class="remove hideable"><button>X</button></div></th>
			<th id="c6">A<div class="remove hideable"><button>X</button></div></th>
			<th id="c7">Oscillator Strength<div class="remove hideable"><button>X</button></div></th>
			<th id="c8">Weighted Oscillator Strength<div class="remove hideable"><button>X</button></div></th>
				
			<th id="c9">Lower energy(<xsl:value-of select="$stateEnergyUnit"/>)<div class="remove hideable"><button>X</button></div></th>
			<th id="c10">Lower ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)<div class="remove hideable"><button>X</button></div></th>
			<th id="c11">Lower lifetime<div class="remove hideable"><button>X</button></div></th>
			<th id="c12">Lower statistical weight<div class="remove hideable"><button>X</button></div></th>
			<th id="c13">Lower parity<div class="remove hideable"><button>X</button></div></th>
			<th id="c14">Lower total angular momentum<div class="remove hideable"><button>X</button></div></th>
			<th id="c15">Lower kappa<div class="remove hideable"><button>X</button></div></th>
			<th id="c16">Lower hyperfine momentum<div class="remove hideable"><button>X</button></div></th>
			<th id="c17">Lower magnetic quantum number<div class="remove hideable"><button>X</button></div></th>		
			
			<th id="c18">Upper energy(<xsl:value-of select="$stateEnergyUnit"/>)<div class="remove hideable"><button>X</button></div></th>
			<th id="c19">Upper ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)<div class="remove hideable"><button>X</button></div></th>
			<th id="c20">Upper lifetime<div class="remove hideable"><button>X</button></div></th>
			<th id="c21">Upper statistical weight<div class="remove hideable"><button>X</button></div></th>
			<th id="c22">Upper parity<div class="remove hideable"><button>X</button></div></th>
			<th id="c23">Upper total angular momentum<div class="remove hideable"><button>X</button></div></th>
			<th id="c24">Upper kappa<div class="remove hideable"><button>X</button></div></th>
			<th id="c25">Upper hyperfine momentum<div class="remove hideable"><button>X</button></div></th>
			<th id="c26">Upper magnetic quantum number<div class="remove hideable"><button>X</button></div></th>
			
			
		</tr>
		</thead>
		<tbody>
	<!-- end html -->
	
	<xsl:apply-templates/>
	
	
	<!-- start html -->
	<!-- close all tags -->
	</tbody>
	</table>

	<button id="export">Export</button>
	<button id="reset">Reset</button>
	<button id="result">Hide result</button>

	
	<div> 
		<pre id="result_ascii"></pre>	
	</div>

	</body>  	
	</html>
	<!-- end html -->
	
	
	</xsl:template>
	<xsl:template match="xsams:RadiativeTransition">
		<xsl:variable name="lowerStateId" select="xsams:LowerStateRef"/>
		<xsl:variable name="upperStateId" select="xsams:UpperStateRef"/>
		<xsl:variable name="lowerState" select="key('atomicState', $lowerStateId)"/>
		<xsl:variable name="upperState" select="key('atomicState', $upperStateId)"/>
		
		<!-- fill html table -->
		<tr>
			<td>
				<xsl:value-of select="$lowerState/../../../xsams:ChemicalElement/xsams:ElementSymbol"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="1 + $lowerState/../xsams:IonCharge"/>
			</td>

			<td>
				<xsl:value-of select='format-number(./xsams:EnergyWavelength/xsams:Wavelength/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>
			
			<td>
				<xsl:value-of select='format-number(./xsams:EnergyWavelength/xsams:Wavenumber/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>
			
			<td>
				<xsl:value-of select='format-number(./xsams:EnergyWavelength/xsams:Energy/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>
			
			<td>
				<xsl:value-of select='format-number(./xsams:EnergyWavelength/xsams:Frequency/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>
			
			<td>
				<xsl:value-of select='format-number(./xsams:Probability/xsams:TransitionProbabilityA/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>			
			
			<td>
				<xsl:value-of select='format-number(./xsams:Probability/xsams:OscillatorStrength/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>	
			
			<td>
				<xsl:value-of select='format-number(./xsams:Probability/xsams:WeightedOscillatorStrength/xsams:Value, "###0000.0000", "fixnan")'/>
			</td>	

			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value, "00.0000", "fixnan")'/>
			</td>

			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicNumericalData/xsams:IonizationEnergy/xsams:Value, "00.0000", "fixnan")'/>
			</td>

			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicNumericalData/xsams:LifeTime/xsams:Value, "00.0000", "fixnan")'/>				
			</td>
			
			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicNumericalData/xsams:StatisticalWeight, "00.0000", "fixnan")'/>
			</td>			
			
			<td>
				<xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:Parity'/>				
			</td>
			
			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum, "0.0", "fixnan")'/>				
			</td>						
			
			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicQuantumNumbers/xsams:Kappa, "0.0", "fixnan")'/>				
			</td>			
			<td>
				<xsl:value-of select='format-number($lowerState/xsams:AtomicQuantumNumbers/xsams:HyperfineMomentum, "0.0", "fixnan")'/>				
			</td>	
					
			<td>
				<xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:MagneticQuantumNumber'/>				
			</td>	
						
			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value, "00.0000", "fixnan")'/>
			</td>

			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicNumericalData/xsams:IonizationEnergy/xsams:Value, "00.0000", "fixnan")'/>
			</td>

			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicNumericalData/xsams:LifeTime/xsams:Value, "00.0000", "fixnan")'/>
			</td>

			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicNumericalData/xsams:StatisticalWeight, "00.0000", "fixnan")'/>
			</td>
			
			<td>
				<xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:Parity'/>				
			</td>
			
			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum, "0.0", "fixnan")'/>				
			</td>						
			
			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicQuantumNumbers/xsams:Kappa, "0.0", "fixnan")'/>				
			</td>			
			<td>
				<xsl:value-of select='format-number($upperState/xsams:AtomicQuantumNumbers/xsams:HyperfineMomentum, "0.0", "fixnan")'/>				
			</td>	
					
			<td>
				<xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:MagneticQuantumNumber'/>				
			</td>
			
			
		</tr>	
	
	</xsl:template>
	<xsl:template match="text()|@*"/>
</xsl:stylesheet>
