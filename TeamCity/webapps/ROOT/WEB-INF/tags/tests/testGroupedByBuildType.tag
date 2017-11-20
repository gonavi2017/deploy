<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

    %><%@ attribute name="groupId" type="java.lang.String" required="false"
    %><%@ attribute name="buildTypeGroups" type="java.util.Map"

    %><%@ attribute name="withoutActions" required="true"
    %><%@ attribute name="singleBuildTypeContext" required="false"
    %><%@ attribute name="maxTests" type="java.lang.Integer" required="true"
    %><%@ attribute name="maxTestsPerGroup" type="java.lang.Integer" required="true"
    %><%@ attribute name="skipTestsWithSeveralConfigurations" type="java.lang.Boolean" required="false"

    %><%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false"
    %><%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false"
    %><%@ attribute name="viewAllUrl" fragment="true" required="false"
    %><%@ attribute name="testMoreData" fragment="true" required="false"
    %><%@ attribute name="testAfterName" fragment="true" required="false"
    %><%@ attribute name="testLinkAttrs" fragment="true" required="false"
    %><%@ attribute name="maxTestNameLength" type="java.lang.Integer" required="false"

%><c:forEach var="buildTypeGroup" items="${buildTypeGroups}">
  <c:set var="hasTestsToShow" value="${not buildTypeGroup.value.allTestsWithMultipleBuildTypes}"/>
  <c:if test="${hasTestsToShow}">

    <c:set var="groupNameId" value="${util:blockId(buildTypeGroup.key.fullName)}"/>

    ${util:blockHiddenJs(pageContext.request, groupNameId, true)}
    <div class="group-name" data-blockId="${groupNameId}" data-collapsedByDefault="true">
      <c:if test="${empty withoutActions}">
        <forms:checkbox name="" custom="true" className="multi-select"/>
        <span class="chkboxPlace"></span>
      </c:if>
      <bs:handle/><bs:responsibleIcon responsibility="${buildTypeGroup.key.responsibilityInfo}"
        /><span class="title"><bs:projectOrBuildTypeIcon type="buildType"/> <bs:buildTypeLink buildType="${buildTypeGroup.key}"/></span>
      <span class="testCount" title="Tests in the configuration">(${buildTypeGroup.value.testCount})</span>
    </div>
    <div class="subgroups" style="${util:blockHiddenCss(pageContext.request, groupNameId, true)}">
      <tt:testGroupedByPackage rootGroup="${buildTypeGroup.value}"
                               withoutActions="${withoutActions}"
                               singleBuildTypeContext="${true}"
                               maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                               skipTestsWithSeveralConfigurations="${skipTestsWithSeveralConfigurations}"
                               ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}"
                               maxTestNameLength="${maxTestNameLength}"
          >
        <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
        <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
        <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
        <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
      </tt:testGroupedByPackage>
    </div>

  </c:if>
</c:forEach>
