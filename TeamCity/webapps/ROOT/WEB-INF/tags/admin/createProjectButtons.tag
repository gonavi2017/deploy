<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="afn" uri="/WEB-INF/functions/authz" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@attribute name="parentProject" type="jetbrains.buildServer.serverSide.SProject" required="true" %>
<%@attribute name="cameFromUrl" type="java.lang.String" required="true" %>
<%@attribute name="createProjectTitle" type="java.lang.String" required="false" %>
<%@attribute name="defaultCreateMode" type="java.lang.String" required="false" %>
<c:if test="${empty createProjectTitle}"><c:set var="createProjectTitle" value="Create project"/></c:if>
<c:set var="encodedCameFromUrl" value="<%=WebUtil.encode(cameFromUrl)%>"/>
<c:url value="/admin/createObjectMenu.html?projectId=${parentProject.externalId}&showMode=createProjectMenu&autoExpand=${defaultCreateMode}&cameFromUrl=${encodedCameFromUrl}" var="createProjectUrl"/>
<forms:addButton href="${createProjectUrl}">${createProjectTitle}</forms:addButton>
