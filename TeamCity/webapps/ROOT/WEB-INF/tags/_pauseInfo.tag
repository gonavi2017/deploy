<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"
%><c:choose
   ><c:when test="${buildType.paused}">Paused</c:when
   ><c:otherwise>Activated</c:otherwise
 ></c:choose>