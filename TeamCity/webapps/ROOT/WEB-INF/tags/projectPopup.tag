<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="project" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SProject" required="true"
%><%@ attribute name="withSelf" required="false" type="java.lang.Boolean"
%><%@ attribute name="withAdmin" required="false" type="java.lang.Boolean"
%><bs:popup type="projectSummary"
            showOptions=" '${project.externalId}', ${withSelf ? 1 : 0}, ${withAdmin ? 1 : 0}"
            id="projPopup${project.projectId}"
            additionalClasses="btPopup"
            topRightButton="true"
    ><jsp:doBody
/></bs:popup>