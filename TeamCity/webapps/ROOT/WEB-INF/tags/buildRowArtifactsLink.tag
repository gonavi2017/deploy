<%@ tag import="jetbrains.buildServer.serverSide.TeamCityProperties" %>
<%@ tag import="jetbrains.buildServer.serverSide.BuildPromotion" %>
<%@ tag import="jetbrains.buildServer.serverSide.BuildPromotionEx" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    attribute name="build" required="true" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="showCompactArtifacts" required="true" type="java.lang.Boolean" %><%@
    attribute name="lazy" required="false" type="java.lang.Boolean"
%><%
  final BuildPromotion promotion = build.getBuildPromotion();
  if ((lazy == null || lazy) && TeamCityProperties.getBooleanOrTrue("teamcity.buildArtifactsLink.lazyLoading")) {
    if ((promotion instanceof BuildPromotionEx)) {
      lazy = !((BuildPromotionEx) promotion).hasComputedArtifactsState();
    } else {
      lazy = false;
    }
  }
  jspContext.setAttribute("lazy", lazy);
%><c:choose
 ><c:when test="${lazy}">
  <c:set var="id" value="lazy_artifacts_${build.buildId}_${util:uniqueId()}"/>
  <span id="${id}"><bs:_artifactsLink build="${build}">${showCompactArtifacts ? 'View' : 'Artifacts'}</bs:_artifactsLink></span>
  <script type="text/javascript">
    BS.BackgroundLoader.load($j('#${id}'),
                             'artifactsLink.html',
                              {buildId: ${build.buildId},
                               showCompactArtifacts: ${showCompactArtifacts ? 'true' : 'false'}});
  </script>
  </c:when
  ><c:otherwise
    ><c:set var="_id" value="build:${build.buildId}"
    /><c:set var="artifactsLink"><bs:artifactsLink build="${build}"
                                                   showIcon="${showCompactArtifacts}"
                                                   compactView="${showCompactArtifacts}"/></c:set
    ><c:set var="noArtifacts"><span id="${_id}:noArtifactsText" class="commentText">${artifactsLink}</span></c:set
    ><c:choose
        ><c:when test="${build.artifactsExists}"><span id="${_id}:artifactsLink">${artifactsLink}</span></c:when
        ><c:when test="${build.finished and not build.artifactsExists}">${noArtifacts}</c:when
        ><c:otherwise><span id="${_id}:artifactsLink" style="display:none"><bs:artifactsLink build="${build}"
                                                                                             showIcon="${showCompactArtifacts}"
                                                                                             compactView="${showCompactArtifacts}"
                                                                                             forceLink="true"
        /></span>${noArtifacts}</c:otherwise
    ></c:choose
 ></c:otherwise>
</c:choose>