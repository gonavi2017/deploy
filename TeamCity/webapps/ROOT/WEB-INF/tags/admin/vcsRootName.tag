<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ attribute name="vcsRoot" required="true" type="jetbrains.buildServer.vcs.SVcsRoot"
%><%@ attribute name="editingScope" required="true" type="java.lang.String"
%><%@ attribute name="cameFromUrl" required="true" type="java.lang.String"
%><%@ attribute name="cameFromTitle" required="false" type="java.lang.String"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><c:set var="rootName"><em>(${fn:replace(vcsRoot.vcsName, 'jetbrains.', '')})</em> <c:out value="${vcsRoot.name}"/></c:set
><c:choose
><c:when test="${afn:canEditVcsRoot(vcsRoot)}"
><admin:editVcsRootLink vcsRoot="${vcsRoot}" editingScope="${editingScope}" cameFromUrl="${cameFromUrl}" cameFromTitle="${cameFromTitle}">${rootName}</admin:editVcsRootLink
></c:when
><c:otherwise>${rootName}</c:otherwise
></c:choose>