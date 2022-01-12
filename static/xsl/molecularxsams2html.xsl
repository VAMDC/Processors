<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsams="http://vamdc.org/xml/xsams/1.0" xmlns:dcs="http://vamdc.org/xml/xsams/1.0/cases/dcs" xmlns:asymcs="http://vamdc.org/xml/xsams/1.0/cases/asymcs" xmlns:asymos="http://vamdc.org/xml/xsams/1.0/cases/asymos" xmlns:gen="http://vamdc.org/xml/xsams/1.0/cases/gen" xmlns:hunda="http://vamdc.org/xml/xsams/1.0/cases/hunda" xmlns:hundb="http://vamdc.org/xml/xsams/1.0/cases/hundb" xmlns:lpcs="http://vamdc.org/xml/xsams/1.0/cases/lpcs" xmlns:lpos="http://vamdc.org/xml/xsams/1.0/cases/lpos" xmlns:ltos="http://vamdc.org/xml/xsams/1.0/cases/ltos" xmlns:ltcs="http://vamdc.org/xml/xsams/1.0/cases/ltcs" xmlns:nltcs="http://vamdc.org/xml/xsams/1.0/cases/nltcs" xmlns:nltos="http://vamdc.org/xml/xsams/1.0/cases/nltos" xmlns:sphcs="http://vamdc.org/xml/xsams/1.0/cases/sphcs" xmlns:sphos="http://vamdc.org/xml/xsams/1.0/cases/sphos" xmlns:stcs="http://vamdc.org/xml/xsams/1.0/cases/stcs" version="1.0">
  <xsl:output method="html" indent="no"/>
  <xsl:strip-space elements="*"/>
  <xsl:decimal-format name="fixnan" NaN=""/>
  <xsl:key name="molecularState" match="/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState" use="@stateID"/>
  <!-- name of queried node -->
  <xsl:variable name="requestedNode" select="/xsams:XSAMSData/xsams:Sources/xsams:Source/xsams:Comments[contains(.,'is a self-reference')]/../@sourceID"/>
  <xsl:variable name="radiativeTransitionRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:SourceRef)" />
  <xsl:variable name="wavelengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength)" />    
  <xsl:variable name="wavelengthRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavelength/xsams:SourceRef)" />    
  <xsl:variable name="wavenumberCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavenumber)" />
  <xsl:variable name="wavenumberRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Wavenumber/xsams:SourceRef)" />
  <xsl:variable name="energyCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Energy)" />
  <xsl:variable name="energyRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Energy/xsams:SourceRef)" />
  <xsl:variable name="frequencyCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Frequency)" />
  <xsl:variable name="frequencyRefCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:EnergyWavelength/xsams:Frequency/xsams:SourceRef)" />
  <xsl:variable name="transitionProbabilityCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:TransitionProbabilityA)"/>
  <xsl:variable name="oscillatorStrengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:OscillatorStrength)"/>
  <xsl:variable name="weightedOscillatorStrengthCount" select="count(/xsams:XSAMSData/xsams:Processes/xsams:Radiative/xsams:RadiativeTransition/xsams:Probability/xsams:WeightedOscillatorStrength)"/>
  <xsl:variable name="stateEnergyCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value)"/>
  <xsl:variable name="totalStatisticalWeightCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:MolecularStateCharacterisation/xsams:TotalStatisticalWeight)"/>
  <xsl:variable name="nuclearStatisticalWeightCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:MolecularStateCharacterisation/xsams:NuclearStatisticalWeight)"/>
  <xsl:variable name="parityCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:Parity)"/>
  <xsl:variable name="caseCount" select="count(/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:Case)"/>
  <xsl:variable name="ionChargeCount" select="count(//xsams:IonCharge)"/>
  <xsl:variable name="chemicalNameCount" select="count(//xsams:ChemicalName)"/>
  <xsl:variable name="stoichiometricFormulaCount" select="count(//xsams:StoichiometricFormula)"/>
  <xsl:variable name="ordinaryStructuralFormulaCount" select="count(//xsams:OrdinaryStructuralFormula)"/>
  
  <xsl:variable name="stateEnergyUnit">
    <xsl:for-each select="/xsams:XSAMSData/xsams:Species/xsams:Molecules/xsams:Molecule/xsams:MolecularState/xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value/@units">
      <xsl:if test="position()=1">
        <xsl:value-of select="."/>
      </xsl:if>
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
        <link rel="stylesheet" href="/static/css/tablesorter.css" type="text/css" media="print, projection, screen"/>
        <link rel="stylesheet" href="/static/css/display.css" type="text/css" media="print, projection, screen"/>
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

          <div id="title">
            <strong>Results from <span id="queried_node"><xsl:value-of select="substring(substring-before($requestedNode, '-'), 2)"/></span> VAMDC node</strong>
          </div>
          <div id="loader">
		  <img alt="loading" src="/static/img/loader_anim.gif"/>
            <span> Please wait ... </span>
          </div>
          <div>
            <!-- transitions table -->
            <table id="transitions" class="tablesorter">
              <thead>
                <tr>
                  <th id="c1">
                    <span class="title"/>
                    <button id="select_all_lines">Unselect all</button>
                  </th>
                  <xsl:if test="$chemicalNameCount &gt; 0">
                    <th id="c2">
                      <span class="title">Chemical name</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$ionChargeCount &gt; 0">
                    <th id="c3">
                      <span class="title">Ion charge</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$stoichiometricFormulaCount &gt; 0">
                    <th id="c4">
                      <span class="title">Stoichiometric formula</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$ordinaryStructuralFormulaCount &gt; 0">
                    <th id="c5">
                      <span class="title">Ordinary structural formula</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$wavelengthCount &gt; 0">
                    <th id="c6" data-unit="{$wavelengthUnit}">
                      <span class="title">Wavelength (<xsl:value-of select="$wavelengthUnit" />)</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$wavelengthRefCount &gt; 0">
                    <th id="c7">
                      <span class="title">Wavelength reference</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$radiativeTransitionRefCount &gt; 0">
                    <th id="c8">
                      <span class="title">Transition reference</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$wavenumberCount &gt; 0">
                    <th id="c9" data-unit="{$wavenumberUnit}">
                      <span class="title">Wavenumber</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$wavenumberRefCount &gt; 0">
                    <th id="c10">
                      <span class="title">Wavenumber reference</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$energyCount &gt; 0">
                    <th id="c11" data-unit="{$transitionEnergyUnit}">
                      <span class="title">Energy</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$energyRefCount &gt; 0">
                    <th id="c12">
                      <span class="title">Energy reference</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$frequencyCount &gt; 0">
                    <th id="c13" data-unit="{$frequencyUnit}">
                      <span class="title">Frequency</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$frequencyRefCount &gt; 0">
                    <th id="c14">
                      <span class="title">Frequency reference</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>                
                  <xsl:if test="$transitionProbabilityCount &gt; 0">
                    <th id="c15">
                      <span class="title">A</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$oscillatorStrengthCount &gt; 0">
                    <th id="c16">
                      <span class="title">Oscillator Strength</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$weightedOscillatorStrengthCount &gt; 0">
                    <th id="c17">
                      <span class="title">Weighted Oscillator Strength</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$stateEnergyCount &gt; 0">
                    <th id="c18" data-unit="{$stateEnergyUnit}">
                      <span class="title">Lower energy(<xsl:value-of select="$stateEnergyUnit"/>)</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$totalStatisticalWeightCount &gt; 0">
                    <th id="c19">
                      <span class="title">Lower total statistical weight</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$nuclearStatisticalWeightCount &gt; 0">
                    <th id="c20">
                      <span class="title">Lower nuclear statistical weight</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$parityCount &gt; 0">
                    <th id="c21">
                      <span class="title">Lower parity</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$caseCount &gt; 0">
                    <th id="c22">
                      <span class="title">Lower QNs</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$stateEnergyCount &gt; 0">
                    <th id="c23" data-unit="{$stateEnergyUnit}">
                      <span class="title">Upper energy(<xsl:value-of select="$stateEnergyUnit"/>)</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$totalStatisticalWeightCount &gt; 0">
                    <th id="c24">
                      <span class="title">Upper total statistical weight</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$nuclearStatisticalWeightCount &gt; 0">
                    <th id="c25">
                      <span class="title">Upper nuclear statistical weight</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$parityCount &gt; 0">
                    <th id="c26">
                      <span class="title">Upper parity</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
                  </xsl:if>
                  <xsl:if test="$caseCount &gt; 0">
                    <th id="c27">
                      <span class="title">Upper QNs</span>
                      <div class="remove hideable">
                        <button>X</button>
                      </div>
                    </th>
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
	<script type="text/javascript" src="/static/js/jquery.js"/>
	<script type="text/javascript" src="/static/js/ajax_settings.js"/>
	<script type="text/javascript" src="/static/js/molecular_columns.js"/>
	<script type="text/javascript" src="/static/js/samp.js"/>
	<script type="text/javascript" src="/static/js/jquery.tablesorter.min.js"/>
	<script type="text/javascript" src="/static/js/xsl_transform.js"/>
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
          <a href="{$sourceUri}" data-type="uri">
            <xsl:value-of select="$source/xsams:UniformResourceIdentifier"/>
          </a>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
    <xsl:template name="getSourcesAsText">
        <xsl:param name="source"/>
        <xsl:variable name="sourceId" select="$source/@sourceID"/>
        <xsl:variable name="sourceUri" select="$source/xsams:UniformResourceIdentifier"/>
        <xsl:if test="contains($source/xsams:Comments,'is a self-reference') = false()">
#<xsl:value-of select="$sourceId"/>::<xsl:value-of select="$source/xsams:Title"/>::<xsl:value-of select="$source/xsams:Category"/>::<xsl:value-of select="$source/xsams:SourceName"/>::<xsl:for-each select="$source/xsams:Authors/xsams:Author"><xsl:value-of select="xsams:Name" />;</xsl:for-each>,<xsl:value-of select="$source/xsams:Year"/>::<xsl:value-of select="$source/xsams:UniformResourceIdentifier"/>
        </xsl:if>
    </xsl:template>
  <xsl:template name="fillTransitionTable">
    <xsl:param name="radTran"/>
    <xsl:variable name="lowerStateId" select="$radTran/xsams:LowerStateRef"/>
    <xsl:variable name="upperStateId" select="$radTran/xsams:UpperStateRef"/>
    <xsl:variable name="lowerState" select="key('molecularState', $lowerStateId)"/>
    <xsl:variable name="upperState" select="key('molecularState', $upperStateId)"/>
    <tr class="table-line">
      <td data-columnid="c1">
        <input type="checkbox" checked="checked" class="keep_line"/>
      </td>
      <xsl:if test="$chemicalNameCount &gt; 0">
        <td data-columnid="c2">
          <a href="http://webbook.nist.gov/cgi/cbook.cgi?Units=SI&amp;InChI={$lowerState/../xsams:MolecularChemicalSpecies/xsams:InChIKey}">
            <xsl:value-of select="$lowerState/../xsams:MolecularChemicalSpecies/xsams:ChemicalName/xsams:Value"/>
          </a>
        </td>
      </xsl:if>
      <xsl:if test="$ionChargeCount &gt; 0">
        <td data-columnid="c3">
          <xsl:value-of select="$lowerState/../xsams:MolecularChemicalSpecies/xsams:IonCharge"/>
        </td>
      </xsl:if>
      <xsl:if test="$stoichiometricFormulaCount &gt; 0">
        <td data-columnid="c4">
          <xsl:value-of select="$lowerState/../xsams:MolecularChemicalSpecies/xsams:StoichiometricFormula"/>
        </td>
      </xsl:if>
      <xsl:if test="$ordinaryStructuralFormulaCount &gt; 0">
        <td data-columnid="c5">
          <xsl:value-of select="$lowerState/../xsams:MolecularChemicalSpecies/xsams:OrdinaryStructuralFormula/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$wavelengthCount &gt; 0">
        <td data-columnid="c6">
          <xsl:value-of select="$radTran/xsams:EnergyWavelength/xsams:Wavelength[1]/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$wavelengthRefCount &gt; 0">        
          <td data-columnid="c7">
            <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Wavelength[1]/xsams:SourceRef">
              <xsl:call-template name="sourceLink">
                  <xsl:with-param name="SourceRef" select="." />
              </xsl:call-template>
            </xsl:for-each>
          </td>
      </xsl:if>
      <xsl:if test="$radiativeTransitionRefCount &gt; 0">
        <td data-columnid="c8">
          <xsl:for-each select="$radTran/xsams:SourceRef">
            <xsl:call-template name="sourceLink">
                <xsl:with-param name="SourceRef" select="." />
            </xsl:call-template>
          </xsl:for-each>
        </td>
      </xsl:if>
      <xsl:if test="$wavenumberCount &gt; 0">
        <td data-columnid="c9">
          <xsl:value-of select="$radTran/xsams:EnergyWavelength/xsams:Wavenumber[1]/xsams:Value"/>          
        </td>
      </xsl:if>
      <xsl:if test="$wavenumberRefCount &gt; 0">        
        <td data-columnid="c10">
          <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Wavenumber[1]/xsams:SourceRef">
            <xsl:call-template name="sourceLink">
                <xsl:with-param name="SourceRef" select="." />
            </xsl:call-template>
          </xsl:for-each>
        </td>
      </xsl:if>
      <xsl:if test="$energyCount &gt; 0">
        <td data-columnid="c11">
          <xsl:value-of select="$radTran/xsams:EnergyWavelength/xsams:Energy[1]/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$energyRefCount &gt; 0">        
          <td data-columnid="c12">
            <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Energy[1]/xsams:SourceRef">
              <xsl:call-template name="sourceLink">
                  <xsl:with-param name="SourceRef" select="." />
              </xsl:call-template>
            </xsl:for-each>
          </td>
      </xsl:if>
      <xsl:if test="$frequencyCount &gt; 0">
        <td data-columnid="c13">
          <xsl:value-of select="$radTran/xsams:EnergyWavelength/xsams:Frequency[1]/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$frequencyRefCount &gt; 0">        
        <td data-columnid="c14">
          <xsl:for-each select="$radTran/xsams:EnergyWavelength/xsams:Frequency[1]/xsams:SourceRef">
            <xsl:call-template name="sourceLink">
                <xsl:with-param name="SourceRef" select="." />
            </xsl:call-template>
          </xsl:for-each>
        </td>
      </xsl:if>
      <xsl:if test="$transitionProbabilityCount &gt; 0">
        <td data-columnid="c15">
          <xsl:value-of select="$radTran/xsams:Probability/xsams:TransitionProbabilityA/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$oscillatorStrengthCount &gt; 0">
        <td data-columnid="c16">
          <xsl:value-of select="$radTran/xsams:Probability/xsams:OscillatorStrength/xsams:Value"/>          
        </td>
      </xsl:if>
      <xsl:if test="$weightedOscillatorStrengthCount &gt; 0">
        <td data-columnid="c17">
          <xsl:value-of select="$radTran/xsams:Probability/xsams:WeightedOscillatorStrength/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$stateEnergyCount &gt; 0">
        <td data-columnid="c18">
          <xsl:value-of select="$lowerState/xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$totalStatisticalWeightCount &gt; 0">
        <td data-columnid="c19">
          <xsl:value-of select="$lowerState/xsams:MolecularStateCharacterisation/xsams:TotalStatisticalWeight"/>
        </td>
      </xsl:if>
      <xsl:if test="$nuclearStatisticalWeightCount &gt; 0">
        <td data-columnid="c20">
          <xsl:value-of select="$lowerState/xsams:MolecularStateCharacterisation/xsams:NuclearStatisticalWeight"/>
        </td>
      </xsl:if>
      <xsl:if test="$parityCount &gt; 0">
        <td data-columnid="c21">
          <xsl:value-of select="$lowerState/xsams:Parity"/>
        </td>
      </xsl:if>
      <xsl:if test="$caseCount &gt; 0">
        <td data-columnid="c22">
          <xsl:call-template name="case">
            <xsl:with-param name="case" select="$lowerState/xsams:Case"/>
          </xsl:call-template>
        </td>
      </xsl:if>
      <xsl:if test="$stateEnergyCount &gt; 0">
        <td data-columnid="c23">
          <xsl:value-of select="$upperState/xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value"/>
        </td>
      </xsl:if>
      <xsl:if test="$totalStatisticalWeightCount &gt; 0">
        <td data-columnid="c24">
          <xsl:value-of select="$upperState/xsams:MolecularStateCharacterisation/xsams:TotalStatisticalWeight"/>
        </td>
      </xsl:if>
      <xsl:if test="$nuclearStatisticalWeightCount &gt; 0">
        <td data-columnid="c25">
          <xsl:value-of select="$upperState/xsams:MolecularStateCharacterisation/xsams:NuclearStatisticalWeight"/>
        </td>
      </xsl:if>
      <xsl:if test="$parityCount &gt; 0">
        <td data-columnid="c26">
          <xsl:value-of select="$upperState/xsams:Parity"/>
        </td>
      </xsl:if>
      <xsl:if test="$caseCount &gt; 0">
        <td data-columnid="c27">
          <xsl:call-template name="case">
            <xsl:with-param name="case" select="$upperState/xsams:Case"/>
          </xsl:call-template>
        </td>
      </xsl:if>
    </tr>
  </xsl:template>
  
  <!-- display source in a html link -->
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
  
  <xsl:template name="case">
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
    <xsl:if test="$case/@caseID = 'ltcs'">
      <xsl:call-template name="ltcsCase">
        <xsl:with-param name="case" select="$case"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/@caseID = 'ltos'">
      <xsl:call-template name="ltosCase">
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
  <!-- needs to be tested-->
  <xsl:template name="stcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'stcs:'"/>
    <xsl:if test="$case/stcs:QNs/stcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:li"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:l">
      <xsl:call-template name="displaylQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:l"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vibInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:K">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:K"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:rotSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:rovibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:I">
      <xsl:call-template name="displayIQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/stcs:QNs/stcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/stcs:QNs/stcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="sphosCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'sphos:'"/>
    <xsl:if test="$case/sphos:QNs/sphos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:elecSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:li"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:rotSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:rovibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:sym">
      <xsl:call-template name="displaysymQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:sym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphos:QNs/sphos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphos:QNs/sphos:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="sphcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'sphcs:'"/>
    <xsl:if test="$case/sphcs:QNs/sphcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:li"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:rotSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:rovibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:sym">
      <xsl:call-template name="displaysymQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:sym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/sphcs:QNs/sphcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/sphcs:QNs/sphcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="nltosCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'nltos:'"/>
    <xsl:if test="$case/nltos:QNs/nltos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:elecSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:v3"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:Ka"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:Kc"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltos:QNs/nltos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltos:QNs/nltos:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="nltcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'nltcs:'"/>
    <xsl:if test="$case/nltcs:QNs/nltcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:v3"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:Ka"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:Kc"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/nltcs:QNs/nltcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/nltcs:QNs/nltcs:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="ltosCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'ltos:'"/>
    <xsl:if test="$case/ltos:QNs/ltos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:elecRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:Lambda"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:l2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:l2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:v3"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltos:QNs/ltos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltos:QNs/ltos:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="ltcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'ltcs:'"/>
    <xsl:if test="$case/ltcs:QNs/ltcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:v1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:v2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:l2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:l2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:v3">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:v3"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:F2">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F2"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/ltcs:QNs/ltcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/ltcs:QNs/ltcs:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="lposCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'lpos:'"/>
    <xsl:if test="$case/lpos:QNs/lpos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:elecRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:Lambda"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:li"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:l">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:l"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vibInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:vibRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:vibRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpos:QNs/lpos:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpos:QNs/lpos:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- needs to be tested-->
  <xsl:template name="lpcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'lpcs:'"/>
    <xsl:if test="$case/lpcs:QNs/lpcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:li">
      <xsl:call-template name="displayliQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:li"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:l">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:l"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:vibRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:I">
      <xsl:call-template name="displayIQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/lpcs:QNs/lpcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/lpcs:QNs/lpcs:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test OK -->
  <xsl:template name="hundbCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'hundb:'"/>
    <xsl:if test="$case/hundb:QNs/hundb:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:elecRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:Lambda"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:v">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:v"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:SpinComponentLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:SpinComponentLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hundb:QNs/hundb:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hundb:QNs/hundb:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test OK-->
  <xsl:template name="hundaCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'hunda:'"/>
    <xsl:if test="$case/hunda:QNs/hunda:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:elecRefl">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:elecRefl"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:Lambda">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Lambda"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:Sigma">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Sigma"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:Omega">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:Omega"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:v">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:v"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:r">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/hunda:QNs/hunda:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/hunda:QNs/hunda:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test OK -->
  <xsl:template name="genCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'gen:'"/>
    <xsl:if test="$case/gen:QNs/gen:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/gen:QNs/gen:QN">
      <xsl:call-template name="displayGenericQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:QN"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/gen:QNs/gen:Sym">
      <xsl:call-template name="displayGenericQn">
        <xsl:with-param name="qn" select="$case/gen:QNs/gen:Sym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test OK-->
  <xsl:template name="asymosCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'asymos:'"/>
    <xsl:if test="$case/asymos:QNs/asymos:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:elecSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:elecSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:elecInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:elecInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:S">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:S"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:vi">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vi"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vibInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:N">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:N"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Ka"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Kc"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:rotSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:rovibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymos:QNs/asymos:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymos:QNs/asymos:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test OK-->
  <xsl:template name="asymcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'asymcs:'"/>
    <xsl:if test="$case/asymcs:QNs/asymcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:ElecStateLabel">
      <xsl:call-template name="displayvQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:v"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:vibInv">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:vibInv"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:vibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:vibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:Ka">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Ka"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:Kc">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Kc"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:rotSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:rotSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:rovibSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:rovibSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:Fj">
      <xsl:call-template name="displayFjQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:Fj"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/asymcs:QNs/asymcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/asymcs:QNs/asymcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <!-- test ok -->
  <xsl:template name="dcsCase">
    <xsl:param name="case"/>
    <xsl:variable name="caseName" select="'dcs:'"/>
    <xsl:if test="$case/dcs:QNs/dcs:ElecStateLabel">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:ElecStateLabel"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:v">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:v"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:J">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:J"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:I">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:I"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:F1">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:F1"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:F">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:F"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:r">
      <xsl:call-template name="displayrQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:r"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:parity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:parity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:kronigParity">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:kronigParity"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$case/dcs:QNs/dcs:asSym">
      <xsl:call-template name="displaySimpleQn">
        <xsl:with-param name="qn" select="$case/dcs:QNs/dcs:asSym"/>
        <xsl:with-param name="remove" select="$caseName"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="displaySimpleQn"><xsl:param name="qn"/><xsl:param name="remove"/><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template>=<xsl:value-of select="$qn"/><xsl:text> </xsl:text></xsl:template>
  <xsl:template name="displayrQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@name"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displayvQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@mode"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displayliQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@mode"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displayIQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@id"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displaylSpinQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@nuclearSpinRef"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displayFjQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@j"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displayGenericQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:value-of select="./@name"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displaylQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="displaysymQn">
    <xsl:param name="qn"/>
    <xsl:param name="remove"/>
    <xsl:for-each select="$qn"><xsl:call-template name="string-replace-all"><xsl:with-param name="text" select="name($qn)"/><xsl:with-param name="replace" select="$remove"/><xsl:with-param name="by" select="''"/></xsl:call-template><xsl:value-of select="./@name"/>=<xsl:value-of select="."/><xsl:text> </xsl:text></xsl:for-each>
  </xsl:template>
  <xsl:template name="string-replace-all">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="by"/>
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$by"/>
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text" select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="by" select="$by"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>

