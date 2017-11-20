<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="noPopup" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="hiddenOnly" fragment="false" required="false" type="java.lang.Boolean" %><%@
    attribute name="attrs" fragment="false" required="false"

%><c:set var="link"
    ><bs:_viewLog build="${build}" title="View build artifacts" attrs="${attrs}" tab="artifacts"><jsp:doBody/></bs:_viewLog
></c:set
><c:choose
  ><c:when test="${hiddenOnly}"
    ><bs:popup_static controlId="hiddenArtifacts:${build.buildId}"
      ><jsp:attribute name="content"
        ><div>No user-defined artifacts in this build, see <bs:_viewLog build="${build}"
                                                                        title="View build artifacts"
                                                                        urlAddOn="&showAll=true"
                                                                        tab="artifacts">hidden artifacts</bs:_viewLog>.</div
      ></jsp:attribute
      ><jsp:body><jsp:doBody/></jsp:body
    ></bs:popup_static
  ></c:when
  ><c:when test="${noPopup}">${link}</c:when
  ><c:otherwise
    ><bs:popup type="artifactsPopup"
               showOptions="'${build.buildTypeId}', ${build.buildId}"
               id="artifacts:${build.buildId}">${link}</bs:popup
  ></c:otherwise
></c:choose>