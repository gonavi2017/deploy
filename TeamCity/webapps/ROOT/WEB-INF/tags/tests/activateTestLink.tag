<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags" 
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><%@ attribute name="testId" required="true" type="java.lang.Integer"
  %><%@ attribute name="hideIcon" type="java.lang.Boolean" required="false" %>

<a href="#" onclick="BS.Activator.doOpen('test?buildId=${build.buildId}&testId=${testId}'); return false"
   title="Click to open in the active IDE" <bs:iconLinkStyle icon="IDE" hideIcon="${hideIcon}"/>
><jsp:doBody/></a>