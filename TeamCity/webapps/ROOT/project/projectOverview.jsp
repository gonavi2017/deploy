<%@ include file="/include-internal.jsp" %><%@
    page import="jetbrains.buildServer.web.openapi.PlaceId" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="ext" tagdir="/WEB-INF/tags/ext"

%><ext:includeExtensions placeId="<%=PlaceId.PROJECT_FRAGMENT%>"

/><jsp:include page="/projectBuildTypes.jsp"
/><jsp:include page="/_visibilityDialogs.jsp"
/><bs:executeOnce id="pauseDialog"><bs:pauseBuildTypeDialog/></bs:executeOnce>