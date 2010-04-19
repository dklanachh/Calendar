<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="/_internal/formats/format-date"/>
	<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

	
	<xsl:template match="/">		
		<xsl:apply-templates select="//system-page"/>
	</xsl:template>
	
	<xsl:template match="system-page">
		<h2><xsl:value-of select="title"/></h2>
		<xsl:apply-templates select="system-data-structure"/>
	</xsl:template>
	
	<xsl:template match="system-data-structure">
	<xsl:choose>
	<xsl:when test="all-day = 'Yes'">
	<p>Start: <xsl:call-template name="format-date">
			<xsl:with-param name="date" select="starts"/>
			<xsl:with-param name="mask" select="'mmmm, dd yyyy'"/>
		</xsl:call-template></p>
		<p>End: <xsl:call-template name="format-date">
			<xsl:with-param name="date" select="ends"/>
			<xsl:with-param name="mask" select="'mmmm, dd yyyy'"/>
		</xsl:call-template></p>
		
	</xsl:when>
	<xsl:otherwise>
	<p>Start: <xsl:call-template name="format-date">
			<xsl:with-param name="date" select="starts"/>
			<xsl:with-param name="mask" select="'mmmm, dd yyyy - hh:MM TT'"/>
		</xsl:call-template></p>
		<p>End: <xsl:call-template name="format-date">
			<xsl:with-param name="date" select="ends"/>
			<xsl:with-param name="mask" select="'mmmm, dd yyyy - hh:MM TT'"/>
		</xsl:call-template></p>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>