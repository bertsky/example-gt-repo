<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:in="http://www.intern.de"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output indent="yes" omit-xml-declaration="no" method="html" doctype-public=""/>
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    <xsl:variable name="path">../data_structure</xsl:variable>
    <xsl:variable name="coll"><xsl:value-of select="$path"/>/?select=*.xml;recurse=yes</xsl:variable>
    
    <xsl:param name="output">TABLE</xsl:param>
    
    
    <xsl:variable name="key1">countTextRegion</xsl:variable>
    <xsl:variable name="key2">countImageRegion</xsl:variable>
    <xsl:variable name="key3">countLineDrawingRegion</xsl:variable>
    <xsl:variable name="key4">countGraphicRegion</xsl:variable>
    <xsl:variable name="key5">countTableRegion</xsl:variable>
    <xsl:variable name="key6">countChartRegion</xsl:variable>
    <xsl:variable name="key7">countSeparatorRegion</xsl:variable>
    <xsl:variable name="key8">countMathsRegion</xsl:variable>
    <xsl:variable name="key9">countChemRegion</xsl:variable>
    <xsl:variable name="key10">countMusicRegion</xsl:variable>
    <xsl:variable name="key11">countAdvertRegion</xsl:variable>
    <xsl:variable name="key12">countNoiseRegion</xsl:variable>
    <xsl:variable name="key13">countUnkownRegion</xsl:variable>
    <xsl:variable name="key14">countCustomRegion</xsl:variable>
    
    
   
    
    <xsl:template match="/">
        
        <style>
            
            header {
            background-color: #c8ab37 !important;
            border-color: #c8ab37 !important;
            }
            
            
            #overview td {
            padding: 1em;
            border: 1px solid black;
            }
            
            #overview.hide2 tr &gt; *:nth-child(2) {
            display: none;
            }
            #overview.hide3 tr &gt; *:nth-child(3) {
            display: none;
            }
            #overview.hide4 tr &gt; *:nth-child(4) {
            display: none;
            }
            #overview.hide5 tr &gt; *:nth-child(5) {
            display: none;
            }
            #overview.hide6 tr &gt; *:nth-child(6) {
            display: none;
            }
            #overview.hide7 tr &gt; *:nth-child(7) {
            display: none;
            }
            #overview.hide8 tr &gt; *:nth-child(8) {
            display: none;
            }
            #overview.hide9 tr &gt; *:nth-child(9) {
            display: none;
            }
            #overview.hide10 tr &gt; *:nth-child(10) {
            display: none;
            }
            #overview.hide11 tr &gt; *:nth-child(11) {
            display: none;
            }
            #overview.hide12 tr &gt; *:nth-child(12) {
            display: none;
            }
            #overview.hide13 tr &gt; *:nth-child(13) {
            display: none;
            }
            #overview.hide14 tr &gt; *:nth-child(14) {
            display: none;
            }
            #overview.hide15 tr &gt; *:nth-child(15) {
            display: none;
            }
            
            
            
        </style>
        
        
        
        
             <xsl:variable name="holeMetric">
                <xsl:element name="array">
                  <xsl:for-each select="collection($coll)">
                      
                      <xsl:variable name="filename" select="base-uri()" />
                      <xsl:variable name="gtdocument" select="substring-after(substring-before($filename, '/page/')[1],'data_structure/')"/>
                      
                      <xsl:message select="$gtdocument"/>
                      
                      
                      
                      
                        <xsl:if test="$gtdocument !=''">
                            
                     
                         <xsl:element name="array"><xsl:attribute name="key">volume_region</xsl:attribute>
                         <xsl:element name="map">
                             <xsl:attribute name="key1"><xsl:value-of select="substring-after(substring-before($filename, '/page/')[1],'data_structure/')"/></xsl:attribute>
                             <xsl:attribute name="key2"><xsl:value-of select="substring-after($filename, '/page/')"/></xsl:attribute>
                            <string key="{$key1}"><xsl:value-of select="count(document($filename)//*/pc:TextRegion)"/></string>
                             <string key="{$key2}"><xsl:value-of select="count(document($filename)//*/pc:ImageRegion)"/></string>
                             <string key="{$key3}"><xsl:value-of select="count(document($filename)//*/pc:LineDrawingRegion)"/></string>
                             <string key="{$key4}"><xsl:value-of select="count(document($filename)//*/pc:GraphicRegion)"/></string>
                             <string key="{$key5}"><xsl:value-of select="count(document($filename)//*/pc:TableRegion)"/></string>
                             <string key="{$key6}"><xsl:value-of select="count(document($filename)//*/pc:ChartRegion)"/></string>
                             <string key="{$key7}"><xsl:value-of select="count(document($filename)//*/pc:SeparatorRegion)"/></string>
                             <string key="{$key8}"><xsl:value-of select="count(document($filename)//*/pc:MathsRegion)"/></string>
                             <string key="{$key9}"><xsl:value-of select="count(document($filename)//*/pc:ChemRegion)"/></string>
                             <string key="{$key10}"><xsl:value-of select="count(document($filename)//*/pc:MusicRegion)"/></string>
                             <string key="{$key11}"><xsl:value-of select="count(document($filename)//*/pc:AdvertRegion)"/></string>
                             <string key="{$key12}"><xsl:value-of select="count(document($filename)//*/pc:NoiseRegion)"/></string>
                             <string key="{$key13}"><xsl:value-of select="count(document($filename)//*/pc:UnkownRegion)"/></string>
                             <string key="{$key14}"><xsl:value-of select="count(document($filename)//*/pc:CustomRegion)"/></string>
                            
                            
                        </xsl:element>
                    </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                    </xsl:element>
              </xsl:variable>
                
                
                
                
            <xsl:if test="$output = 'METADATA'">
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtType']/text()='structure'">
                    <xsl:element name="map" namespace="http://www.w3.org/2005/xpath-functions">
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:string[@key='name']"/>
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:string[@key='description']"/>
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:string[@key='language']"/>
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:string[@key='format']"/>
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:array[@key='time']"/>
                        <xsl:copy-of select="$docMETADATA//fn:map/fn:string[@key='gtType']"/>
                <xsl:element name="array" namespace="http://www.w3.org/2005/xpath-functions"><xsl:attribute name="key">volume_region</xsl:attribute>
                    <xsl:element name="map" namespace="http://www.w3.org/2005/xpath-functions">
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key1"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key2"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key3"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key4"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key5"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key6"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key7"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key8"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key9"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key10"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key11"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key12"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key13"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="string" namespace="http://www.w3.org/2005/xpath-functions">
                            <xsl:attribute name="key" select="$key14"/>
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:element>
                    </xsl:element>
                </xsl:if>
                
                <xsl:if test="$docMETADATA//map/string[@key='gtType']/text()='text'">
                
                    <!--<array key="volume_lines">
                    <map>
                        <string key="count"/>
                        <string key="metric"/>
                    </map>
                </array>-->
                </xsl:if>
             </xsl:if>
        
        
        <xsl:if test="$output = 'TABLE'">
            
            
            
            
            <xsl:variable name="tableHeader">
                <tr>
                    <th>document</th>
                    <th>countTextRegion</th>
                    <th>countImageRegion</th>
                    <th>countLineDrawingRegion</th>
                    <th>countGraphicRegion</th>
                    <th>countTableRegion</th>
                    <th>countChartRegion</th>
                    <th>countSeperatorRegion</th>
                    <th>countMathsRegion</th>
                    <th>countChemRegion</th>
                    <th>countMusicRegion</th>
                    <th>countAdvertRegion</th>
                    <th>countNoiseRegion</th>
                    <th>countUnkownRegion</th>
                    <th>countCustomRegion</th>
                </tr>
            </xsl:variable>
            
        
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtType']/text()='structure'">
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadaten</h2>
                    <dl>
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='name']"/></dd>
                        <dt>Beschreibung:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Sprache:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='language']"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Zeitraum:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='start']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='end']"/></dd>
                        <dt>Ground Truth Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtType']"/></dd>
                    </dl>
                    
                    <h2>Übersicht</h2>
                    <div>
                        
                        
                        
                        
                        <!--<button>
                            <xsl:attribute name="onclick">document.getElementById('overview').classList.toggle('hide2')</xsl:attribute>
                            Hide <i>countTextRegion</i>
                        </button>-->
                        <button onclick="document.getElementById('overview').classList.toggle('hide2')">Hide <i>countTextRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide3')">Hide <i>countImageRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide4')">Hide <i>countLineDrawingRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide5')">Hide <i>countGraphicRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide6')">Hide <i>countTableRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide7')">Hide <i>countChartRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide8')">Hide <i>countSeperatorRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide9')">Hide <i>countMathsRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide10')">Hide <i>countChemRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide11')">Hide <i>countMusicRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide12')">Hide <i>countAdvertRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide13')">Hide <i>countNoiseRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide14')">Hide <i>countUnkownRegion</i></button>
                        <button onclick="document.getElementById('overview').classList.toggle('hide15')">Hide <i>countCustomRegion</i></button>
                        
                        
                    <table id="overview">
                        
                       <xsl:copy-of select="$tableHeader"/>
                        
                       <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                           <xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>
                           
                        <tr>
                            <td><xsl:value-of select="current-grouping-key()"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key1])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key2])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key3])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key4])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key5])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key6])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key7])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key8])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key9])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key10])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key11])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key12])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key13])"/></td>
                            <td><xsl:value-of select="sum(current-group()//*[@key=$key14])"/></td>
                            </tr>
                           <tr><td colspan="15">
                           
                           <details>
                               <summary>Overview</summary>
                               
                               <table>
                                   
                                   <xsl:copy-of select="$tableHeader"/>
                                   
                                   
                                   <xsl:for-each select="$content//map">
                                       <tr>
                                           <td><xsl:value-of select="@key2"/></td>
                                           <td><xsl:value-of select="string[@key=$key1]"/></td>
                                           <td><xsl:value-of select="string[@key=$key2]"/></td>
                                           <td><xsl:value-of select="string[@key=$key3]"/></td>
                                           <td><xsl:value-of select="string[@key=$key4]"/></td>
                                           <td><xsl:value-of select="string[@key=$key5]"/></td>
                                           <td><xsl:value-of select="string[@key=$key6]"/></td>
                                           <td><xsl:value-of select="string[@key=$key7]"/></td>
                                           <td><xsl:value-of select="string[@key=$key8]"/></td>
                                           <td><xsl:value-of select="string[@key=$key9]"/></td>
                                           <td><xsl:value-of select="string[@key=$key10]"/></td>
                                           <td><xsl:value-of select="string[@key=$key11]"/></td>
                                           <td><xsl:value-of select="string[@key=$key12]"/></td>
                                           <td><xsl:value-of select="string[@key=$key13]"/></td>
                                           <td><xsl:value-of select="string[@key=$key14]"/></td>
                                       </tr>
                                   </xsl:for-each>
                               </table>
                           </details>
                            </td></tr>
                           
                           
                           
                    </xsl:for-each-group>
                </table>
                    </div>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>




