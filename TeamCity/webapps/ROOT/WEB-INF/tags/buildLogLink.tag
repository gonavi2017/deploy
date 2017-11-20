<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<%@attribute name="buildData" type="jetbrains.buildServer.serverSide.SBuild" required="true" %>
<%@attribute name="buildLogAnchor" type="java.lang.String" required="true" %>

<c:url var="buildLogUrl" value="/viewLog.html?tab=buildLog&logTab=tree&filter=debug&expand=all&buildId=${buildData.buildId}&_focus=${buildLogAnchor}"/>
<a href="${buildLogUrl}" title="Click to show problem in Build Log" <bs:iconLinkStyle icon="build-log"/>>Show in Build Log</a>
