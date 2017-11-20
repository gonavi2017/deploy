<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject" %><%@
    attribute name="inplaceFiltered" required="false" type="java.lang.Boolean" %><%@
    attribute name="data" required="false" type="java.lang.String" %><%@
    attribute name="classes" required="false" type="java.lang.String"

%><c:set var="classes">class="${inplaceFiltered ? 'inplaceFiltered' : ''} ${project.archived ? 'subtle' : ''} ${classes}"</c:set
><c:set var="label" value="${project.name}${project.archived ? ' (archived)' : ''}"
/><optgroup ${classes} label="<c:out value="${label}"/>" <c:if test="${not empty data}">data-filter-data="${data}"</c:if> ><jsp:doBody/></optgroup>