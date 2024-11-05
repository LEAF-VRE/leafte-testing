<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="w">
    
    <xsl:output method="xml" indent="yes"/>
    
    <!-- Root template -->
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>
                            <xsl:value-of select="//w:title"/>
                        </title>
                    </titleStmt>
                    <publicationStmt>
                        <p>Converted from Word document</p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Created from a Word document</p>
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:apply-templates select="//w:body"/>
                </body>
                <!-- Back matter for both footnotes and endnotes -->
                <back>
                    <!-- Footnotes section -->
                    <div type="footnotes">
                        <head>Footnotes</head>
                        <xsl:apply-templates select="//w:footnotes/w:footnote[not(@w:type='separator' or @w:type='continuationSeparator')]"/>
                    </div>
                    <!-- Endnotes section -->
                    <div type="endnotes">
                        <head>Endnotes</head>
                        <xsl:apply-templates select="//w:endnotes/w:endnote[not(@w:type='separator' or @w:type='continuationSeparator')]"/>
                    </div>
                </back>
            </text>
        </TEI>
    </xsl:template>
    
    <!-- Paragraph template -->
    <xsl:template match="w:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Heading 1 -->
    <xsl:template match="w:p[w:pPr/w:pStyle/@w:val='Heading1']">
        <div type="section">
            <head>
                <xsl:apply-templates/>
            </head>
        </div>
    </xsl:template>
    
    <!-- Text run template -->
    <xsl:template match="w:r">
        <xsl:choose>
            <!-- Bold text -->
            <xsl:when test="w:rPr/w:b">
                <hi rend="bold">
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>
            <!-- Italic text -->
            <xsl:when test="w:rPr/w:i">
                <hi rend="italic">
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>
            <!-- Regular text -->
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Footnote reference in main text -->
    <xsl:template match="w:r[w:footnoteReference]">
        <note type="footnoteRef">
            <xsl:attribute name="n">
                <xsl:value-of select="w:footnoteReference/@w:id"/>
            </xsl:attribute>
        </note>
    </xsl:template>
    
    <!-- Endnote reference in main text -->
    <xsl:template match="w:r[w:endnoteReference]">
        <note type="endnoteRef">
            <xsl:attribute name="n">
                <xsl:value-of select="w:endnoteReference/@w:id"/>
            </xsl:attribute>
        </note>
    </xsl:template>
    
    <!-- Footnote content -->
    <xsl:template match="w:footnote">
        <note type="footnote">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('fn', @w:id)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    
    <!-- Endnote content -->
    <xsl:template match="w:endnote">
        <note type="endnote">
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat('en', @w:id)"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </note>
    </xsl:template>
    
    <!-- Text template -->
    <xsl:template match="w:t">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <!-- Line break -->
    <xsl:template match="w:br">
        <lb/>
    </xsl:template>
    
    <!-- Table template -->
    <xsl:template match="w:tbl">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <!-- Table row -->
    <xsl:template match="w:tr">
        <row>
            <xsl:apply-templates/>
        </row>
    </xsl:template>
    
    <!-- Table cell -->
    <xsl:template match="w:tc">
        <cell>
            <xsl:apply-templates/>
        </cell>
    </xsl:template>
    
    <!-- List template -->
    <xsl:template match="w:p[w:pPr/w:numPr]">
        <item>
            <xsl:apply-templates/>
        </item>
    </xsl:template>
</xsl:stylesheet>