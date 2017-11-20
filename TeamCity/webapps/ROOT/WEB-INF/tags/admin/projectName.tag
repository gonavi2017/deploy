<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
%><%@ attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"
%><%@ attribute name="addToUrl" required="false" type="java.lang.String"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><c:choose
  ><c:when test="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}"
  ><admin:editProjectLink projectId="${project.externalId}" addToUrl="${addToUrl}"><c:out value="${project.fullName}"/></admin:editProjectLink
  ></c:when
  ><c:otherwise
  ><c:out value="${project.fullName}"
  /></c:otherwise
  ></c:choose>