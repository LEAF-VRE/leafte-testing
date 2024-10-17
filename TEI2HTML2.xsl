<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs xhtml"
    version="2.0">
    
    <!-- This XSLT has been adapted from work done over time by members of the TEI-C council and community.
    Most recently it was developed specifically to transform the XML output from the Transkribus platform
    to TEI-All by members of the Leaf Editorial Academic Framework (LEAF) team for use with the LEAF-Writer text-encoding enfironment.
    The LEAF-Writer project is licensed under the GNU Affero General Public License v3.0 (https://choosealicense.com/licenses/agpl-3.0/)
    For more information about LEAF-Writer, the larger LEAF platform, go to: https://gitlab.com/calincs/cwrc/leaf-writer/leaf-writer-->

    <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        method="xhtml" omit-xml-declaration="yes" indent="yes" encoding="UTF-8"/>
    
    <!-- Strips whitespace around all elements (* = wildcard or all elements) -->
    <xsl:strip-space elements="*"/>
    
    <!-- This invokes a template to match at the root level of the document ("/") and then apply the template -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- This creates the HTML doctype, removes the teiHeader, and applies a CSS stylesheet 
        (adjust relative path to your directory structure and stylesheet name 
    Note that most style properties are managed in the CSS -->
    
    <xsl:template match="TEI">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <xsl:comment>This document is generated from a TEI Master--do not edit!</xsl:comment>
                <title><xsl:value-of select="teiHeader/fileDesc/titleStmt/title"/></title>
                <link rel="stylesheet" type="text/css" href="https://github.com/LEAF-VRE/code_snippets/blob/main/CSS/web_style.css"/>
                <style type="text/css">
                    @import url("https://github.com/LEAF-VRE/code_snippets/blob/main/CSS/web_style.css");
                </style>
            </head>
            <body>                               
                <xsl:apply-templates select="text/body"/>
            </body>
        </html>
    </xsl:template>

    <!-- == BASIC TEXT STRUCTURE == -->
    <!-- This converts the head element into an H1 element in HTML -->    
    <xsl:template match="head">
        <h1 xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    
    <!-- div or p elements are treated as div or p elements in HTML -->
    <xsl:template match="div | p">
        <p xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
</xsl:stylesheet>