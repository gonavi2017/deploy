<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %><%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
  taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
  attribute name="withoutLink" required="false" type="java.lang.Boolean" %><%@
  attribute name="editingScope" required="true" type="java.lang.String" %><%@
  attribute name="cameFromUrl" required="true" type="java.lang.String" %><%@
  attribute name="cameFromTitle" required="false" type="java.lang.String"
%><c:set var="escapedCameFromUrl" value="<%=WebUtil.encode(cameFromUrl)%>"
/><c:set var="escapedCameFromTitle" value="<%=WebUtil.encode(cameFromTitle)%>"
/><c:url value="/admin/editVcsRoot.html?init=1&action=addVcsRoot&editingScope=${editingScope}&cameFromUrl=${escapedCameFromUrl}&cameFromTitle=${escapedCameFromTitle}" var="createVcsLink"
/><c:choose><c:when test="${withoutLink}">${createVcsLink}</c:when><c:otherwise><forms:addButton href="${createVcsLink}"><jsp:doBody/></forms:addButton></c:otherwise></c:choose>