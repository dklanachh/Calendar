<xsl:stylesheet extension-element-prefixes="exsl str set" version="1.0" xmlns:exsl="http://exslt.org/common" xmlns:set="http://exslt.org/sets" xmlns:str="http://exslt.org/strings" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="/_internal/formats/format-date"/>
	<xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
	<xsl:variable name="categories" select="set:distinct(//system-page/dynamic-metadata[name='categories']/value)"/>
	<xsl:variable name="classes">
      		<dict>
         		<item key="red">Master</item>
         		<item key="blue">Academic</item>
         		<item key="green">Student Affairs</item>
         		<item key="purple">Alumni</item>
      		</dict>
   	</xsl:variable>
	
	
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
			defaultView: 'month',
			editable: false,
			events: [
							<xsl:apply-templates select="//system-page"/>
			]
		});
<xsl:for-each select="$categories">
    <xsl:variable name="category" select="."/>
    	<xsl:for-each select="exsl:node-set($classes)/dict/item">
    <xsl:if test=". = $category">
        		 toggleCalendar("<xsl:value-of select="@key"/>", "trigger-<xsl:value-of select="@key"/>");
    </xsl:if>
    	</xsl:for-each>
    </xsl:for-each>


		
	});
</script>
    <!--Test Value: <xsl:value-of select="name(./node())"/>-->
<div id="calendar-wrapper">
    <div id="calendars">
    <!--xsl:for-each select="exsl:node-set($classes)/dict/item"-->
    <xsl:for-each select="$categories">
    <xsl:variable name="category" select="."/>
    	<xsl:for-each select="exsl:node-set($classes)/dict/item">
    <xsl:if test=". = $category">
        <a href="javascript:void()">
        	<xsl:attribute name="id">trigger-<xsl:value-of select="@key"/></xsl:attribute>
        	<!--xsl:if test="@key = 'red'"><xsl:attribute name="class">ui-state-default</xsl:attribute></xsl:if-->
        	<span> </span><xsl:value-of select="."/>
        </a>
    </xsl:if>
    	</xsl:for-each>
    </xsl:for-each>
    </div>
    <div id="calendar"></div>
</div>

	</xsl:template>
	
	<xsl:template match="system-page">
	<xsl:variable name="metadata-value" select="dynamic-metadata[name='categories']/value"/>
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
			<xsl:for-each select="exsl:node-set($classes)/dict/item">
			<xsl:if test=". = $metadata-value">
				className: '<xsl:value-of select="@key"/>',
				</xsl:if>
			</xsl:for-each>
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