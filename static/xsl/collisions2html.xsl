<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:xsams="http://vamdc.org/xml/xsams/1.0">
    <xsl:import href="caseValue.xsl"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:output method="html" indent="no"/>
    
    <!-- name of queried node -->
    <xsl:variable name="requestedNode" select="/xsams:XSAMSData/xsams:Sources/xsams:Source[1]/xsams:SourceName" />
    <xsl:variable name="sets"/>
    <xsl:variable name="firstColTran"/>
    <xsl:variable name="transition"/>
    <xsl:variable name="stateRef"/>
    <xsl:variable name="atomPos"/>
    <xsl:variable name="rateLink"/>
    
    <xsl:template match="/">
	<!-- call the function which allows to group the collisions by the comments -->   
	<xsl:variable name="sets">
	   <xsl:element name="XSAMSData">
		<xsl:apply-templates mode="buildXsams"/>
	    </xsl:element>
	</xsl:variable>
	
	<!--display in html-->
	<html xmlns="http://www.w3.org/1999/xhtml" lang="EN" dir="ltr">
	    <head>
		
		<link rel="stylesheet" href="/css/tablesorter.css" type="text/css" media="print, projection, screen" ></link>
                <link rel="stylesheet" href="/css/display_collisions.css" type="text/css" media="print, projection, screen" ></link>
                <link rel="stylesheet" href="/css/switch.css" type="text/css" media="print, projection, screen" ></link>
                <script type="text/javascript" src="/js/jquery.js"></script>
                <meta charset="utf-8"/>
	    </head>
	    
	    <body>
		
		<div id="page_actions">
                    <fieldset title="Actions">
                        <legend>Actions</legend>
                        <button id="reset" >Reset page</button>
                        <button id="csv_export">Show As Csv</button>
                        <!--<input type="submit" id="votable_samp" value="Send with samp" />-->
                    </fieldset>
		</div>
		
		<div id="title">
                    <h1>Results from <span id="queried_node"><xsl:value-of select="$requestedNode"/></span> VAMDC node</h1>
                </div>
                
                <div id="loader">
                    <img alt="loading" src='/img/loader_anim.gif'></img> <span> Please wait ... </span>
                </div>
                <div>
                    <!-- ascii export area -->
                    <pre id="result_ascii"></pre>
                </div>
		<div id="switch">
		    <ul>
			<xsl:for-each select="$sets/XSAMSData/Processes/Rate">
			    <xsl:variable name="firstColTran" select="@id"/>
			    <li class="ascenseur">
				<a><xsl:value-of select="position()"/>: <xsl:value-of select="xsams:CollisionalTransition[@id = $firstColTran]/xsams:Comments"/>
				</a>
				<ul>
				    <xsl:variable name="idt" select="concat('trans',generate-id())"/>
				    <li class="ascenseur2">
					<a>Rate Coefficients</a>
					<xsl:call-template name="rateCoeff">
					    <xsl:with-param name="firstCol" select="$firstColTran"/>
					    <xsl:with-param name="idt" select="$idt"/>
					</xsl:call-template>
				    </li>
				    <xsl:call-template name="energyTable">
					<xsl:with-param name="firstCol" select="$firstColTran"/>
				    </xsl:call-template>
				</ul>
			    </li>
			</xsl:for-each>
		   </ul>
		   <div class="clear"></div><!-- This empty div is used to clear the floated list items -->
		</div>
		
		<script type="text/javascript" src="/js/ajax_settings.js"></script>
		<script type="text/javascript" src="/js/samp.js"></script>
		<script type="text/javascript" src="/js/jquery.tablesorter.min.js"></script>
		<script type="text/javascript" src="/js/table_to_csv.js"></script>
	    </body>
	</html>
    </xsl:template>    
    
    <!-- create rate coefficient table -->
    <xsl:template name="rateCoeff">
	<xsl:param name="firstCol"/>
	<xsl:param name="idt"/>
        <xsl:param name="methodId"/>
	<div id="{$idt}" class="content">
            <xsl:call-template name="sourcesTable">
     		<xsl:with-param name="idt" select="$idt"/>
                <xsl:with-param name="sourceBranch" select="../../xsams:Sources"/>
  		<xsl:with-param name="methodBranch" select="../../xsams:Methods"/>		
		<xsl:with-param name="methodId" select="xsams:CollisionalTransition[@id = $firstCol]/@methodRef"/>
            </xsl:call-template>
	    <h3>Rate Coefficients of <xsl:value-of select="xsams:CollisionalTransition[@id = $firstCol]/xsams:Comments"/></h3>
	    <table  id="{$idt}" class="tablesorter">
		<thead>
		    <tr>
			<th id="c1_{$idt}"><span class="title"></span><button id="select_all_lines_{$idt}">Unselect all</button></th>
			<xsl:for-each select="xsams:CollisionalTransition[@id = $firstCol]/xsams:Reactant">
			    <xsl:variable name="i" select="position()" />
			    <th>
				    <span class="title"><xsl:value-of select="concat('I', $i)"/></span>
			    </th>
			</xsl:for-each>
			
			<xsl:for-each select="xsams:CollisionalTransition[@id = $firstCol]/xsams:Product">
			    <xsl:variable name="j" select="position()" />
			    <th>  
				<span class="title"><xsl:value-of select="concat('F', $j)"/></span>
			    </th>
			</xsl:for-each>
			
			<xsl:call-template name="splitTemperatures">
			    <xsl:with-param name="text" select="xsams:CollisionalTransition[@id = $firstCol]/xsams:DataSets/xsams:DataSet[@dataDescription ='rateCoefficient']/xsams:TabulatedData/xsams:X"/>
			</xsl:call-template>
		    </tr>
		</thead>
		
		<tbody>
		<xsl:for-each select="xsams:CollisionalTransition">
		    <xsl:variable name="cid" select="generate-id()"/>
		    <tr class="table-line">
			<td data-columnid="c1_{$idt}_{$cid}"><input type="checkbox" checked="checked" class="keep_line"/></td>
			<xsl:for-each select="xsams:Reactant">
			    <td ><xsl:value-of select="substring-after(xsams:StateRef, '-')"/></td>
			</xsl:for-each>
			
			<xsl:for-each select="xsams:Product">
			    <td ><xsl:value-of select="substring-after(xsams:StateRef, '-')"/></td>
			</xsl:for-each>
			
			<xsl:call-template name="splitRates">
			    <xsl:with-param name="text" select="xsams:DataSets/xsams:DataSet[@dataDescription ='rateCoefficient']/xsams:TabulatedData/xsams:Y/xsams:DataList"/>
			</xsl:call-template>
		    </tr>
		</xsl:for-each>
		</tbody>
	    </table>
	</div>
    </xsl:template>

    <!-- create sources table-->
    <xsl:template name="sourcesTable">
	<xsl:param name="idt"/>
	<xsl:param name="methodId"/>
	<xsl:param name="methodBranch"/>
        <xsl:param name="sourceBranch"/>
        <h3>Sources</h3>
	<table id="sources_{$idt}" class="tablesorter">
	    <thead>
	       <tr>
	          <th class="title">Id</th>
		  <th class="title">Title</th>
		  <th class="title">Origin</th>
		  <th class="title">Authors</th>
		  <th class="title">Year</th>
		  <th class="title">Link</th>
	       </tr>
	    </thead>

	    <tbody>
	    
	       	<xsl:for-each select="$methodBranch/xsams:Method[@methodID=$methodId]/xsams:SourceRef">
		    <xsl:variable name="sourceRef">
			<xsl:value-of select="."/>
		    </xsl:variable>
		    <xsl:call-template name="getSource">
			<xsl:with-param name="sourceRef" select="$sourceRef"/>
			<xsl:with-param name="sourceBranch" select="$sourceBranch"/>
		    </xsl:call-template>
		</xsl:for-each>
              
	    </tbody>
       	</table>
    </xsl:template>

    <!-- get sources by sourceID in the method -->
    <xsl:template name="getSource">
       <xsl:param name="sourceRef"/>
       <xsl:param name="sourceBranch"/>
       <xsl:if test="$sourceBranch/xsams:Source/@sourceID = $sourceRef">
       <tr class="table-line">
	  <td><xsl:value-of select="$sourceRef"/></td>
	  <td><xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:Title"/></td>
	  <td><xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:Category"/>:<xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:SourceName"/>,Vol:<xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:Volume"/>,Page Begin:<xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:PageBegin"/></td>
	  <td><xsl:for-each select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:Authors/xsams:Author">
	         <xsl:value-of select="concat(xsams:Name,';')"/>
	      </xsl:for-each>
	  </td>
	  <td ><xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:Year"/></td>
	  <td ><xsl:value-of select="$sourceBranch/xsams:Source[@sourceID = $sourceRef]/xsams:UniformResourceIdentifier"/></td>
       </tr>
       </xsl:if>
    </xsl:template>


    
    <!-- create table energy for molecules and the atoms -->
    <xsl:template name="energyTable">
	<xsl:param name="firstCol"/>
	<xsl:for-each select="xsams:CollisionalTransition[@id = $firstCol]/xsams:Reactant">
		    
	    <xsl:variable name="stateRef">
		<xsl:value-of select="xsams:StateRef"/>
	    </xsl:variable>
	    
	    <xsl:variable name="speciesRef">
		<xsl:value-of select="xsams:SpeciesRef"/>
	    </xsl:variable>
	    
	    <xsl:variable name="numAtomicState">
		<xsl:value-of select="count(../../../../xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion[@speciesID = $speciesRef]/xsams:AtomicState[@stateID = $stateRef])"/>
	    </xsl:variable>
	    
	    <xsl:variable name="unitAtomicStateEnergy">
		<xsl:value-of select="../../../../xsams:Species/xsams:Atoms/xsams:Atom/xsams:Isotope/xsams:Ion[@speciesID = $speciesRef]/xsams:AtomicState[@stateID = $stateRef]/xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value/@units"/>
	    </xsl:variable>
	    
	    <xsl:variable name="numMolecularState">
		<xsl:value-of select="count(../../../../xsams:Species/xsams:Molecules/xsams:Molecule[@speciesID = $speciesRef]/xsams:MolecularState[@stateID = $stateRef])"/>
	    </xsl:variable>
	    
	    <xsl:variable name="unitMolecularStateEnergy">
		<xsl:value-of select="../../../../xsams:Species/xsams:Molecules/xsams:Molecule[@speciesID = $speciesRef]/xsams:MolecularState[@stateID = $stateRef]/xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value/@units"/>
	    </xsl:variable>
	    
	    <xsl:variable name="numP">
		<xsl:value-of select="count(../../../../xsams:Species/xsams:Particles/xsams:Particle[@speciesID = $speciesRef])"/>
	    </xsl:variable>
	    
	    <xsl:variable name="ide" select="concat('e',generate-id())"/>
	    <li id="{$ide}" class="ascenseur2">
            <xsl:call-template name="energyTableAtom">
                <xsl:with-param name="numAtom" select="$numAtomicState"/>
                <xsl:with-param name="unitAtomE" select="$unitAtomicStateEnergy"/>
                <xsl:with-param name="spRef" select="$speciesRef"/>
                <xsl:with-param name="stRef" select="$stateRef"/>
            </xsl:call-template>
            
            <xsl:call-template name="energyTableMol">
                <xsl:with-param name="numMol" select="$numMolecularState"/>
                <xsl:with-param name="unitMolE" select="$unitMolecularStateEnergy"/>
                <xsl:with-param name="spRef" select="$speciesRef"/>
                <xsl:with-param name="stRef" select="$stateRef"/>
            </xsl:call-template> 
            
            <xsl:call-template name="energyTablePart">
                <xsl:with-param name="numParticle" select="$numP"/>
                <xsl:with-param name="spRef" select="$speciesRef"/>
            </xsl:call-template> 
	    </li>
	</xsl:for-each>
    </xsl:template>
    
    <!-- create table energy for Particle -->
    <xsl:template name="energyTablePart">
    <xsl:param name="numParticle"/>
    <xsl:param name="spRef"/>
    
	<xsl:if test="$numParticle != 0">
        <xsl:variable name="title">
            <xsl:value-of select="../../../../xsams:Species/xsams:Particles/xsams:Particle[@speciesID = $spRef]/@name"/>
	    </xsl:variable>
	    <xsl:variable name="idep" select="concat('ep',generate-id())"/>
	    <a>Energy Table of <xsl:value-of select="$title"/></a>
	    <div id="{$idep}" class="content">
		<xsl:for-each select="../../../../xsams:Species/xsams:Particles/xsams:Particle">
			<h3>Energy Table of: <span id="queried_node"><xsl:value-of select="$title"/> </span></h3>
		</xsl:for-each>
		<table id="{$idep}" class="tablesorter">
		    <thead>
			<th id="c1_{$idep}"><span class="title"></span><button id="select_all_lines_{$idep}">Unselect all</button></th>
			<th><span class="title">State</span></th>
			<th><span class="title">Energy [cm-1]</span></th>
			<th><span class="title">Degeneracy</span></th>
			<th><span class="title">S</span></th>
		    </thead>
		    <tbody>
			<xsl:variable name="cid1" select="generate-id()"/>
			<tr class="table-line">
			    <td data-columnid="c1_{$idep}_{$cid1}"><input type="checkbox" checked="checked" class="keep_line"/></td>
			    <td>1</td>
			    <td>0.0</td>
			    <td></td>
			    <td><xsl:value-of select="../../../../xsams:Species/xsams:Particles/xsams:Particle/xsams:ParticleProperties/xsams:ParticleSpin"/></td>
			</tr>
		    </tbody>
		</table>
	    </div>
	</xsl:if>
    </xsl:template>
    
    <!-- create table energy for atoms -->
    <xsl:template name="energyTableAtom">
	<xsl:param name="numAtom"/>
	<xsl:param name="unitAtomE"/>
	<xsl:param name="spRef"/>
	<xsl:param name="stRef"/>
	
	<xsl:if test="$numAtom != 0">
	    <xsl:variable name="atomPos">
		<xsl:call-template name="getAtomPosition">
		    <xsl:with-param name="spRef" select="$spRef"/>
		</xsl:call-template>
	    </xsl:variable>
	    <xsl:variable name="idea" select="concat('ea',generate-id())"/>
	    <xsl:for-each select="../../../../xsams:Species/xsams:Atoms/xsams:Atom">
		<xsl:if test="position() = $atomPos">
		    <a>Energy Table of <xsl:value-of select="xsams:ChemicalElement/xsams:ElementSymbol"/></a>
		</xsl:if>
	    </xsl:for-each>
	    <div id="{$idea}" class="content">
		<xsl:for-each select="../../../../xsams:Species/xsams:Atoms/xsams:Atom">
		    <xsl:if test="position() = $atomPos">
			<h3>Energy Table of: <span id="queried_node"><xsl:value-of select="xsams:ChemicalElement/xsams:ElementSymbol"/> </span></h3>
		    </xsl:if>
		</xsl:for-each>
		<table id="{$idea}" class="tablesorter">
		    <thead>
			<th id="c1_{$idea}"><span class="title"></span><button id="select_all_lines_{$idea}">Unselect all</button></th>
			<th><span class="title">State</span></th>
			<th><span class="title">Energy [<xsl:value-of select="$unitAtomE"/>]</span></th>
			<th> <span class="title">Degeneracy</span></th>
			<xsl:for-each select="../../../../xsams:Species/xsams:Atoms/xsams:Atom[$atomPos]/xsams:Isotope/xsams:Ion[@speciesID = $spRef]/xsams:AtomicState[@stateID = $stRef]">
			    <xsl:if test="position()=1">
				<xsl:call-template name="couplingTitle">
				    <xsl:with-param name="AtomicComposition" select="xsams:AtomicComposition"/>
				</xsl:call-template>
			    </xsl:if>
			</xsl:for-each>
		    </thead>
		    <tbody>
		    <xsl:for-each select="../../../../xsams:Species/xsams:Atoms/xsams:Atom[$atomPos]/xsams:Isotope/xsams:Ion[@speciesID = $spRef]/xsams:AtomicState">
			<xsl:variable name="cid1" select="generate-id()"/>
			<tr class="table-line">
			    <td data-columnid="c1_{$idea}_{$cid1}"><input type="checkbox" checked="checked" class="keep_line"/></td>
			    <td><xsl:value-of select="substring-after(@stateID, '-')"/></td>
			    <td><xsl:value-of select="xsams:AtomicNumericalData/xsams:StateEnergy/xsams:Value"/></td>
			    <td><xsl:value-of select="xsams:AtomicNumericalData/xsams:StatisticalWeight"/></td>
			    <xsl:call-template name="couplingValues">
				<xsl:with-param name="AtomicComposition" select="xsams:AtomicComposition"/>
			    </xsl:call-template>
			</tr>
		    </xsl:for-each>
		    </tbody>
		</table>
	    </div>
	</xsl:if>
    </xsl:template>
    
    <!-- create table energy for the molecules -->
    <xsl:template name="energyTableMol">
	<xsl:param name="numMol"/>
	<xsl:param name="unitMolE"/>
	<xsl:param name="spRef"/>
	<xsl:param name="stRef"/>
	<xsl:if test="$numMol != 0">
	    <xsl:variable name="title">
		<xsl:value-of select="../../../../xsams:Species/xsams:Molecules/xsams:Molecule[@speciesID = $spRef]/xsams:MolecularChemicalSpecies/xsams:ChemicalName"/>
	    </xsl:variable>
	    <xsl:variable name="idem" select="concat('em',generate-id())"/>
	    <a>Energy Table of <xsl:value-of select="$title"/></a>
	    <div id="{$idem}" class="content">
		<h3>Energy Table of: <span id="queried_node"><xsl:value-of select="$title"/> </span></h3>
		<table id="{$idem}" class="tablesorter">
		    <thead>
			<th id="c1_{$idem}"><span class="title"></span><button id="select_all_lines_{$idem}">Unselect all</button></th>
			<th><span class="title">State</span></th>
			<th><span class="title">Energy [<xsl:value-of select="$unitMolE"/>]</span></th>
			<th><span class="title">Degeneracy</span></th>
			<xsl:for-each select="../../../../xsams:Species/xsams:Molecules/xsams:Molecule[@speciesID = $spRef]/xsams:MolecularState[@stateID = $stRef]">
			    <xsl:call-template name="caseName">
				<xsl:with-param name="cases" select="xsams:Case"/>
			    </xsl:call-template>
			</xsl:for-each>
		    </thead>
		    <tbody>
		    <xsl:for-each select="../../../../xsams:Species/xsams:Molecules/xsams:Molecule[@speciesID = $spRef]/xsams:MolecularState[not(@auxillary ='true')]">	
			<xsl:variable name="cid2" select="generate-id()"/>
			<tr class="table-line">
			    <td data-columnid="c1_{$idem}_{$cid2}"><input type="checkbox" checked="checked" class="keep_line"/></td>
			    <td><xsl:value-of select="substring-after(@stateID, '-')"/></td>
			    <td><xsl:value-of select="xsams:MolecularStateCharacterisation/xsams:StateEnergy/xsams:Value"/></td>
			    <td><xsl:value-of select="xsams:MolecularStateCharacterisation/xsams:TotalStatisticalWeight"/></td>
			    <xsl:choose>
				<xsl:when test="xsams:Case">
				    <xsl:call-template name="caseValue">
					<xsl:with-param name="case" select="xsams:Case"/>
				    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				    <xsl:call-template name="caseNull">
					<xsl:with-param name="cases" select="following-sibling::*[1]/xsams:Case"/>
				    </xsl:call-template>
				</xsl:otherwise>
			    </xsl:choose>
			</tr>
		    </xsl:for-each>
		    </tbody>
		</table>
	    </div>
	</xsl:if>
    </xsl:template>
    
    <!-- Display the name of QN in each case -->
    <xsl:template name="caseName">
	<xsl:param name="cases"/>
	<xsl:for-each select="$cases/*/*">
	    <th><span class="title"><xsl:value-of select="name(.)"/></span></th>
	</xsl:for-each>
    </xsl:template>
    
    <!-- Display QNs null -->
    <xsl:template name="caseNull">
	<xsl:param name="cases"/>
	<xsl:for-each select="$cases/*/*">
	    <td></td>
	</xsl:for-each>
    </xsl:template>
    
    <!-- find index of the Atom tree by speciesID -->
    <xsl:template name="getAtomPosition">
	<xsl:param name="spRef"/>
	<xsl:for-each select="../../../../xsams:Species/xsams:Atoms/xsams:Atom">
	    <xsl:if test="xsams:Isotope/xsams:Ion/@speciesID = $spRef">
		<xsl:value-of select="count(./preceding-sibling::*)+1"/>
	    </xsl:if>
	</xsl:for-each>
    </xsl:template> 
    
     <!-- Atome QN name-->
    <xsl:template name="couplingTitle">
	<xsl:param name="AtomicComposition"/>
        <xsl:for-each select="$AtomicComposition/xsams:Component">
            <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
            <xsl:if test="position() = 1"> <!-- unique for the first component-->
              <xsl:if test="./xsams:Term/xsams:LS">
		<xsl:for-each select="./xsams:Term/xsams:LS/*">
		    <th><span class="title"><xsl:value-of select="name()"/></span></th>
		</xsl:for-each>
              </xsl:if>
              
              <xsl:if test="./xsams:Term/xsams:jj">
		<xsl:for-each select="./xsams:Term/xsams:jj/*">
		    <th><span class="title"><xsl:value-of select="name()"/></span></th>
	        </xsl:for-each>
	      </xsl:if>
	      
              <xsl:if test="./xsams:Term/xsams:J1J2">
		<xsl:for-each select="./xsams:Term/xsams:J1J2/*">
		    <th><span class="title"><xsl:value-of select="name()"/></span></th>
		</xsl:for-each>
	      </xsl:if>
              <xsl:if test="./xsams:Term/xsams:jK">
		<xsl:for-each select="./xsams:Term/xsams:jK/*">
		    <th><span class="title"><xsl:value-of select="name()"/></span></th>
		</xsl:for-each>
              </xsl:if>
              
              <xsl:if test="./xsams:Term/xsams:LK">
		<xsl:for-each select="./xsams:Term/xsams:LK/*">
		    <th><span class="title"><xsl:value-of select="name()"/></span></th>
		</xsl:for-each>
              </xsl:if>   
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <!--Atom QN values -->
    <xsl:template name="couplingValues">
	<xsl:param name="AtomicComposition"/>
        <xsl:for-each select="$AtomicComposition/xsams:Component">
            <xsl:sort select="xsams:MixingCoefficient" order="descending" data-type="number" />
            <xsl:if test="position() = 1"> <!-- unique fot the first component-->
              <xsl:if test="./xsams:Term/xsams:LS">
		<xsl:for-each select="./xsams:Term/xsams:LS">
		    <xsl:if test="xsams:L">
			<td><xsl:value-of select="xsams:L/xsams:Value"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:S">
			<td><xsl:value-of select="xsams:S"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:Multiplicity">
			<td><xsl:value-of select="xsams:Multiplicity"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:Seniority">
			<td><xsl:value-of select="xsams:Multiplicity"/></td>
		    </xsl:if>
		</xsl:for-each>
              </xsl:if>
              
              <xsl:if test="./xsams:Term/xsams:jj">
		<xsl:for-each select="./xsams:Term/xsams:jj/*">
		    <td><xsl:value-of select="."/></td>
	        </xsl:for-each>
	      </xsl:if>
	      
              <xsl:if test="./xsams:Term/xsams:J1J2">
		<xsl:for-each select="./xsams:Term/xsams:J1J2/*">
		    <td><xsl:value-of select="."/></td>
		</xsl:for-each>
	      </xsl:if>
              <xsl:if test="./xsams:Term/xsams:jK">
		<xsl:for-each select="./xsams:Term/xsams:jK/*">
		    <td><xsl:value-of select="."/></td>
		</xsl:for-each>
              </xsl:if>
              
              <xsl:if test="./xsams:Term/xsams:LK">
		<xsl:for-each select="./xsams:Term/xsams:LK">
		    <xsl:if test="xsams:L">
			<td><xsl:value-of select="xsams:L/xsams:Value"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:S">
			<td><xsl:value-of select="xsams:S"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:Multiplicity">
			<td><xsl:value-of select="xsams:Multiplicity"/></td>
		    </xsl:if>
		    <xsl:if test="xsams:Seniority">
			<td><xsl:value-of select="xsams:Multiplicity"/></td>
		    </xsl:if>
		</xsl:for-each>
              </xsl:if>   
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
    <!-- function witch allows to recreate xsams file with grouped collisions in sets -->
    <xsl:template match="xsams:XSAMSData" mode="buildXsams">
	    <xsl:copy-of select="xsams:Species"/>
	    <xsl:copy-of select="xsams:Methods"/>
	    <xsl:copy-of select="xsams:Sources"/>
	    <xsl:element name="Processes">
		<xsl:for-each-group select="xsams:Processes/xsams:Collisions/xsams:CollisionalTransition" group-by="xsams:Comments">
		    <xsl:element name="Rate">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:copy-of select="current-group()"/>
		    </xsl:element>
		</xsl:for-each-group>
	    </xsl:element>
    </xsl:template>
    
    <!-- divide a string (with unique separator) in multiple tokens-->
    <xsl:template match="xsams:CollisionalTransition/xsams:DataSets/xsams:DataSet[@dataDescription = 'rateCoefficient']/xsams:TabulatedData/xsams:X/xsams:DataList/text()" name="splitTemperatures">
	<xsl:param name="text" select="."/>
	<xsl:param name="sep" select="' '"/>	
	<xsl:for-each select="tokenize(normalize-space($text),$sep)">
                <th >
                    <span class="title"><xsl:value-of select="normalize-space(.)"/></span>
                </th>
        </xsl:for-each>
    </xsl:template>
    
    <!-- -->
    <xsl:template match="xsams:CollisionalTransition/xsams:DataSets/xsams:DataSet[@dataDescription = 'rateCoefficient']/xsams:TabulatedData/xsams:Y/xsams:DataList/text()" name="splitRates">
	<xsl:param name="text" select="."/>
	<xsl:param name="sep" select="' '"/>
        <xsl:for-each select="tokenize(normalize-space($text),$sep)">
                <td >
                    <xsl:value-of select="normalize-space(.)"/>
                </td>
        </xsl:for-each>
    </xsl:template>
   
    <xsl:template match="text()|@*"/><!-- to avoid a double display -->
        
</xsl:stylesheet>
