<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="buildType" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuildType" required="true" %><%@
    attribute name="style" required="false" %><%@
    attribute name="target" required="false" %><%@
    attribute name="title" required="false" %><%@
    attribute name="tab" required="false"

%><c:set var="buildTypeId" value="${buildType.externalId}"
/><c:if test="${empty tab}"><c:set var="tab" value="buildTypeStatusDiv"/></c:if
><c:if test="${empty title}"><c:set var="title" value="Click to open the build configuration page"/></c:if
><c:url value="/viewType.html?buildTypeId=${buildTypeId}&tab=${tab}" var="url"
/><a style="${style}" href="${serverPath}${url}" <c:if test="${not empty target}">target="${target}"</c:if> title="${title}"><jsp:doBody/></a>