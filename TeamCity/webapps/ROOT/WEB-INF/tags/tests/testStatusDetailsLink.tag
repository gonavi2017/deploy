<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="testNameId" required="true" type="java.lang.Long" %><%@
    attribute name="cssClass" type="java.lang.String" %><%@
    attribute name="attrs" type="java.lang.String" %><%@
    attribute name="buildData" required="true" type="jetbrains.buildServer.serverSide.SBuild"

%><bs:_viewLog build="${buildData}"
               title="View failure details (stacktrace)"
               tab="buildResultsDiv"
               urlAddOn="#testNameId${testNameId}" attrs="class='${cssClass}' ${attrs}"
    ><jsp:doBody
/></bs:_viewLog>