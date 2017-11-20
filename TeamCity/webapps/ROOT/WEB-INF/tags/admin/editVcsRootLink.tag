<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
  attribute name="vcsRoot" required="true" type="jetbrains.buildServer.vcs.SVcsRoot" %><%@
  attribute name="withoutLink" required="false" type="java.lang.Boolean" %><%@
  attribute name="editingScope" required="true" type="java.lang.String" %><%@
  attribute name="cameFromUrl" required="true" type="java.lang.String" %><%@
  attribute name="classes" required="false" type="java.lang.String" %><%@
  attribute name="cameFromTitle" required="false" type="java.lang.String"
%><c:set var="escapedCameFromUrl" value="<%=WebUtil.encode(cameFromUrl)%>"
/><c:set var="escapedTitle" value="<%=WebUtil.encode(cameFromTitle)%>"
/><c:url value="/admin/editVcsRoot.html?init=1&action=editVcsRoot&vcsRootId=${vcsRoot.externalId}&editingScope=${editingScope}&cameFromUrl=${escapedCameFromUrl}&cameFromTitle=${escapedTitle}" var="editVcsLink"
/><c:choose><c:when test="${withoutLink}">${editVcsLink}</c:when><c:otherwise><a href="${editVcsLink}" <c:if test="${not empty classes}">class="${classes}"</c:if>><jsp:doBody/></a></c:otherwise></c:choose>