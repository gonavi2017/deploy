<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
  attribute name="agentPoolId" required="true" type="java.lang.Integer"%><%@
  attribute name="agentPoolName" required="true" type="java.lang.String"%><%@
  attribute name="nameSuffix" type="java.lang.String"%><%@
  attribute name="hidePoolWord" type="java.lang.Boolean"%><%@
  attribute name="noLink" type="java.lang.Boolean"%><%@
  attribute name="groupHeader" type="java.lang.Boolean"
  %><c:set var="clazz"><c:if test="${groupHeader}">agentPoolNameAsGroupHeader</c:if></c:set
  ><c:set var="escapedName"><c:out value="${agentPoolName}"/><c:if test="${not hidePoolWord}"> pool</c:if><c:out value="${nameSuffix}"/></c:set><authz:authorize allPermissions="VIEW_AGENT_DETAILS"
  ><jsp:attribute name="ifAccessGranted"><c:choose><c:when test="${agentPoolId < 0 || noLink}"><span class="${clazz}">${escapedName}</span></c:when
    ><c:otherwise><a href="<c:url value="/agents.html?tab=agentPools#${agentPoolId}"/>" class="${clazz}" title='Click to view "<c:out value="${agentPoolName}"/>" agent pool details'>${escapedName}</a></c:otherwise></c:choose></jsp:attribute
  ><jsp:attribute name="ifAccessDenied"><span class="${clazz}">${escapedName}</span></jsp:attribute
></authz:authorize>