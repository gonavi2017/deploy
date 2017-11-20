<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="true" %><%@
    attribute name="noActions" type="java.lang.Boolean" required="false"

%><c:if test="${test.muted}"
  ><c:set var="tooltip"><bs:muteInfoTooltip test="${test}" showActions="${not noActions}"/></c:set
  ><span class="icon icon16 bp muted" <bs:tooltipAttrs text="${tooltip}" className="name-value-popup"/>></span>
</c:if>