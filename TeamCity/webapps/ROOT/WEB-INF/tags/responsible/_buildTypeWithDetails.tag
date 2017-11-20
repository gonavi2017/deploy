<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="labelFor" required="false" type="java.lang.String"

%><c:set var="name"><bs:trimWithTooltip maxlength="25">${buildType.name}</bs:trimWithTooltip></c:set
><c:if test="${not empty labelFor}"
    ><c:set var="name"><label for="${labelFor}">${name}</label></c:set
></c:if
><c:set var="lastBuild" value="${buildType.lastChangesFinished}"/>
<td class="bt">${name}</td>
<c:choose>
  <c:when test="${not empty lastBuild}">
    <td><bs:buildDataIcon buildData="${lastBuild}"/></td>
    <td>
      <bs:resultsLink build="${lastBuild}" skipChangesArtifacts="true" popupZIndex="100" noTitle="true"
          ><bs:trim maxlength="32">${lastBuild.statusDescriptor.text}</bs:trim
          ></bs:resultsLink>
    </td>
    <td><bs:changesLinkFull build="${lastBuild}" noUsername="true" highlightIfCommitter="false"/></td>
  </c:when>
  <c:otherwise>
    <td colspan="3"></td>
  </c:otherwise>
</c:choose>
