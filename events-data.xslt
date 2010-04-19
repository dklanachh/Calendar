<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="/_internal/formats/format-date"/>
	<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

	
	<xsl:template match="/">		
	<script type="text/javascript">
	
	$(document).ready(function() {
	
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendar').fullCalendar({
			theme: true,
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultView: 'agendaWeek',
			editable: false,
			events: [
							<xsl:apply-templates select="//system-page"/>
			]
		});
		
	});
</script>
	</xsl:template>
	
	<xsl:template match="system-page">
	{
		[system-view:internal]target: true,[/system-view:internal]
		title: '<xsl:call-template name="replace-string">
				<xsl:with-param name="text" select="title"/>
				<xsl:with-param name="replace">'</xsl:with-param>
				<xsl:with-param name="with">\'</xsl:with-param>								
			</xsl:call-template>',
			start: '<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="system-data-structure/starts"/>
				<xsl:with-param name="mask" select="'yyyy-mm-dd HH:MM'"/>
			</xsl:call-template>',
			end:  '<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="system-data-structure/ends"/>
				<xsl:with-param name="mask" select="'yyyy-mm-dd HH:MM'"/>
			</xsl:call-template>',
			url: '[system-asset]<xsl:value-of select="path"/>[/system-asset]',
			
			<xsl:choose>
				<xsl:when test="system-data-structure/all-day/value = 'Yes'">
					allDay: true
				</xsl:when>
				<xsl:otherwise>
					allDay: false
				</xsl:otherwise>
			</xsl:choose>
	},
	</xsl:template>
	
	
	<xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


	
</xsl:stylesheet>