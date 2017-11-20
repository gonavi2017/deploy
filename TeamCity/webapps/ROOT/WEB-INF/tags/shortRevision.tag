<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@attribute name="change" type="jetbrains.buildServer.vcs.VcsModification"
    %><c:choose><c:when test="${fn:length(change.displayVersion) == 40 }"><c:out value="${fn:substring(change.displayVersion, 0, 12)}"/></c:when>
    <c:otherwise><bs:trim maxlength="15" >${change.displayVersion}</bs:trim></c:otherwise></c:choose>
