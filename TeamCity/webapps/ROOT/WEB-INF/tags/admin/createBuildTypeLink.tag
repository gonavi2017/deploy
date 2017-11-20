<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="projectId" required="true" description="project external id"
  %><%@ attribute name="withoutLink"
  %><%@ attribute name="onmouseover"
  %><%@ attribute name="onmouseout"
  %><%@ attribute name="cameFromUrl"
  %><%@ attribute name="title"
  %><c:url var="url" value="/admin/createBuild.html?init=1&projectId=${projectId}&cameFromUrl=${cameFromUrl}"
  /><c:choose><c:when test="${not withoutLink}"><forms:addButton href="${url}" onmouseover="${onmouseover}" onmouseout="${onmouseout}" title="${title}"><jsp:doBody/></forms:addButton></c:when><c:otherwise><c:out value="${url}"/></c:otherwise></c:choose>