<%@ tag import="jetbrains.buildServer.UserChangeStatus" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="changeStatus" required="true" type="jetbrains.buildServer.vcs.ChangeStatus"%><%@
    variable name-given="statusTableStyle" scope="AT_END" %><c:set var="statusTableStyle"><c:choose><c:when 
    test="${changeStatus.failedCount > 0}">failureStatusBlock</c:when><c:when
    test="${changeStatus.successCount > 0}">successStatusBlock</c:when><c:otherwise
    >unknownStatusBlock</c:otherwise></c:choose></c:set>