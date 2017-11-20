<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@attribute name="object" required="true" type="jetbrains.buildServer.serverSide.config.ConfigModification"
%><%@attribute name="text" required="true" type="java.lang.String"
%><%@attribute name="actionId" required="false"
%><c:set var="url" value="/admin/settingsDiffView.html?id=${object.objectExternalId}&versionBefore=${object.versionBefore}&versionAfter=${object.versionAfter}"
/><c:if test="${not empty actionId}"><c:set var="url" value="${url}&actionId=${actionId}"/></c:if
><a href="<c:url value="${url}"/>" target="_blank"><c:out value="${text}"/></a>