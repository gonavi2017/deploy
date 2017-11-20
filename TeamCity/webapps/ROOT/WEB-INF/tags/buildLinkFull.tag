<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ attribute name="build" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" required="true"
  %><%@ attribute name="contextProject" required="false" type="jetbrains.buildServer.serverSide.SProject"
  %><c:set var="titleStart" value="Click to open build #"/><c:set var="buildType" value="${build.buildType}"
  /><c:set var="title">${titleStart}<c:out value="${build.buildNumber}"/> home page</c:set><c:if test="${buildType != null}"><bs:buildTypeLinkFull buildType="${build.buildType}" contextProject="${contextProject}"/>&nbsp;</c:if
  ><c:if test="${buildType == null}"><c:set var="title" value="Click to open build home page"/></c:if
  ><bs:buildLink build="${build}" title="${title}"><c:if test="${buildType != null}">#</c:if><c:out value="${build.buildNumber}"/></bs:buildLink>