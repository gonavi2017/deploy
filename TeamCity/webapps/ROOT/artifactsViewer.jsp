<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"

%><jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
/><c:set var="buildType" value="${buildData.buildType}"/><c:if test="${not empty error}">
  <c:out value="${error}"/>: <b><c:out value="${startPage}"/></b>.
  <c:if test="${not empty isProjectTab}">
    Artifacts taken from build <bs:buildTypeLink buildType="${buildType}"/> ::
    <bs:resultsLink build="${buildData}" noPopup="true">#<c:out value="${buildData.buildNumber}"/></bs:resultsLink>
  </c:if>
</c:if
><c:if test="${empty error}">
  <c:if test="${not empty isProjectTab}">
    <p>
      Data was taken from <c:out value="${buildType.fullName}"/>,
      <bs:resultsLink build="${buildData}">build <c:out value="${buildData.buildNumber}"/></bs:resultsLink>
      started at <bs:date value="${buildData.startDate}"/>
    </p>
  </c:if
  ><c:url value='/repository/download/${buildType.externalId}/${buildData.buildId}:id/${startPage}' var="iframeUrl"
  /><bs:iframe url="${iframeUrl}"/>
</c:if>
