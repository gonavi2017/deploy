<%@ page import="jetbrains.buildServer.serverSide.statistics.ArtifactSizeStatisticsValueTypes" %>
<%@taglib prefix="stats" tagdir="/WEB-INF/tags/graph"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="buildType" type="jetbrains.buildServer.serverSide.SBuildType"--%>
<stats:buildGraph id="<%=ArtifactSizeStatisticsValueTypes.VISIBLE_ARTIFACTS_SIZE_KEY%>" isPredefined="${true}" valueType="<%=ArtifactSizeStatisticsValueTypes.VISIBLE_ARTIFACTS_SIZE_KEY%>"/>
