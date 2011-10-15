package com.freckle.gaegenerator.helpers.generators.codeSnippets.xsl
{
	public class XSLIMControl
	{
		public static function generate(propName:String):String{
			var s:String = "";
			s += "<select name=\""+propName+"Protocol\">"
			s += "<option value=\"sip\">SIP/SIMPLE";
			s += "<xsl:if test=\""+propName+"/protocol='sip'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"xmpp\">XMPP/Jabber";
			s += "<xsl:if test=\""+propName+"/protocol='xmpp'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://aim.com/\">AIM";
			s += "<xsl:if test=\""+propName+"/protocol='http://aim.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://icq.com/\">ICQ"
			s += "<xsl:if test=\""+propName+"/protocol='http://icq.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			;
			s += "<option value=\"http://talk.google.com/\">Google Talk";
			s += "<xsl:if test=\""+propName+"/protocol='http://talk.google.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://messenger.msn.com/\">MSN Messenger";
			s += "<xsl:if test=\""+propName+"/protocol='http://messenger.msn.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://messenger.yahoo.com/\">Yahoo Messenger";
			s += "<xsl:if test=\""+propName+"/protocol='http://messenger.yahoo.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://sametime.com/\">Lotus Sametime";
			s += "<xsl:if test=\""+propName+"/protocol='http://sametime.com'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"http://gadu-gadu.pl/\">Gadu-Gadu";
			s += "<xsl:if test=\""+propName+"/protocol='http://gadu-gadu.pl'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "<option value=\"unknown\">Unknown or unspecified";
			s += "<xsl:if test=\""+propName+"/protocol='unknown'\">"
			s += "<xsl:attribute name=\"selected\">true</xsl:attribute>";
			s += "</xsl:if>";
			s += "</option>";
			
			s += "</select>";
			return s;
		}

	}
}