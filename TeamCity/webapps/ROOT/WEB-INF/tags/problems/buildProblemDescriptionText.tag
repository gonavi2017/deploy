<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="problems" tagdir="/WEB-INF/tags/problems"
%><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

%><%@ attribute name="buildProblem" type="jetbrains.buildServer.serverSide.problems.BuildProblem" required="true"
%><%@ attribute name="showPopup" type="java.lang.Boolean" required="true"
%><%@ attribute name="problemBody" fragment="true" required="true"

%><c:set var="build" value="${buildProblem.buildPromotion.associatedBuild}"

/><c:choose
  ><c:when test="${showPopup}"
    ><authz:authorize projectId="${buildProblem.projectId}" anyPermission="MANAGE_BUILD_PROBLEMS,ASSIGN_INVESTIGATION"
      ><jsp:attribute name="ifAccessGranted">
        <c:set var="popupIdSuff"><bs:id/></c:set>
        <bs:simplePopup controlId="problemPopup_${buildProblem.id}_${popupIdSuff}" popup_options="shift: {x: -20, y: 15}">
          <jsp:attribute name="content">
            <div class="problemPopup">
              <problems:buildProblemInvestigationLinks buildProblem="${buildProblem}" showIcon="true" showFixLink="true"/>
              <problems:buildProblemBuildLogLink buildProblem="${buildProblem}" buildData="${build}"/>
            </div>
          </jsp:attribute>
          <jsp:body>
            <jsp:invoke fragment="problemBody"/>
          </jsp:body>
        </bs:simplePopup>
      </jsp:attribute>
      <jsp:attribute name="ifAccessDenied"
        ><jsp:invoke fragment="problemBody"
      /></jsp:attribute>
    </authz:authorize>
  </c:when
  ><c:otherwise><jsp:invoke fragment="problemBody"/></c:otherwise
></c:choose>