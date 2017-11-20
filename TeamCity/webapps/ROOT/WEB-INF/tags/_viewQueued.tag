<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="queuedBuild" required="true" type="jetbrains.buildServer.serverSide.SQueuedBuild"
  %><%@ attribute name="tab" fragment="false" required="false"
  %><%@ attribute name="noLink" fragment="false" required="false" type="java.lang.Boolean"
  %><c:if test="${empty tab}" ><c:set
  var="tab" value="queuedBuildOverviewTab"/></c:if><c:url
  value="/viewQueued.html?itemId=${queuedBuild.itemId}&tab=${tab}" var="url"/><c:set var="url" value="${url}"
  /><c:choose><c:when test="${noLink == true}">${serverPath}${url}</c:when><c:otherwise><a href="${serverPath}${url}" title="View queued build page"><jsp:doBody/></a></c:otherwise></c:choose>