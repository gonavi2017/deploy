<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util"%><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"%><%@
    attribute name="project" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SProject" required="true" %><%@
    attribute name="withSeparatorInTheEnd" required="false" %><%@
    attribute name="contextProject" required="false" type="jetbrains.buildServer.serverSide.SProject" %><%@
    attribute name="skipContextProject" required="false" type="java.lang.Boolean" %><%@
    attribute name="style" required="false" %><%@
    attribute name="target" required="false"
%><bs:projectLinkFullAbstract project="${project}" contextProject="${contextProject}" skipContextProject="${skipContextProject}" withSeparatorInTheEnd="${withSeparatorInTheEnd}"
><jsp:attribute name="projectHtml"><admin:editProjectLink projectId="${proj.externalId}" style="${style}"><c:out value="${proj.name}"/></admin:editProjectLink></jsp:attribute
></bs:projectLinkFullAbstract>