<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
 <!--<xsl:output encoding="utf-8" omit-xml-declaration="yes" indent="no" method="text" xml:space="preserve"/>-->
 <xsl:strip-space elements="*"/>

 <xsl:template match="node()|@*">
  <xsl:apply-templates select="node()|@*"/>
 </xsl:template>

 <xsl:template match="w:body">
  <body><xsl:apply-templates select="node()|@*"/></body>
 </xsl:template>

 <xsl:template match="w:p">
     <p>
         <!-- alles hierin mag geen newline tussendoor krijgen -->
         <xsl:if test="child::w:pPr/w:jc[attribute::w:val='center']">
            <xsl:attribute name="align">center</xsl:attribute>
         </xsl:if>
         <xsl:apply-templates select="node()|@*"/>
     </p>
 </xsl:template>

 <xsl:template match="w:t/text()">
    <xsl:choose>
        <xsl:when test="parent::*/parent::*/w:rPr/w:i"><em><xsl:copy/></em></xsl:when>
        <xsl:when test="parent::*/parent::*/w:rPr/w:b"><strong><xsl:copy/></strong></xsl:when>
        <xsl:when test="parent::*/parent::*/w:rPr/w:vertAlign[@w:val='superscript']"><sup><xsl:copy/></sup></xsl:when>
        <xsl:otherwise><xsl:copy/></xsl:otherwise>
       <!--<xsl:if test="not(parent::*/parent::*/w:rPr/w:i)">-->
        <!--<xsl:copy><xsl:value-of select="."/></xsl:copy>-->
       <!--</xsl:if>-->
    </xsl:choose>
 </xsl:template>

    <!--<xsl:apply-templates select="//cd[@title=current()/@ref]"/>-->
 <!--<xsl:template match="w:footnoteReference">[ref]<xsl:value-of select="/descendant::w:footnote[@w:id=current()/@w:id]"/>[/ref]</xsl:template>-->

    <xsl:template match="w:footnoteReference">[ref]<xsl:apply-templates select="/descendant::w:footnote[@w:id=current()/@w:id]"/>[/ref]</xsl:template>

 <xsl:template match="w:footnotes">
  <!-- stop -->
 </xsl:template>

 <!--<xsl:template match="t/text()[../rPr/i]">-->
  <!--<empasis><xsl:value-of select="."/></empasis>-->
 <!--</xsl:template>-->

</xsl:stylesheet>
