<%@ tag import="jetbrains.buildServer.ideaSettings.IdeaSettings" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:viewWorkingDirectory/>

<%
jetbrains.buildServer.ideaSettings.IdeaSettings settings = new jetbrains.buildServer.ideaSettings.IdeaSettings();
settings.readFrom(propertiesBean.getProperties().get(jetbrains.buildServer.runner.ipr.IprRunnerConstants.IPR_INFO_RUN_PARAMETER));
jspContext.setAttribute("ideaSettings", settings);
%>

<%--@elvariable id="ideaSettings" type="jetbrains.buildServer.ideaSettings.IdeaSettings"--%>
<div class="parameter">
  Path to the project: <strong><c:out value="${ideaSettings.ipr}"/></strong>
</div>

<div class="parameter">
  Path variables: <c:if test="${fn:length(ideaSettings.pathVariables) == 0}"><strong>none defined</strong></c:if>
</div>
<c:if test="${fn:length(ideaSettings.pathVariables) > 0}">
<div class="nestedParameter"><table>
<c:forEach var="pvEntry" items="${ideaSettings.pathVariables}">
<tr>
  <td style="vertical-align:top;"><c:out value="${pvEntry.key}"/>:</td>
  <td style="vertical-align:top;"><c:out value="${pvEntry.value.value}"/></td>
</tr>
</c:forEach>
</table></div>
</c:if>

<div class="parameter">
  Project SDKs: <c:if test="${fn:length(ideaSettings.sdks) == 0}"><strong>none defined</strong></c:if>
</div>

<c:if test="${fn:length(ideaSettings.sdks) > 0}">
<div class="nestedParameter"><table>
<c:forEach items="${ideaSettings.sdks}" var="jdk">
<tr>
  <td style="vertical-align:top;"><c:out value="${jdk.name}"/> Home:</td>
  <td style="vertical-align:top;"><c:out value="${jdk.pathToJdk}"/></td>
</tr>
<tr>
  <td style="vertical-align:top;">SDK Files Patterns:</td>
  <td style="vertical-align:top;"><bs:out value="${jdk.patternsText}"/></td>
</tr>
</c:forEach>
</table></div>
</c:if>

<div class="parameter">
  Global libraries: <c:if test="${fn:length(ideaSettings.globalLibraries) == 0}"><strong>none defined</strong></c:if>
</div>

<c:if test="${fn:length(ideaSettings.globalLibraries) > 0}">
<div class="nestedParameter"><table>
<c:forEach items="${ideaSettings.globalLibraries}" var="lib">
<tr>
  <td style="vertical-align:top;"><c:out value="${lib.name}"/>:</td>
  <td style="vertical-align:top;"><c:out value="${lib.pathToLibrary}"/></td>
</tr>
<tr>
  <td style="vertical-align:top;">Library Jar Files Patterns:</td>
  <td style="vertical-align:top;"><bs:out value="${lib.patternsText}"/></td>
</tr>
</c:forEach>
</table></div>
</c:if>
