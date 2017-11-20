<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="template" type="jetbrains.buildServer.serverSide.BuildTypeTemplate" required="true"
%><bs:projectLinkFull project="${template.project}"><c:out value="${template.project.name}"
/></bs:projectLinkFull> :: <admin:editTemplateLink templateId="${template.externalId}"><c:out value="${template.name}"/></admin:editTemplateLink>