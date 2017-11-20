<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="buildData" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SRunningBuild" %><%@
    attribute name="classname" required="false" type="java.lang.String"

%><c:if test="${buildData.buildStatus.successful}"
    ><div class="progressInner progressInnerSuccessful ${classname}" style="width: ${buildData.completedPercent}%;"><jsp:doBody/></div></c:if
 ><c:if test="${not buildData.buildStatus.successful}"
    ><div class="progressInner progressInnerFailed ${classname}" style="width: ${buildData.completedPercent}%;"><jsp:doBody/></div></c:if>