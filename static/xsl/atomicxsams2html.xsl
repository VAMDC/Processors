<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xsams="http://vamdc.org/xml/xsams/1.0">

    <xsl:output method="html" indent="no" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:decimal-format name="fixnan" NaN="" />
    
    <xsl:key name="atomicState" match="/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState" use="@stateID"/>
    
    <!-- name of queried node -->
    <xsl:variable name="requestedNode" select="/xsams:XSAMSData/xsams:Sources/xsams:Source/xsams:Comments[contains(.,'is a self-reference')]/../@sourceID" />
    
    <!-- test if node exists or not to hide unwanted columns -->
    <xsl:variable name="stateRefCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:SourceRef)" />
    <xsl:variable name="radiativeTransitionRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:SourceRef)" />
    <xsl:variable name="wavelengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength)" />    
    <xsl:variable name="wavelengthRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength/xsams:SourceRef)" />    
    <xsl:variable name="wavenumberCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavenumber)" />
    <xsl:variable name="wavenumberRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavenumber/xsams:SourceRef)" />
    <xsl:variable name="energyCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Energy)" />
    <xsl:variable name="energyRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Energy/xsams:SourceRef)" />
    <xsl:variable name="frequencyCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Frequency)" />
    <xsl:variable name="frequencyRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Frequency/xsams:SourceRef)" />
    <xsl:variable name="transitionProbabilityCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:TransitionProbabilityA)" />
    <xsl:variable name="oscillatorStrengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:OscillatorStrength)" />
    <xsl:variable name="weightedOscillatorStrengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:WeightedOscillatorStrength)" />
    <xsl:variable name="log10WeightedOscillatorStrengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:Log10WeightedOscillatorStrength)" />      
    <xsl:variable name="stateDescriptionCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:Description)" />
    <xsl:variable name="stateEnergyCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:StateEnergy)" />
    <xsl:variable name="ionizationEnergyCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:IonizationEnergy)" />
    <xsl:variable name="lifeTimeCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:LifeTime)" />
    <xsl:variable name="statisticalWeightCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicNumericalData/xsams:StatisticalWeight)" />
    <xsl:variable name="parityCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicQuantumNumbers/xsams:Parity)" />
    <xsl:variable name="totalAngularMomentumCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum)" />
    <xsl:variable name="kappaCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicQuantumNumbers/xsams:Kappa)" />
    <xsl:variable name="hyperfineMomentumCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicQuantumNumbers/xsams:HyperfineMomentum)" />
    <xsl:variable name="magneticQuantumNumberCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicQuantumNumbers/xsams:MagneticQuantumNumber)" />
    <xsl:variable name="termLabelCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicComposition/xsams:Component/xsams:Term/xsams:TermLabel)" />
    <xsl:variable name="mixingCoefficientCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicComposition/xsams:Component/xsams:MixingCoefficient)" />
    <xsl:variable name="configurationLabelCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion/xsams:AtomicState/xsams:AtomicComposition/xsams:Component/xsams:Configuration/xsams:ConfigurationLabel)" />
    
    <xsl:variable name="termCouplingCount">      
      <xsl:choose>
        <xsl:when test="count(//xsams:LS)&gt;0 or count(//xsams:jj)&gt;0 or count(//xsams:J1J2)&gt;0 or count(//xsams:jK)&gt;0 or count(//xsams:LK)&gt;0">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
   
    <!-- end tests -->  

    
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
    
    <xsl:variable name="wavelengthUnit">
        <xsl:for-each select="/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength/xsams:Value/@units">
            <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
        </xsl:for-each>
    </xsl:variable>  
    
    <xsl:variable name="transitionEnergyUnit">
        <xsl:for-each select="/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Energy/xsams:Value/@units">
            <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
        </xsl:for-each>
    </xsl:variable>  
    
    <xsl:variable name="wavenumberUnit">
        <xsl:for-each select="/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavenumber/xsams:Value/@units">
            <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
        </xsl:for-each>
    </xsl:variable>  
    
    <xsl:variable name="frequencyUnit">
        <xsl:for-each select="/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Frequency/xsams:Value/@units">
            <xsl:if test="position()=1"><xsl:value-of select="."/></xsl:if>
        </xsl:for-each>
    </xsl:variable>    

              
    <xsl:template match="/xsams:XSAMSData">
        <!--  start html page-->
        <html xmlns="http://www.w3.org/1999/xhtml" lang="EN" dir="ltr">
            <head>
		    <link rel="stylesheet" href="/static/css/tablesorter.css" type="text/css" media="print, projection, screen" ></link>
		    <link rel="stylesheet" href="/static/css/display.css" type="text/css" media="print, projection, screen" ></link>
            </head>
            <body>
                <div id="page_actions">
                    <fieldset title="Actions">
                        <legend>Menu</legend>                        
                        <button id="csv_export">Export as CSV</button>
                        <button id="json_export">Export as JSON</button>
                        <button id="votable_export">Export as VOTable</button>
                        <input type="submit" id="votable_samp" value="Send with samp" />
                        <button id="reset" >Reset page</button>
                    </fieldset>
                </div>
                <div id="page_content">
                  <div>
                      <!-- ascii export area -->
                      <textarea id="result_export" rows="50" cols="150"></textarea>
                  </div>
                  <div>
                      <strong>Sources</strong>
                      <!--sources table -->
                      <table id="sources" class="tablesorter">
                          <thead>
                              <tr>
                                  <th>Id</th>
                                  <th>Title</th>
                                  <th>Origin</th>
                                  <th>Authors</th>
                                  <th>Year</th>
                                  <th>Link</th>
                              </tr>
                          </thead>
                          <tbody>
                              <xsl:for-each select="/xsams:XSAMSData/xsams:Sources/xsams:Source">
                                  <xsl:call-template name="fillSourcesTable">
                                      <xsl:with-param name="source" select="."/>
                                  </xsl:call-template>
                              </xsl:for-each>
                          </tbody>
                      </table>
                  </div>
                  
                  <div id="title">
                      <strong>Results from <span id="queried_node"><xsl:value-of select="substring(substring-before($requestedNode, '-'), 2)"/></span> VAMDC node</strong>
                  </div>                  
                  <div id="loader">
			  <img alt="loading" src='/static/img/loader_anim.gif'></img> <span> Please wait ... </span>
                  </div>
                  <div>
                      <!-- transitions table -->
                      <table id="transitions" class="tablesorter">
                          <thead>
                              <tr>                                
                                  <th id="c1"><span class="title"></span><button id="select_all_lines">Unselect all</button></th>
                                  <th id="c2"><span class="title">Spec Ion</span><div class="remove hideable"><button>X</button></div></th>
                                  
                                  <xsl:if test="$radiativeTransitionRefCount &gt; 0">
                                      <th id="c3"><span class="title">Transition reference</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                            
                                  
                                  <xsl:if test="$wavelengthCount &gt; 0">
                                      <th id="c4" data-unit="{$wavelengthUnit}"><span class="title">Wavelength (<xsl:value-of select="$wavelengthUnit" />)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                                  
                                  
                                  <xsl:if test="$wavelengthRefCount &gt; 0">
                                      <th id="c5"><span class="title">Wavelength reference</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$wavenumberCount &gt; 0">
                                      <th id="c6" data-unit="{$wavenumberUnit}"><span class="title">Wavenumber (<xsl:value-of select="$wavelengthUnit" />)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$wavenumberRefCount &gt; 0">
                                      <th id="c7"><span class="title">Wavenumber reference</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                                  
                                  
                                  <xsl:if test="$energyCount &gt; 0">
                                      <th id="c8" data-unit="{$transitionEnergyUnit}"><span class="title">Energy (<xsl:value-of select="$transitionEnergyUnit" />)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$energyRefCount &gt; 0">
                                      <th id="c9"><span class="title">Energy reference</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                                  
                                  
                                  <xsl:if test="$frequencyCount &gt; 0">
                                      <th id="c10" data-unit="{$frequencyUnit}"><span class="title">Frequency (<xsl:value-of select="$frequencyUnit" />)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$frequencyRefCount &gt; 0">
                                      <th id="c11"><span class="title">Frequency reference</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                                  
                                  
                                  <xsl:if test="$transitionProbabilityCount &gt; 0">
                                      <th id="c12"><span class="title">A</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$oscillatorStrengthCount &gt; 0">
                                      <th id="c13" ><span class="title">Oscillator Strength</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$weightedOscillatorStrengthCount &gt; 0">
                                      <th id="c14"><span class="title">Weighted Oscillator Strength</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                                   

                                  <xsl:if test="$log10WeightedOscillatorStrengthCount &gt; 0">
                                      <th id="c15"><span class="title">Log10 Weighted Oscillator Strength</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>                               
                                  
                                  <xsl:if test="$stateDescriptionCount &gt; 0">
                                      <th id="c16"><span class="title">Lower state description</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$stateRefCount &gt; 0">
                                      <th id="c17"><span class="title">Lower state source</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$stateEnergyCount &gt; 0">
                                      <th id="c18" data-unit="{$stateEnergyUnit}"><span class="title">Lower energy(<xsl:value-of select="$stateEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$ionizationEnergyCount &gt; 0">
                                      <th id="c19" data-unit="{$ionizationEnergyUnit}"><span class="title">Lower ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$lifeTimeCount &gt; 0">
                                      <th id="c20"><span class="title">Lower lifetime</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>       
                                  
                                  <xsl:if test="$statisticalWeightCount &gt; 0">
                                      <th id="c21"><span class="title">Lower statistical weight</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>       
                                  
                                  <xsl:if test="$parityCount &gt; 0">
                                      <th id="c22"><span class="title">Lower parity</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>           
                                  
                                  <xsl:if test="$totalAngularMomentumCount &gt; 0">    
                                      <th id="c23"><span class="title">Lower total angular momentum</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  
                                  <xsl:if test="$kappaCount &gt; 0">    
                                      <th id="c24"><span class="title">Lower kappa</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>           
                                  
                                  <xsl:if test="$hyperfineMomentumCount &gt; 0">   
                                      <th id="c25"><span class="title">Lower hyperfine momentum</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>    
                                  
                                  <xsl:if test="$magneticQuantumNumberCount &gt; 0">
                                      <th id="c26"><span class="title">Lower magnetic quantum number</span><div class="remove hideable"><button>X</button></div></th>		
                                  </xsl:if>    
                                  
                                  <xsl:if test="$mixingCoefficientCount &gt; 0">
                                      <th id="c27"><span class="title">Lower mixing coeff</span><div class="remove hideable"><button>X</button></div></th>     
                                  </xsl:if>   
                                  
                                  <xsl:if test="$configurationLabelCount &gt; 0">     
                                      <th id="c28"><span class="title">Lower configuration</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$termLabelCount &gt; 0">
                                      <th id="c29"><span class="title">Lower term label</span><div class="remove hideable"><button>X</button></div></th> 
                                  </xsl:if>  
                                  
                                  <xsl:if test="$termCouplingCount &gt; 0">
                                    <th id="c30"><span class="title">Lower coupling</span><div class="remove hideable"><button>X</button></div></th>   
                                  </xsl:if>
                                  
                                  <xsl:if test="$stateDescriptionCount &gt; 0">
                                      <th id="c31"><span class="title">Upper state description</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$stateRefCount &gt; 0">
                                      <th id="c32"><span class="title">Upper state source</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>   
                                  
                                  <xsl:if test="$stateEnergyCount &gt; 0">
                                      <th id="c33" data-unit="{$stateEnergyUnit}"><span class="title">Upper energy(<xsl:value-of select="$stateEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$ionizationEnergyCount &gt; 0">
                                      <th id="c34" data-unit="{$ionizationEnergyUnit}"><span class="title">Upper ionization(<xsl:value-of select="$ionizationEnergyUnit"/>)</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$lifeTimeCount &gt; 0">
                                      <th id="c35"><span class="title">Upper lifetime</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$statisticalWeightCount &gt; 0">
                                      <th id="c36"><span class="title">Upper statistical weight</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$parityCount &gt; 0">
                                      <th id="c37"><span class="title">Upper parity</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$totalAngularMomentumCount &gt; 0">    
                                      <th id="c38"><span class="title">Upper total angular momentum</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$kappaCount &gt; 0">    
                                      <th id="c39"><span class="title">Upper kappa</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>  
                                  
                                  <xsl:if test="$hyperfineMomentumCount &gt; 0">   
                                      <th id="c40"><span class="title">Upper hyperfine momentum</span><div class="remove hideable"><button>X</button></div></th>
                                  </xsl:if>
                                  
                                  <xsl:if test="$magneticQuantumNumberCount &gt; 0">
                                      <th id="c41"><span class="title">Upper magnetic quantum number</span><div class="remove hideable"><button>X</button></div></th>  
                                  </xsl:if>
                                  
                                  <xsl:if test="$mixingCoefficientCount &gt; 0">
                                      <th id="c42"><span class="title">Upper mixing coeff</span><div class="remove hideable"><button>X</button></div></th>      
                                  </xsl:if>
                                  
                                  <xsl:if test="$configurationLabelCount &gt; 0">
                                      <th id="c43"><span class="title">Upper configuration</span><div class="remove hideable"><button>X</button></div></th>   
                                  </xsl:if>
                                  
                                  <xsl:if test="$termLabelCount &gt; 0">
                                      <th id="c44"><span class="title">Upper term label</span><div class="remove hideable"><button>X</button></div></th>   
                                  </xsl:if>
                                  
                                  <xsl:if test="$termCouplingCount &gt; 0">
                                    <th id="c45"><span class="title">Upper coupling</span><div class="remove hideable"><button>X</button></div></th>   
                                  </xsl:if>
                              </tr>
                          </thead>
                          <tbody>    
                              <xsl:for-each select="/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition">
                                  <xsl:call-template name="fillTransitionTable">
                                      <xsl:with-param name="radTran" select="."/>
                                  </xsl:call-template>
                              </xsl:for-each>     
                          </tbody>        
                      </table>
                  </div>
                  <div class="hidden" id="sources_text">
                      <xsl:for-each select="/xsams:XSAMSData/xsams:Sources/xsams:Source">
                          <xsl:call-template name="getSourcesAsText">
                              <xsl:with-param name="source" select="."/>
                          </xsl:call-template>
                      </xsl:for-each>
                  </div>
              </div>
	      <script type="text/javascript" src="/static/js/jquery.js"></script>
	      <script type="text/javascript" src="/static/js/ajax_settings.js"></script>
	      <script type="text/javascript" src="/static/js/atomic_columns.js"></script>
	      <script type="text/javascript" src="/static/js/samp.js"></script>
	      <script type="text/javascript" src="/static/js/jquery.tablesorter.min.js"></script>
	      <script type="text/javascript" src="/static/js/xsl_transform.js"></script>
            </body>  	

        </html>
    </xsl:template>
    
    <!-- rows in source table -->
  <xsl:template name="fillSourcesTable">
    <xsl:param name="source"/>
    <xsl:if test="contains($source/xsams:Comments,'is a self-reference') = false()">
      <xsl:variable name="sourceId" select="$source/@sourceID"/>
      <xsl:variable name="sourceUri" select="$source/xsams:UniformResourceIdentifier"/>
      <tr>
        <td>
          <a name="{$sourceId}"><xsl:value-of select="$sourceId"/></a>
        </td>
        <td>
          <xsl:value-of select="$source/xsams:Title"/>
        </td>
        <td>
          <xsl:value-of select="$source/xsams:Category"/>
          <xsl:if test="count($source/xsams:SourceName) &gt; 0">
            : <xsl:value-of select="$source/xsams:SourceName"/>
          </xsl:if>
          <xsl:if test="count($source/xsams:Volume) &gt; 0">
            ( Vol : <xsl:value-of select="$source/xsams:Volume"/>
            <xsl:if test="count($source/xsams:PageBegin) &gt; 0">
              , Page Begin : <xsl:value-of select="$source/xsams:PageBegin"/>
            </xsl:if>
            <xsl:if test="count($source/xsams:PageEnd) &gt; 0">
              , Page End : <xsl:value-of select="$source/xsams:PageEnd"/>
            </xsl:if>
             )
          </xsl:if>
        </td>
        <td>
          <xsl:for-each select="$source/xsams:Authors/xsams:Author"><xsl:value-of select="xsams:Name"/>;
                    </xsl:for-each>
        </td>
        <td>
          <xsl:value-of select="$source/xsams:Year"/>
        </td>
        <td>
          <xsl:if test="count($source/xsams:UniformResourceIdentifier) &gt; 0">
          <a href="{$sourceUri}">
            <xsl:value-of select="$source/xsams:UniformResourceIdentifier"/>
          </a>
          </xsl:if>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
    
    <!--  -->
    <xsl:template name="getSourcesAsText">
        <xsl:param name="source"/>
        <xsl:variable name="sourceId" select="$source/@sourceID"/>
        <xsl:variable name="sourceUri" select="$source/xsams:UniformResourceIdentifier"/>
        <xsl:if test="contains($source/xsams:Comments,'is a self-reference') = false()">
#<xsl:value-of select="$sourceId"/>::<xsl:value-of select="$source/xsams:Title"/>::<xsl:value-of select="$source/xsams:Category"/>::<xsl:value-of select="$source/xsams:SourceName"/>::<xsl:for-each select="$source/xsams:Authors/xsams:Author"><xsl:value-of select="xsams:Name" />;</xsl:for-each>,<xsl:value-of select="$source/xsams:Year"/>::<xsl:value-of select="$source/xsams:UniformResourceIdentifier"/>
        </xsl:if>
    </xsl:template>
    
    <!-- rows in transitions table -->
    <xsl:template name="fillTransitionTable">
        <xsl:param name="radTran"/>
        <xsl:variable name="lowerStateId" select="$radTran/xsams:LowerStateRef"/>
        <xsl:variable name="upperStateId" select="$radTran/xsams:UpperStateRef"/>
        <xsl:variable name="lowerState" select="key('atomicState', $lowerStateId)"/>
        <xsl:variable name="upperState" select="key('atomicState', $upperStateId)"/>
        
        <tr class="table-line">          
            <td data-columnid="c1"><input type="checkbox" checked="checked" class="keep_line"/></td>
            <td data-columnid="c2">
                <a href="http://webbook.nist.gov/cgi/cbook.cgi?Units=SI&amp;InChI={$lowerState/../xsams:InChIKey}">
                <xsl:value-of select="$lowerState/../../../xsams:ChemicalElement/xsams:ElementSymbol"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="1 + $lowerState/../xsams:IonCharge"/>
                </a>                
            </td>
            
            <xsl:if test="$radiativeTransitionRefCount &gt; 0">
              <td data-columnid="c3">
                <xsl:for-each select="$radTran/xsams:SourceRef">
                  <xsl:call-template name="sourceLink">
                      <xsl:with-param name="SourceRef" select="." />
                  </xsl:call-template>
                </xsl:for-each>
              </td>
            </xsl:if>            
                      
            <xsl:if test="$wavelengthCount &gt; 0">
              <td data-columnid="c4">
                  <xsl:value-of select='$radTran/xsams:EnergyWavelength/xsams:Wavelength[1]/xsams:Value'/>
              </td>
            </xsl:if>       

            <xsl:if test="$wavelengthRefCount &gt; 0">
              <td data-columnid="c5">
                <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Wavelength[1]/xsams:SourceRef">
                  <xsl:call-template name="sourceLink">
                      <xsl:with-param name="SourceRef" select="." />
                  </xsl:call-template>
                </xsl:for-each>
              </td>
            </xsl:if>   
                                    
            <xsl:if test="$wavenumberCount &gt; 0">
                <td data-columnid="c6">
                    <xsl:value-of select='$radTran/xsams:EnergyWavelength/xsams:Wavenumber[1]/xsams:Value'/>
                </td>
            </xsl:if>
            
            <xsl:if test="$wavenumberRefCount &gt; 0">
              <td data-columnid="c7">
                <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Wavenumber[1]/xsams:SourceRef">
                  <xsl:call-template name="sourceLink">
                      <xsl:with-param name="SourceRef" select="." />
                  </xsl:call-template>
                </xsl:for-each>
              </td>
            </xsl:if>   
            
            <xsl:if test="$energyCount &gt; 0">
                <td data-columnid="c8">
                    <xsl:value-of select='$radTran/xsams:EnergyWavelength/xsams:Energy[1]/xsams:Value'/>
                </td>
            </xsl:if>
            
            <xsl:if test="$energyRefCount &gt; 0">
              <td data-columnid="c9">
                <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Energy[1]/xsams:SourceRef">
                  <xsl:call-template name="sourceLink">
                      <xsl:with-param name="SourceRef" select="." />
                  </xsl:call-template>
                </xsl:for-each>                      
                </td>
            </xsl:if>   
            
            <xsl:if test="$frequencyCount &gt; 0">
                <td data-columnid="c10">
                    <xsl:value-of select='$radTran/xsams:EnergyWavelength/xsams:Frequency[1]/xsams:Value'/>
                </td>
            </xsl:if>
            
            <xsl:if test="$frequencyRefCount &gt; 0">
              <td data-columnid="c11">
                <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Frequency[1]/xsams:SourceRef">
                  <xsl:call-template name="sourceLink">
                      <xsl:with-param name="SourceRef" select="." />
                  </xsl:call-template>
                </xsl:for-each>
                </td>
            </xsl:if>   
            
            <xsl:if test="$transitionProbabilityCount &gt; 0">
                <td data-columnid="c12">
                    <xsl:value-of select='$radTran/xsams:Probability/xsams:TransitionProbabilityA/xsams:Value'/>
                </td>			
            </xsl:if>
            
            <xsl:if test="$oscillatorStrengthCount &gt; 0">
                <td data-columnid="c13">
                    <xsl:value-of select='$radTran/xsams:Probability/xsams:OscillatorStrength/xsams:Value'/>
                </td>	
            </xsl:if>
            
            <xsl:if test="$weightedOscillatorStrengthCount &gt; 0">
                <td data-columnid="c14">
                    <xsl:value-of select='$radTran/xsams:Probability/xsams:WeightedOscillatorStrength/xsams:Value'/>
                </td>	
            </xsl:if>            

            <xsl:if test="$log10WeightedOscillatorStrengthCount &gt; 0">
                <td data-columnid="c15">
                    <xsl:value-of select='$radTran/xsams:Probability/xsams:Log10WeightedOscillatorStrength/xsams:Value'/>
                </td>
            </xsl:if>
            
            <xsl:if test="$stateDescriptionCount &gt; 0">
                <td data-columnid="c16">
                    <xsl:value-of select='$lowerState/xsams:Description'/>
                </td>      
            </xsl:if>     
            
            <xsl:if test="$stateRefCount &gt; 0">                
                <td data-columnid="c17">
                  <xsl:for-each select="$lowerState/xsams:SourceRef">
                    <xsl:call-template name="sourceLink">
                        <xsl:with-param name="SourceRef" select="." />
                    </xsl:call-template>
                  </xsl:for-each>   
                </td>
            </xsl:if>               
            
            <xsl:if test="$stateEnergyCount &gt; 0">
                <td data-columnid="c18">
                    <xsl:value-of select='$lowerState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value'/>
                </td>
            </xsl:if>     
            
            <xsl:if test="$ionizationEnergyCount &gt; 0">
                <td data-columnid="c19">
                    <xsl:value-of select='$lowerState/xsams:AtomicNumericalData/xsams:IonizationEnergy/xsams:Value'/>
                </td>
            </xsl:if>
            
            <xsl:if test="$lifeTimeCount &gt; 0">
                <td data-columnid="c20">
                    <xsl:value-of select='$lowerState/xsams:AtomicNumericalData/xsams:LifeTime/xsams:Value'/>		
                </td>
            </xsl:if>
            
            <xsl:if test="$statisticalWeightCount &gt; 0">
                <td data-columnid="c21">
                    <xsl:value-of select='$lowerState/xsams:AtomicNumericalData/xsams:StatisticalWeight'/>
                </td>			
            </xsl:if>
            
            <xsl:if test="$parityCount &gt; 0">
                <td data-columnid="c22">
                    <xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:Parity'/>				
                </td>
            </xsl:if>
            
            <xsl:if test="$totalAngularMomentumCount &gt; 0">
                <td data-columnid="c23">
                    <xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum'/>				
                </td>						
            </xsl:if>
            
            <xsl:if test="$kappaCount &gt; 0">   
                <td data-columnid="c24">
                    <xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:Kappa'/>
                </td>		
            </xsl:if>
            
            <xsl:if test="$hyperfineMomentumCount &gt; 0">   	
                <td data-columnid="c25">
                    <xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:HyperfineMomentum'/>				
                </td>	
            </xsl:if>		
            
            <xsl:if test="$magneticQuantumNumberCount &gt; 0">
                <td data-columnid="c26">
                    <xsl:value-of select='$lowerState/xsams:AtomicQuantumNumbers/xsams:MagneticQuantumNumber'/>				
                </td>	
            </xsl:if>
            
            <xsl:if test="$mixingCoefficientCount &gt; 0">
                <td data-columnid="c27">
                    <xsl:call-template name="mixingCoeff">
                        <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>
            </xsl:if>
            
            <xsl:if test="$configurationLabelCount &gt; 0"> 
                <td data-columnid="c28">
                    <xsl:call-template name="configuration">
                        <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>    
            </xsl:if>
            
            <xsl:if test="$termLabelCount &gt; 0"> 
                <td data-columnid="c29">
                    <xsl:call-template name="term">
                        <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>  
            </xsl:if>	
            
            <xsl:if test="$termCouplingCount &gt; 0">    
                <td data-columnid="c30">
                    <xsl:call-template name="coupling">
                        <xsl:with-param name="AtomicComposition" select="$lowerState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>  	
            </xsl:if>            
            
            <xsl:if test="$stateDescriptionCount &gt; 0">
                <td data-columnid="c31">
                    <xsl:value-of select='$upperState/xsams:Description'/>
                </td>  
            </xsl:if>	
            
            <xsl:if test="$stateRefCount &gt; 0">
                <td data-columnid="c32">
                  <xsl:for-each select="$upperState/xsams:SourceRef">
                    <xsl:call-template name="sourceLink">
                        <xsl:with-param name="SourceRef" select="." />
                    </xsl:call-template>
                  </xsl:for-each>
                </td>
            </xsl:if>          
            
            <xsl:if test="$stateEnergyCount &gt; 0">
                <td data-columnid="c33">
                    <xsl:value-of select='$upperState/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value'/>
                </td>
            </xsl:if>	
            
            <xsl:if test="$ionizationEnergyCount &gt; 0">
                <td data-columnid="c34">
                    <xsl:value-of select='$upperState/xsams:AtomicNumericalData/xsams:IonizationEnergy/xsams:Value'/>
                </td>
            </xsl:if>	
            
            <xsl:if test="$lifeTimeCount &gt; 0">
                <td data-columnid="c35">
                    <xsl:value-of select='$upperState/xsams:AtomicNumericalData/xsams:LifeTime/xsams:Value'/>
                </td>
            </xsl:if>	
            
            <xsl:if test="$statisticalWeightCount &gt; 0">
                <td data-columnid="c36">
                    <xsl:value-of select='$upperState/xsams:AtomicNumericalData/xsams:StatisticalWeight'/>
                </td>
            </xsl:if>	
            
            <xsl:if test="$parityCount &gt; 0">
                <td data-columnid="c37">
                    <xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:Parity'/>				
                </td>
            </xsl:if>	
            
            <xsl:if test="$totalAngularMomentumCount &gt; 0">
                <td data-columnid="c38">
                    <xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:TotalAngularMomentum'/>					
                </td>
            </xsl:if>							
            <xsl:if test="$kappaCount &gt; 0">
                <td data-columnid="c39">
                    <xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:Kappa'/>	
                </td>
            </xsl:if>		
            <xsl:if test="$hyperfineMomentumCount &gt; 0">			
                <td data-columnid="c40">
                    <xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:HyperfineMomentum'/>	
                </td>	
            </xsl:if>
            
            <xsl:if test="$magneticQuantumNumberCount &gt; 0">				
                <td data-columnid="c41">
                    <xsl:value-of select='$upperState/xsams:AtomicQuantumNumbers/xsams:MagneticQuantumNumber'/>				
                </td>
            </xsl:if>
            
            <xsl:if test="$mixingCoefficientCount &gt; 0">	
                <td data-columnid="c42">
                    <xsl:call-template name="mixingCoeff">
                        <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>
            </xsl:if>
            
            <xsl:if test="$configurationLabelCount &gt; 0">
                <td data-columnid="c43">
                    <xsl:call-template name="configuration">
                        <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>  
            </xsl:if>
            
            <xsl:if test="$termLabelCount &gt; 0">    
                <td data-columnid="c44">
                    <xsl:call-template name="term">
                        <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>  	
            </xsl:if>
            
            <xsl:if test="$termCouplingCount &gt; 0">    
                <td data-columnid="c45">
                    <xsl:call-template name="coupling">
                        <xsl:with-param name="AtomicComposition" select="$upperState/xsams:AtomicComposition" />
                    </xsl:call-template>
                </td>  	
            </xsl:if>
        </tr>		
    </xsl:template>
    
    <xsl:template name="sourceLink">
        <xsl:param name="SourceRef"/>
        <xsl:element name="a">
          <xsl:attribute name="href">
            <xsl:text>#</xsl:text>
            <xsl:value-of select="$SourceRef"/>
          </xsl:attribute>
          <xsl:value-of select="."/>
        </xsl:element>
        <xsl:text> </xsl:text>
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
    
    <xsl:template name="coupling">
        <xsl:param name="AtomicComposition"/>                    
        <xsl:for-each select="$AtomicComposition/xsams:Component">
            <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
            <xsl:if test="position() = 1">
              <xsl:if test="./xsams:Term/xsams:LS">L=<xsl:value-of select="./xsams:Term/xsams:LS/xsams:L/xsams:Value" /> S=<xsl:value-of select="./xsams:Term/xsams:LS/xsams:S" />
                <xsl:if test="./xsams:Term/xsams:LS/xsams:Multiplicity"> Multiplicity=<xsl:value-of select="./xsams:Term/xsams:LS/xsams:Multiplicity" /></xsl:if>
                <xsl:if test="./xsams:Term/xsams:LS/xsams:Seniority"> Seniority=<xsl:value-of select="./xsams:Term/xsams:LS/xsams:Seniority" /></xsl:if>
              </xsl:if>
              <xsl:if test="./xsams:Term/xsams:jj"><xsl:for-each select="./xsams:Term/xsams:jj/xsams:j"> j=<xsl:value-of select="."/></xsl:for-each></xsl:if>
              <xsl:if test="./xsams:Term/xsams:J1J2"><xsl:for-each select="./xsams:Term/xsams:J1J2/xsams:j"> j=<xsl:value-of select="."/></xsl:for-each></xsl:if>
              <xsl:if test="./xsams:Term/xsams:jK">
                <xsl:if test="./xsams:Term/xsams:jK/xsams:j"> j=<xsl:value-of select="./xsams:Term/xsams:jK/xsams:j" /></xsl:if>
                <xsl:if test="./xsams:Term/xsams:jK/xsams:S2"> S2=<xsl:value-of select="./xsams:Term/xsams:jK/xsams:S2" /></xsl:if> K=<xsl:value-of select="./xsams:Term/xsams:jK/xsams:K" />
              </xsl:if>
              <xsl:if test="./xsams:Term/xsams:LK">L=<xsl:value-of select="./xsams:Term/xsams:LK/xsams:L/xsams:Value" /> K=<xsl:value-of select="./xsams:Term/xsams:LK/xsams:K" />
                <xsl:if test="./xsams:Term/xsams:LK/xsams:S2"> S2=<xsl:value-of select="./xsams:Term/xsams:LK/xsams:S2" /></xsl:if>             
              </xsl:if>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
        
    <xsl:template match="text()|@*"/>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text/text()" name="tokenize">
        <xsl:param name="text" select="."/>
        <xsl:param name="separator" select="'-'"/>
        <xsl:choose>
            <xsl:when test="not(contains($text, $separator))">
                <item>
                    <xsl:value-of select="normalize-space($text)"/>
                </item>
            </xsl:when>
            <xsl:otherwise>
                <item>
                    <xsl:value-of select="normalize-space(substring-before($text, $separator))"/>
                </item>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="text" select="substring-after($text, $separator)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>     
</xsl:stylesheet>

