<%@ tag import="jetbrains.buildServer.serverSide.impl.TriggeredByUtil" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@attribute name="triggeredBy" type="jetbrains.buildServer.serverSide.TriggeredBy" required="true"
    %><%@attribute name="showDate" type="java.lang.Boolean" required="false"
    %><%@attribute name="hideUser" type="java.lang.Boolean" required="false"
 %><c:choose
  ><c:when test="${hideUser}"><c:out value="<%=TriggeredByUtil.renderWithoutUser(triggeredBy)%>"/></c:when
  ><c:otherwise><c:out value="${triggeredBy.asString}"/></c:otherwise
  ></c:choose
  ><c:set var="buildId" value="${triggeredBy.parameters['buildId']}"/><c:if test="${not empty buildId}"> <a href="<c:url value='/viewQueued.html?itemId=${buildId}'/>"><span class="tc-icon icon16 icon externalFileLink" style="vertical-align: middle"></span></a></c:if> <c:if test="${showDate}"> on <bs:date value="${triggeredBy.triggeredDate}"/></c:if>