<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%><%@
    attribute name="branch" required="true" type="jetbrains.buildServer.serverSide.Branch" %><%@
    attribute name="defaultMaxLength" required="false"

%><c:set var="defaultMaxLength" value="${empty defaultMaxLength ? 30 : defaultMaxLength}"
  /><bs:trimWithTooltip maxlength="${intprop:getInteger('teamcity.ui.branch.max.length', defaultMaxLength)}"
                      trimCenter="${true}">${branch.displayName}</bs:trimWithTooltip>