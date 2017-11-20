<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    attribute name="buildData" type="jetbrains.buildServer.serverSide.SBuild" %>
<c:set var="selfLink" value="viewLog.html?buildTypeId=${buildData.buildTypeExternalId}&buildId=${buildData.buildId}&tab=testsInfo" scope="request"/>
