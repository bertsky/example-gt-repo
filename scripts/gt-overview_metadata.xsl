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
    
    <xsl:param name="repoName"/>
    <xsl:param name="repoBase"/>
    
    
    
    <xsl:variable name="docMETADATA">
        <xsl:copy-of select="json-to-xml(unparsed-text('../METADATA.json'))"/>
    </xsl:variable>
    
    <xsl:variable name="path">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_document'">../data_document</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure'">../data</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">../data_structure_and_text</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_line'">../data</xsl:if>
     </xsl:variable>
    
    <xsl:variable name="gtTyp">
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_document'">data_document/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure'">data_structure/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_structure_and_text'">data_structure_and_text/</xsl:if>
        <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text() = 'data_line'">data_line/</xsl:if>
    </xsl:variable>
    
    <xsl:variable name="gtFormat" select="$docMETADATA//fn:map/fn:string[@key='format']"/>
    
    <xsl:variable name="coll"><xsl:value-of select="$path"/>/?select=*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conMets"><xsl:value-of select="$path"/>/?select=mets.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conPage"><xsl:value-of select="$path"/>/?select=*GT-PAGE/*.xml;recurse=yes</xsl:variable>
    
    <xsl:variable name="conImg"><xsl:value-of select="$path"/>/?select=*.[jpgtiffpng]+;recurse=yes</xsl:variable>
    
    <xsl:variable name="folder" select="base-uri()" />
    
    <xsl:param name="output"/>
    
    
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
    <xsl:variable name="key15">countTextLine</xsl:variable>
    <xsl:variable name="key16">countPage</xsl:variable>
    
    
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
                <th>TextLine</th>
                <th>Page</th>
            </tr>
        </thead>
    </xsl:variable>
    
    <xsl:variable name="details">
        <xsl:element name="div">
            <xsl:element name="h2">Details</xsl:element>
            <xsl:element name="ul">
                <xsl:element name="li"><a href="metadata">Metadata</a></xsl:element>
                <xsl:element name="li"><a href="table">Compressed table view</a></xsl:element>
                <xsl:element name="li"><a href="overview">Detailed table view</a></xsl:element>
        </xsl:element>
        </xsl:element>
    </xsl:variable>
    
   
    
    <xsl:template match="/">
        
        
        
        
        
             <xsl:variable name="holeMetric">
                <xsl:element name="array">
                    
                    
                  <xsl:for-each select="collection($coll)">
                      <xsl:variable name="gtTypPath" select="replace($path, '../(.+)', '$1/')"/>
                      
                      <xsl:variable name="filename" select="base-uri()" />
                      <xsl:variable name="gtdocument">
                          <xsl:if test="$gtFormat = 'Page-XML'"><xsl:value-of select="substring-after(substring-before($filename, '/GT-PAGE/')[1],$gtTypPath)"/></xsl:if>
                          
                      </xsl:variable>
                      
                      
                        <xsl:if test="$gtdocument !=''">
                            
                     
                         <xsl:element name="array"><xsl:attribute name="key">volume_region</xsl:attribute>
                         <xsl:element name="map">
                             <xsl:attribute name="key1" select="substring-after(substring-before($filename, '/GT-PAGE/')[1], 'data/')"/>
                             <xsl:attribute name="key2" select="substring-after($filename, '/GT-PAGE/')"/>
                             <xsl:attribute name="file" select="$filename"/>
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
                             <string key="{$key15}"><xsl:value-of select="count(document($filename)//*/pc:TextLine)"/></string>
                             <string key="{$key16}"><xsl:value-of select="count(document($filename)//*/pc:Page)"/></string>
                            
                            
                        </xsl:element>
                    </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                    </xsl:element>
              </xsl:variable>
                
                
                
                
             
        <xsl:if test="$output = 'METADATA'">
            <link rel="stylesheet" href="table_hide.css"/>
                <xsl:element name="div">
                    
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                        
                    </dl>
                    <details>
                        <summary>More Information</summary>                         
                        <dl class="more-grid">
                            <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                            <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                            <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                            <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                        </dl>
                    </details>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                <h2>Total view</h2>
                <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                            <details>
                                <summary>Legend</summary>                         
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
                                    <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                    <dd>TextLine</dd>
                                    <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                    <dd>Page</dd>
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
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                    <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
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
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:element>
                        <xsl:element name="td" >
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:element>
                        
                    </xsl:element>
                    </xsl:element>
                </xsl:element>
                </xsl:if>
                    
                    
                    
                    <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                        
                        
                        <!-- beginn columes -->
                        
                        <xsl:variable name="k15">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key15])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k16">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key16])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k1">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key1])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k2">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key2])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k3">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key3])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k4">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key4])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k5">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key5])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        
                        <xsl:variable name="k6">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key6])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k7">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key7])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k8">
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key8])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k9">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key9])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k10">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key10])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k11">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key11])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k12">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key12])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k13">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key13])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:variable name="k14">
                            
                            <xsl:for-each select="$holeMetric/array">
                                <xsl:value-of select="sum($holeMetric//string[@key=$key14])"/>
                            </xsl:for-each>
                        </xsl:variable>
                        
                        
                        
                        
                        
                        
                        <!-- end columes -->
                        
                        <table class="noStyle">
                            <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                <details>
                                    <summary>Legend</summary>                         
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
                                        
                                        <xsl:if test="$k1 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[2]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lytextregion.html" target="_blank">TextRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k2 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[3]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyBildbereiche.html" target="_blank">ImageRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k3 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[4]"/></dt>
                                        <dd>LineDrawingRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k4 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[5]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyGraphik.html" target="_blank">GraphicRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k5 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[6]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyTabellen.html" target="_blank">TableRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k6 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[7]"/></dt>
                                        <dd>ChartRegion</dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k7 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[8]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySeparatoren.html" target="_blank">SeperatorRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k8 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[9]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyMathematische_Zeichen.html" target="_blank">MathsRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k9 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[10]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyChemische_Symbole.html" target="_blank">ChemRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k10 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[11]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyNotenzeichen.html" target="_blank">MusicRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k11 > 0">   
                                        <dt><xsl:value-of select="$tableHeader//th[12]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyWerbung.html" target="_blank">AdvertRegion</a></dd>
                                        </xsl:if>
                                            
                                        <xsl:if test="$k12 > 0">    
                                        <dt><xsl:value-of select="$tableHeader//th[13]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lyRauschen.html" target="_blank">NoiseRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k13 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[14]"/></dt>
                                        <dd><a href="https://ocr-d.de/de/gt-guidelines/trans/lySonstiges.html" target="_blank">UnkownRegion</a></dd>
                                        </xsl:if>
                                        
                                        <xsl:if test="$k14 > 0">
                                        <dt><xsl:value-of select="$tableHeader//th[15]"/></dt>
                                        <dd>CustomRegion</dd>
                                        </xsl:if>   
                                    </dl>
                                </details>
                            </td>
                                
                                <td>
                                    <div class="grid-container">
                                        
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide1')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                        
                                        
                                        <xsl:if test="$k1 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        <xsl:if test="$k2 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k3 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k4 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k5 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k6 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k7 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k8 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k9 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k10 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k11 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>   
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k12 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>    
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k13 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                        <xsl:if test="$k14 > 0">
                                            <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                        </xsl:if>
                                        
                                        
                                        
                                    </div>
                                </td>
                            </tr>
                        </table>
                        
                        
                        
                        
                        
                        <xsl:element name="table">
                            <xsl:attribute name="id">table_id</xsl:attribute>
                            <xsl:element name="thead">
                                <xsl:element name="tr">
                                    <xsl:copy-of select="$tableHeader//thead/tr/th[position()>15]"/>
                                    <xsl:if test="$k1 > 0">
                                        <th>TxtRegion</th>
                                    </xsl:if>

                                    <xsl:if test="$k2 > 0">
                                        <th>ImgRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k3 > 0">
                                        <th>LineDrawRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k4 > 0">
                                        <th>GraphRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k5 > 0">
                                        <th>TabRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k6 > 0">
                                        <th>ChartRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k7 > 0">
                                        <th>SepRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k8 > 0">
                                        <th>MathRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k9 > 0">
                                        <th>ChemRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k10 > 0">
                                        <th>MusicRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k11 > 0">
                                        <th>AdRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k12 > 0">
                                        <th>NoiseRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k13 > 0">
                                        <th>UnkownRegion</th>
                                    </xsl:if>
                                    
                                    <xsl:if test="$k14 > 0">
                                        <th>CustomRegion</th>
                                    </xsl:if>
                                    
                                </xsl:element>
                            </xsl:element>
                            <xsl:element name="tbody">
                                
                                
                                <xsl:element name="tr">
                                    
                                    
                                    
                                     <xsl:element name="td">
                                      <xsl:value-of select="$k15"/>
                                     </xsl:element>    
                                    
                                    
                                     <xsl:element name="td">
                                      <xsl:value-of select="$k16"/>
                                    </xsl:element>    
                                    
                                    
                                    <xsl:if test="$k1 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k1"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k2 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k2"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k3 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k3"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k4 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k4"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k5 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k5"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k6 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k6"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k7 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k7"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k8 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k8"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k9 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k9"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k10 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k10"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k11 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k12 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k12"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    
                                    <xsl:if test="$k13 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k13"/>
                                        </xsl:element>    
                                    </xsl:if>
                                    
                                    <xsl:if test="$k14 > 0">
                                        <xsl:element name="td">
                                            <xsl:value-of select="$k11"/>
                                        </xsl:element>    
                                    </xsl:if>
                                  </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:if>
                    
                    
                    
                    
                    
                </xsl:element>
                
                
                <xsl:element name="div">
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[position()>1]"/>
                    </xsl:element>
                </xsl:element>
                
                    
                    
                
                <xsl:if test="$docMETADATA//map/string[@key='gtTyp']/text()='text'">
                
                    <!--<array key="volume_lines">
                    <map>
                        <string key="count"/>
                        <string key="metric"/>
                    </map>
                </array>-->
                </xsl:if>
             </xsl:if>
        
        
        
        
        
        <xsl:if test="$output = 'TABLE'">
            <link rel="stylesheet" href="table_hide.css"/>
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_structure'">
                
                <xsl:element name="div">
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[1]"/>
                        <xsl:copy-of select="$details//li[3]"/>
                    </xsl:element>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                    </dl>
                    
                    <details>
                        <summary>More Information</summary>                         
                        <dl class="more-grid">
                            <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                            <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                            <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                            <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                        </dl>
                    </details>
                    
                    
                    <h2>Compressed table view</h2>
                    <div>
                    <table class="noStyle">
                        <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                            <details>
                                <summary>Legend</summary>                         
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
                            <th><xsl:value-of select="current-grouping-key()"/></th>
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
                           <tr><td colspan="17" style="text-align:left !important;">
                           
                           <details>
                               <summary>Overview</summary>
                               
                               <table>
                                   
                                   <xsl:copy-of select="$tableHeader"/>
                                   
                                   
                                   <xsl:for-each select="$content//map">
                                       
                                       
                                       <tr>
                                           <td><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/blob/<xsl:value-of select="$repoBase"/>/data/<xsl:value-of select="substring-after(@file, '/data/')"/></xsl:attribute><xsl:value-of select="@key2"/></a></td>
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
            
            
            
            
            <xsl:if test="$docMETADATA//fn:map/fn:string[@key='gtTyp']/text()='data_line'">
                
                <xsl:element name="div">
                    
                    <xsl:element name="h2">Details</xsl:element>
                    <xsl:element name="ul">
                        <xsl:copy-of select="$details//li[1]"/>
                        <xsl:copy-of select="$details//li[3]"/>
                    </xsl:element>
                </xsl:element>
                
                <xsl:element name="div">
                    <xsl:attribute name="class">metadata</xsl:attribute>
                    
                    <h2>Metadata</h2>
                    <dl class="grid">
                        <dt>Name:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='title']"/></dd>
                        <dt>Description:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='description']"/></dd>
                        <dt>Language:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='language']/fn:string"/></dd>
                        <dt>Format:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='format']"/></dd>
                        <dt>Time:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notBefore']"/>-<xsl:value-of select="$docMETADATA//fn:map/fn:map[@key='time']/fn:string[@key='notAfter']"/></dd>
                        <dt>GT Type:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='gtTyp']"/></dd>
                    </dl>
                    
                    <details>
                        <summary>More Information</summary>                         
                        <dl class="more-grid">
                            <dt>Transcription Guidelines:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='transcription-guidelines']"/></dd>
                            <dt>License:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:array[@key='license']/fn:map/fn:string[@key='name']"/></dd>
                            <dt>Project:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-name']"/></dd>
                            <dt>Project-URL:</dt><dd><xsl:value-of select="$docMETADATA//fn:map/fn:string[@key='project-website']"/></dd>
                        </dl>
                    </details>
                    
                    
                    <h2>Compressed table view</h2>
                    <div>
                        <table class="noStyle">
                            <tr><td>&#x1F4A1; You can show and hide individual columns of the table.<br/>Click the corresponding button.
                                <details>
                                    <summary>Legend</summary>                         
                                    <dl class="grid">
                                        <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                        <dd>TextLine</dd>
                                        <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                        <dd>Page</dd>
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
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide2')"><i><xsl:value-of select="$tableHeader//th[16]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide3')"><i><xsl:value-of select="$tableHeader//th[17]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide4')"><i><xsl:value-of select="$tableHeader//th[2]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide5')"><i><xsl:value-of select="$tableHeader//th[3]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide6')"><i><xsl:value-of select="$tableHeader//th[4]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide7')"><i><xsl:value-of select="$tableHeader//th[5]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide8')"><i><xsl:value-of select="$tableHeader//th[6]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide9')"><i><xsl:value-of select="$tableHeader//th[7]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide10')"><i><xsl:value-of select="$tableHeader//th[8]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide11')"><i><xsl:value-of select="$tableHeader//th[9]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide12')"><i><xsl:value-of select="$tableHeader//th[10]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide13')"><i><xsl:value-of select="$tableHeader//th[11]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide14')"><i><xsl:value-of select="$tableHeader//th[12]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide15')"><i><xsl:value-of select="$tableHeader//th[13]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide16')"><i><xsl:value-of select="$tableHeader//th[14]"/></i></button>
                                        <button onclick="document.getElementById('table_id').classList.toggle('hide17')"><i><xsl:value-of select="$tableHeader//th[15]"/></i></button>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <table id="table_id" class="display">
                            
                            <thead>                
                                <tr>
                                    <th>document</th>
                                    <th>TextLine</th>
                                    <th>Page</th>
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
                            
                            
                            
                            
                            <tbody> 
                                <xsl:for-each-group select="$holeMetric//*" group-by="@key1">
                                    
                                    <xsl:variable name="content"><list><xsl:copy-of select="current-group()"/></list></xsl:variable>
                                    
                                    <tr>
                                        <th><xsl:value-of select="current-grouping-key()"/></th>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key15])"/></td>
                                        <td><xsl:value-of select="sum(current-group()//*[@key=$key16])"/></td>
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
                                    <tr><td colspan="17" style="text-align:left !important;">
                                        
                                        <details>
                                            <summary>Overview</summary>
                                            
                                            <table>
                                                
                                                <thead>                
                                                    <tr>
                                                        <th>document</th>
                                                        <th>TextLine</th>
                                                        <th>Page</th>
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
                                                
                                                
                                                <xsl:for-each select="$content//map">
                                                    
                                                    
                                                    <tr>
                                                        <td><a><xsl:attribute name="href">https://github.com/<xsl:value-of select="$repoName"/>/blob/<xsl:value-of select="$repoBase"/>/data/<xsl:value-of select="substring-after(@file, '/data/')"/></xsl:attribute><xsl:value-of select="@key2"/></a></td>
                                                        <td><xsl:value-of select="string[@key=$key15]"/></td>
                                                        <td><xsl:value-of select="string[@key=$key16]"/></td>
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
                <link rel="stylesheet" href="table_hide.css"/>
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
                    "scrollX": "1800px",
                    "scrollCollapse": true,
                    "pagingType": "full_numbers",
                    "ordering": true,
                    "info":     true,
                    
                    } );
                    } );
                </script>
            
            
            <xsl:element name="div">
                <xsl:element name="h2">Details</xsl:element>
                <xsl:element name="ul">
                    <xsl:copy-of select="$details//li[1]"/>
                    <xsl:copy-of select="$details//li[2]"/>
                </xsl:element>
            </xsl:element>
            
            
            
            
            
            
            <h2>Detailed table view</h2>
            
            <div>
                <table class="noStyle">
                    <tr><td> 
                        <details>
                            <summary>Legend</summary>
                            <dl class="grid_only">
                                <dt><xsl:value-of select="$tableHeader//th[16]"/></dt>
                                <dd>TextLine</dd>
                                <dt><xsl:value-of select="$tableHeader//th[17]"/></dt>
                                <dd>Page</dd> 
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
                        
                        
                    </tr>
                </table>
                
            </div>
            
                        
            <table id="table_id">
                            
                            
                <xsl:element name="thead">
                    <xsl:element name="tr">
                        <th style="position: sticky !important; left: 0 !important;">document</th>
                        <xsl:copy-of select="$tableHeader//thead/tr/th[position()>1]"/>
                    </xsl:element>
                </xsl:element>
                            
                            
                            <tbody>
                            <xsl:for-each select="$holeMetric/array/array">
                                <tr>
                                    <th><xsl:value-of select="map/@key2"/></th>
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
                                    <td><xsl:value-of select="map/string[@key=$key15]"/></td>
                                    <td><xsl:value-of select="map/string[@key=$key16]"/></td>
                                </tr>
                            </xsl:for-each>
                            </tbody>     
                        </table>
                    
            
            
            
            
            
            
        </xsl:if>
        <xsl:if test="$output = 'METS'">
                   <xsl:for-each
                        select="uri-collection($conPage)">
                        <xsl:variable name="vfilename" select="base-uri()" />
                        <datei filename="{$vfilename}"/>
                    </xsl:for-each>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>




