<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="showIcon" type="java.lang.Boolean" description="Deprecated. Please don't use" %><%@
    attribute name="compactView" required="true" type="java.lang.Boolean" %><%@
    attribute name="forceLink" required="false" type="java.lang.Boolean"

%><c:choose
    ><c:when test="${forceLink or build.artifactsExists}"
        ><bs:_artifactsLink build="${build}">${compactView ? 'View' : 'Artifacts'}</bs:_artifactsLink
    ></c:when
    ><c:when test="${build.hasInternalArtifactsOnly}"
        ><span class="none"><bs:_artifactsLink build="${build}"
                                               hiddenOnly="true">${compactView ? 'None' : 'No artifacts'}</bs:_artifactsLink></span>
    </c:when
    ><c:otherwise><span class="none">${compactView ? 'None' : 'No artifacts'}</span></c:otherwise
></c:choose>