<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

    %><%@ attribute name="groupId" type="java.lang.String" required="false"
    %><%@ attribute name="projectGroup" type="jetbrains.buildServer.web.problems.ProjectTestsBean"
    %><%@ attribute name="showFullProjectName" type="java.lang.Boolean" required="false"

    %><%@ attribute name="withoutActions" required="true"
    %><%@ attribute name="maxTests" type="java.lang.Integer" required="true"
    %><%@ attribute name="maxTestsPerGroup" type="java.lang.Integer" required="true"

    %><%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false"
    %><%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false"

    %><%@ attribute name="viewAllUrl" fragment="true" required="false"
    %><%@ attribute name="testMoreData" fragment="true" required="false"
    %><%@ attribute name="testAfterName" fragment="true" required="false"
    %><%@ attribute name="testLinkAttrs" fragment="true" required="false"
    %><%@ attribute name="maxTestNameLength" type="java.lang.Integer" required="false"

%><c:set var="hasTestsToShow" value="${not projectGroup.testGroup.allTestsWithMultipleBuildTypes}"/>

<c:if test="${hasTestsToShow}">

    <c:choose>

      <c:when test="${projectGroup.project.rootProject}">

          <!-- Showing the data for subprojects -->
          <tt:testGroupedByProject projectGroups="${projectGroup.subProjects}"
                                   withoutActions="${withoutActions}"
                                   maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                                   ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}"
                                   maxTestNameLength="${maxTestNameLength}"
              >
            <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
            <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
            <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
            <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
          </tt:testGroupedByProject>

      </c:when>
      <c:otherwise>

        <c:set var="groupNameId" value="${projectGroup.project.externalId}"/>

        ${util:blockHiddenJs(pageContext.request, groupNameId, true)}
        <div class="group-name" data-blockId="${groupNameId}" data-collapsedByDefault="true">
          <c:if test="${empty withoutActions}">
            <forms:checkbox name="" custom="true" className="multi-select"/>
            <span class="chkboxPlace"></span>
          </c:if>
          <bs:handle
          /><span class="title">
            <bs:projectOrBuildTypeIcon/>
            <c:choose
                ><c:when test="${showFullProjectName}"><bs:projectLinkFull project="${projectGroup.project}"/></c:when
                ><c:otherwise><bs:projectLink project="${projectGroup.project}"/></c:otherwise
            ></c:choose>
          </span>
          <span class="testCount" title="Tests in the project and subprojects">(${projectGroup.testGroup.testCountSingleBuildType})</span>
        </div>
        <div class="subgroups" style="${util:blockHiddenCss(pageContext.request, groupNameId, true)}">


          <!-- Showing the list of build nodes with related tests -->
          <tt:testGroupedByBuildType buildTypeGroups="${projectGroup.buildTypeGroups}"

                                     withoutActions="${withoutActions}"
                                     singleBuildTypeContext="${true}"
                                     maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                                     skipTestsWithSeveralConfigurations="true"
                                     ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}"
                                     maxTestNameLength="${maxTestNameLength}"
              >
            <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
            <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
            <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
            <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
          </tt:testGroupedByBuildType>



          <!-- Showing the data for subprojects -->
          <tt:testGroupedByProject projectGroups="${projectGroup.subProjects}"

                                   withoutActions="${withoutActions}"
                                   maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                                   ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}"
                                   maxTestNameLength="${maxTestNameLength}"
              >
            <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
            <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
            <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
            <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
          </tt:testGroupedByProject>

        </div>

      </c:otherwise>

    </c:choose>

</c:if>
