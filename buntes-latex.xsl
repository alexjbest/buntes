<?xml version='1.0'?> <!-- As XML file -->

<!-- For University of Puget Sound, Writer's Handbook      -->
<!-- 2016/07/29  R. Beezer, rough underline styles         -->

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Import the usual HTML conversion templates          -->
<!-- Place ups-writers-html.xsl file into  mathbook/user -->
<xsl:import href="../pretext/xsl/mathbook-latex.xsl" />

<xsl:include href="filter.xsl"/>


<!-- As an item of a description list, but       -->
<!-- compatible with thebibliography environment -->
<xsl:template match="biblio[@type='raw']">
    <!-- begin the list with first item -->
    <xsl:if test="not(preceding-sibling::biblio)">
        <xsl:text>%% If this is a top-level references&#xa;</xsl:text>
        <xsl:text>%%   you can replace with "thebibliography" environment&#xa;</xsl:text>
        <xsl:text>\begin{thebibliography}{9}&#xa;</xsl:text>
    </xsl:if>
    <xsl:if test="//xref[contains(@ref,current()/@xml:id)]">
        <xsl:text>\bibitem</xsl:text>
        <!-- "label" (e.g. Jud99), or by default serial number -->
        <!-- LaTeX's bibitem will provide the visual brackets  -->
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="." mode="serial-number" />
        <xsl:text>]</xsl:text>
        <!-- "key" for cross-referencing -->
        <xsl:text>{</xsl:text>
        <xsl:apply-templates select="." mode="latex-id"/>
        <xsl:text>}</xsl:text>
        <xsl:apply-templates select="." mode="label" />
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:if>
    <!-- end the list after last item -->
    <xsl:if test="not(following-sibling::biblio)">
        <xsl:text>\end{thebibliography}&#xa;</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:output method="text" />

<xsl:param name="latex.preamble.late">
<xsl:text>\bibliographystyle{alpha}&#xa;</xsl:text>
</xsl:param>

</xsl:stylesheet>
