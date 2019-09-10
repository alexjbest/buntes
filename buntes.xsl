<?xml version='1.0'?> <!-- As XML file -->

<!-- For University of Puget Sound, Writer's Handbook      -->
<!-- 2016/07/29  R. Beezer, rough underline styles         -->

<!-- Identify as a stylesheet -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Import the usual HTML conversion templates          -->
<!-- Place ups-writers-html.xsl file into  mathbook/user -->
<xsl:import href="../mathbook/xsl/mathbook-html.xsl" />

<xsl:include href="filter.xsl"/>

<xsl:output method="html" />

<xsl:param name="html.knowl.example" select="'no'" />
<xsl:param name="html.knowl.proof" select="'yes'" />
<xsl:param name="toc.level" select="'3'" />


<xsl:template name="mathjax">
    <!-- mathjax configuration -->
    <xsl:element name="script">
        <xsl:attribute name="type">
            <xsl:text>text/x-mathjax-config</xsl:text>
        </xsl:attribute>
        <xsl:text>&#xa;</xsl:text>
        <!-- // contrib directory for accessibility menu, moot after v2.6+ -->
        <!-- MathJax.Ajax.config.path["Contrib"] = "<some-url>";           -->
        <!-- ://cdn.mathjax.org/mathjax/contrib/ -->
        <xsl:text>MathJax.Ajax.config.path["Contrib"] = "//cdn.rawgit.com/mathjax/MathJax-third-party-extensions/22087770";&#xa;</xsl:text>
        <xsl:text>MathJax.Hub.Config({&#xa;</xsl:text>
        <xsl:text>    tex2jax: {&#xa;</xsl:text>
        <xsl:text>        inlineMath: [['\\(','\\)']],&#xa;</xsl:text>
        <xsl:text>    },&#xa;</xsl:text>
        <xsl:text>    TeX: {&#xa;</xsl:text>
        <xsl:text>        extensions: ["extpfeil.js", "autobold.js", "https://aimath.org/mathbook/mathjaxknowl.js", "[Contrib]/xyjax/xypic.js", "AMSmath.js", "AMSsymbols.js", ],&#xa;</xsl:text>
        <xsl:text>        // scrolling to fragment identifiers is controlled by other Javascript&#xa;</xsl:text>
        <xsl:text>        positionToHash: false,&#xa;</xsl:text>
        <xsl:text>        equationNumbers: { autoNumber: "none",&#xa;</xsl:text>
        <xsl:text>                           useLabelIds: true,&#xa;</xsl:text>
        <xsl:text>                           // JS comment, XML CDATA protect XHTML quality of file&#xa;</xsl:text>
        <xsl:text>                           // if removed in XSL, use entities&#xa;</xsl:text>
        <xsl:text>                           //&lt;![CDATA[&#xa;</xsl:text>
        <xsl:text>                           formatID: function (n) {return String(n).replace(/[:'"&lt;&gt;&amp;]/g,"")},&#xa;</xsl:text>
        <xsl:text>                           //]]&gt;&#xa;</xsl:text>
        <xsl:text>                         },&#xa;</xsl:text>
        <xsl:text>        TagSide: "right",&#xa;</xsl:text>
        <xsl:text>        TagIndent: ".8em",&#xa;</xsl:text>
        <xsl:text>    },&#xa;</xsl:text>
        <!-- key needs quotes since it is not a valid identifier by itself-->
        <xsl:text>    // HTML-CSS output Jax to be dropped for MathJax 3.0&#xa;</xsl:text>
        <xsl:text>    "HTML-CSS": {&#xa;</xsl:text>
        <xsl:text>        scale: 88,&#xa;</xsl:text>
        <xsl:text>        mtextFontInherit: true,&#xa;</xsl:text>
        <xsl:text>    },&#xa;</xsl:text>
        <xsl:text>    CommonHTML: {&#xa;</xsl:text>
        <xsl:text>        scale: 88,&#xa;</xsl:text>
        <xsl:text>        mtextFontInherit: true,&#xa;</xsl:text>
        <xsl:text>    },&#xa;</xsl:text>
        <!-- optional presentation mode gets clickable, large math -->
        <xsl:if test="$b-html-presentation">
            <xsl:text>    menuSettings:{&#xa;</xsl:text>
            <xsl:text>      zoom:"Click",&#xa;</xsl:text>
            <xsl:text>      zscale:"300%"&#xa;</xsl:text>
            <xsl:text>    },&#xa;</xsl:text>
        </xsl:if>
        <!-- close of MathJax.Hub.Config -->
        <xsl:text>});&#xa;</xsl:text>
        <!-- optional beveled fraction support -->
        <xsl:if test="//m[contains(text(),'sfrac')] or //md[contains(text(),'sfrac')] or //me[contains(text(),'sfrac')] or //mrow[contains(text(),'sfrac')]">
            <xsl:text>/* support for the sfrac command in MathJax (Beveled fraction) */&#xa;</xsl:text>
            <xsl:text>/* see: https://github.com/mathjax/MathJax-docs/wiki/Beveled-fraction-like-sfrac,-nicefrac-bfrac */&#xa;</xsl:text>
            <xsl:text>MathJax.Hub.Register.StartupHook("TeX Jax Ready",function () {&#xa;</xsl:text>
            <xsl:text>  var MML = MathJax.ElementJax.mml,&#xa;</xsl:text>
            <xsl:text>      TEX = MathJax.InputJax.TeX;&#xa;</xsl:text>
            <xsl:text>  TEX.Definitions.macros.sfrac = "myBevelFraction";&#xa;</xsl:text>
            <xsl:text>  TEX.Parse.Augment({&#xa;</xsl:text>
            <xsl:text>    myBevelFraction: function (name) {&#xa;</xsl:text>
            <xsl:text>      var num = this.ParseArg(name),&#xa;</xsl:text>
            <xsl:text>          den = this.ParseArg(name);&#xa;</xsl:text>
            <xsl:text>      this.Push(MML.mfrac(num,den).With({bevelled: true}));&#xa;</xsl:text>
            <xsl:text>    }&#xa;</xsl:text>
            <xsl:text>  });&#xa;</xsl:text>
            <xsl:text>});&#xa;</xsl:text>
        </xsl:if>
    </xsl:element>
    <!-- mathjax javascript -->
    <xsl:element name="script">
        <xsl:attribute name="type">
            <xsl:text>text/javascript</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="src">
            <xsl:text>https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.6.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML-full</xsl:text>
        </xsl:attribute>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
