<?xml version='1.0'?> <!-- As XML file -->

<!-- For University of Puget Sound, Writer's Handbook      -->
<!-- 2016/07/29  R. Beezer, rough underline styles         -->

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Import the usual HTML conversion templates          -->
<!-- Place ups-writers-html.xsl file into  mathbook/user -->
<xsl:import href="../mathbook/xsl/mathbook-latex.xsl" />

<xsl:include href="filter.xsl"/>

<xsl:output method="text" />
<xsl:param name="latex.preamble.late">
<xsl:text>\bibliographystyle{alpha}&#xa;</xsl:text>
</xsl:param>

</xsl:stylesheet>
