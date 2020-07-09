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
        <html xmlns="http://www.w3.org/1999/xhtml" lang="EN" dir="ltr">
                <head>
                        <link rel="stylesheet" href="/css/tablesorter.css" type="text/css" media="print, projection, screen" ></link>
                        <link rel="stylesheet" href="/css/display.css" type="text/css" media="print, projection, screen" ></link>
                        <script type="text/javascript" src="/js/jquery.js"></script>
                        <script type="text/javascript" src="/js/ajax_settings.js"></script>
                        <script type="text/javascript" src="/js/jquery.tablesorter.min.js"></script>
                        <script type="text/javascript" src="/js/xsl_transform.js"></script>
                        <script type="text/javascript" src="/js/samp.js"></script>
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
    <p>
        <button id="reset">Reset page</button>
    </p>
    <p>
	<button id="csv_export">Show As Csv</button>
	</p>   
    <p>
        <input type="submit" id="votable_samp" value="Send with samp" />        
    </p>
    <div id="loader"> 
		<img alt="loading" src='/img/loader_anim.gif'></img> <span> Please wait ... </span>
	</div>
	<div> 
		<pre id="result_ascii"></pre>	
	</div>    
    <div>
        <table id="table" class="tablesorter">
            <thead>
            <tr>
                <th id="c1"><span class="title"></span><button id="select_all_lines">Unselect all</button></th>
                <th id="c2"><span class="title">Spec Ion</span><div class="remove hideable"><button>X</button></div></th>
				<th id="c2"><span class="title">Mass number</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c3"><span class="title">Wavelength(A)</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c4"><span class="title">Wavenumber</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c5"><span class="title">Energy</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c6"><span class="title">Frequency</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c7"><span class="title">A</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c8"><span class="title">Oscillator Strength</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c9"><span class="title">Weighted Oscillator Strength</span><div class="remove hideable"><button>X</button></div></th>                    
                <th id="c10"><span class="title">Lower state description</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c11"><span class="title">Lower energy(<xsl:value-of select="$stateEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c12"><span class="title">Lower ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c13"><span class="title">Lower lifetime</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c14"><span class="title">Lower statistical weight</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c15"><span class="title">Lower parity</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c16"><span class="title">Lower total angular momentum</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c17"><span class="title">Lower kappa</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c18"><span class="title">Lower hyperfine momentum</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c19"><span class="title">Lower magnetic quantum number</span><div class="remove hideable"><button>X</button></div></th>		
                <th id="c20"><span class="title">Lower mixing coeff</span><div class="remove hideable"><button>X</button></div></th>      
                <th id="c21"><span class="title">Lower configuration</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c22"><span class="title">Lower term</span><div class="remove hideable"><button>X</button></div></th>   
                
                <th id="c23"><span class="title">Upper state description</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c24"><span class="title">Upper energy(<xsl:value-of select="$stateEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c25"><span class="title">Upper ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c26"><span class="title">Upper lifetime</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c27"><span class="title">Upper statistical weight</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c28"><span class="title">Upper parity</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c29"><span class="title">Upper total angular momentum</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c30"><span class="title">Upper kappa</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c31"><span class="title">Upper hyperfine momentum</span><div class="remove hideable"><button>X</button></div></th>
                <th id="c32"><span class="title">Upper magnetic quantum number</span><div class="remove hideable"><button>X</button></div></th>  
                <th id="c33"><span class="title">Upper mixing coeff</span><div class="remove hideable"><button>X</button></div></th>      
                <th id="c34"><span class="title">Upper configuration</span><div class="remove hideable"><button>X</button></div></th>   
                <th id="c35"><span class="title">Upper term</span><div class="remove hideable"><button>X</button></div></th>   

            </tr>
            </thead>
            <tbody>
        <!-- end html -->
        
        <xsl:apply-templates/>
        
        
        <!-- start html -->
        <!-- close all tags -->
        </tbody>
        </table>
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
		<tr class="table-line">
            <td><input type="checkbox" checked="checked" class="keep_line"/></td>
			<td>
				<xsl:value-of select="$lowerState/../../../xsams:ChemicalElement/xsams:ElementSymbol"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="1 + $lowerState/../xsams:IonCharge"/>
			</td>

			<td>
				<xsl:value-of select="$lowerState/../../../xsams:Isotope/xsams:IsotopeParameters/xsams:MassNumber"/>
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
				<xsl:value-of select='$lowerState/xsams:Description'/>
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
                <xsl:call-template name="mixingCoeff">
                    <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="configuration">
                    <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                </xsl:call-template>
			</td>     
            <td>
                <xsl:call-template name="term">
                    <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                </xsl:call-template>
			</td>  	
            
			<td>
				<xsl:value-of select='$upperState/xsams:Description'/>
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
            <td>
                <xsl:call-template name="mixingCoeff">
                    <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="configuration">
                    <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                </xsl:call-template>
			</td>      
            <td>
                <xsl:call-template name="term">
                    <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                </xsl:call-template>
			</td>  	
		</tr>	
	
	</xsl:template>
    <xsl:template name="configuration">
        <xsl:param name="AtomicComposition"/>                    
                 <xsl:for-each select="$AtomicComposition/xsams:Component">
                <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
                    <xsl:if test="position() = 1">
                        <xsl:value-of select="./xsams:Configuration/xsams:ConfigurationLabel" />
                    </xsl:if>
                </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="mixingCoeff">
        <xsl:param name="AtomicComposition"/>                    
                 <xsl:for-each select="$AtomicComposition/xsams:Component">
                <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
                    <xsl:if test="position() = 1">
                        <xsl:value-of select="./xsams:MixingCoefficient" />
                    </xsl:if>
                </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="term">
        <xsl:param name="AtomicComposition"/>                    
                 <xsl:for-each select="$AtomicComposition/xsams:Component">
                <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
                    <xsl:if test="position() = 1">
                        <xsl:value-of select="./xsams:Term/xsams:TermLabel" />
                    </xsl:if>
                </xsl:for-each>
    </xsl:template>
    
	<xsl:template match="text()|@*"/>
</xsl:stylesheet>
