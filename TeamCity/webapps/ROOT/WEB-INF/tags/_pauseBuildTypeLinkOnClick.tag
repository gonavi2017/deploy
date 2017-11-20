<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.BuildTypeEx"
%><%@ attribute name="pause" required="true" type="java.lang.Boolean"
%><c:set var="pauseComment" value="${buildType.lastPauseComment}"
/>BS.PauseBuildTypeDialog.showPauseBuildTypeDialog('${buildType.buildTypeId}', ${pause}<c:if test='${pauseComment != null && not empty pauseComment.comment}'>, '<bs:escapeForJs text="${pauseComment.comment}" forHTMLAttribute="true"/>'</c:if>)
