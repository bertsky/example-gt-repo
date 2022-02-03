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
    <xsl:output indent="yes" omit-xml-declaration="yes" method="xml"/>
    
    
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
    
    
    <xsl:variable name="tableHeader">
        <thead>                
            <tr>
                <th>document</th>
                <th>TxtRegion</th>
                <th>ImgRegion</th>
                <th>LineDrawRegion</th>
                <th>GraphRegion</th>
                <th>TabRegion</th>
                <th>ChartRegion</th>
                <th>SepRegion</th>
                <th>MathRegion</th>
                <th>ChemRegion</th>
                <th>MusicRegion</th>
                <th>AdRegion</th>
                <th>NoiseRegion</th>
                <th>UnkownRegion</th>
                <th>CustomRegion</th>
            </tr>
        </thead>
    </xsl:variable>
    
    
    
   
    
    <xsl:template match="/">
        <link rel="stylesheet" href="table_hide.css"/>
        
        

        
             <xsl:variable name="holeMetric">
                <xsl:element name="array">
                  <xsl:for-each select="collection($coll)">
                      
                      <xsl:variable name="filename" select="base-uri()" />
                      <xsl:variable name="gtdocument" select="substring-after(substring-before($filename, '/page/')[1],'data_structure/')"/>
                      
                      
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
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='name']"/></dd>
                        <dt>Beschreibung:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Sprache:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='language']"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Zeitraum:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='start']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='end']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtType']"/></dd>
                    </dl>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                <h2>Total view</h2>
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtType']/text()='structure'">
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; Sie können einzelne Spalten der Tabelle ein- und ausblenden. Klicken Sie auf<br/>den passenden Button.
                            <details>
                                <summary>Legende</summary>                         
                                <dl class="grid">
                                    <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                    <dd>LineDrawingRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                    <dd>ChartRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                    <dd>CustomRegion</dd>
                                </dl>
                            </details>
                        </td>
                            
                            <td>
                                <div class="grid-container">
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide1')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                </div>
                            </td>
                        </tr>
                    </table>
                    
                    
                    
                    <xsl:element name="table">
                        <xsl:attribute name="id">table_id</xsl:attribute>
                    <xsl:element name="thead">
                        <xsl:element name="tr">
                    <xsl:copy-of select="$tableHeader//thead/tr/th[position()>1]"/>
                    </xsl:element>
                    </xsl:element>
                    <xsl:element name="tbody">
                    
                    
                    <xsl:element name="tr">
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:element>
                        
                    </xsl:element>
                    </xsl:element>
                </xsl:element>
                </xsl:if>
                </xsl:element>
                <xsl:element name="div">
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:element name="li"><a href="table">Compressed table view</a></xsl:element>
                        <xsl:element name="li"><a href="overview">Detailed table view</a></xsl:element>
                    </xsl:element>
                    
                    
                </xsl:element>
                
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
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtType']/text()='structure'">
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='name']"/></dd>
                        <dt>Beschreibung:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Sprache:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='language']"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Zeitraum:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='start']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='time']/fn:map/fn:string[@key='end']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtType']"/></dd>
                    </dl>
                    
                    <h2>Compressed table view</h2>
                    <div>
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; Sie können einzelne Spalten der Tabelle ein- und ausblenden. Klicken Sie auf<br/>den passenden Button.
                            <details>
                                <summary>Legende</summary>                         
                                <dl class="grid">
                                    <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                    <dd>LineDrawingRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                    <dd>ChartRegion</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                    <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                    <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                    <dd>CustomRegion</dd>
                                </dl>
                            </details>
                        </td>
                            
                        <td>
                        <div class="grid-container">
                            <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                        </div>
                        </td>
                        </tr>
                    </table>
                    <table id="table_id" class="display">
                        
                       <xsl:copy-of select="$tableHeader"/>
                       
                       <tbody> 
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
                  </tbody>       
                </table>
                        
                    </div>
                </xsl:element>
            </xsl:if>
        </xsl:if>
        
        
        
        <xsl:if test="$output = 'OVERVIEW'">
            
                <link rel="stylesheet"
                    type="text/css"
                    href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css"/>
                <script type="text/javascript"
                    charset="utf8"
                    src="https://code.jquery.com/jquery-3.5.1.js"><xsl:text> </xsl:text></script>
                <script charset="utf8" type="text/javascript"
                    src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"><xsl:text> </xsl:text></script>
                <script type="text/javascript">
                    $(document).ready(function() {
                    $('#table_id').DataTable( {
                    "scrollY":        "800px",
                    "scrollCollapse": true,
                    "pagingType": "full_numbers",
                    "ordering": true,
                    "info":     true,
                    
                    } );
                    } );
                </script>
            
            
            <h2>Detailed table view</h2>
                        
            <table id="table_id">
                            
                            <xsl:copy-of select="$tableHeader"/>
                            
                            <tbody>
                            <xsl:for-each select="$holeMetric/array/array">
                                <tr>
                                    <td><xsl:value-of select="map/@key2"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key1]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key2]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key3]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key4]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key5]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key6]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key7]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key8]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key9]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key10]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key11]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key12]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key13]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key14]"/></td>
                                </tr>
                            </xsl:for-each>
                            </tbody>     
                        </table>
                    
            
            
            
            
            
            
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>




