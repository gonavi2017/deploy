<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

    %><%@ attribute name="groupId" type="java.lang.String" required="false"
    %><%@ attribute name="rootGroup" type="jetbrains.buildServer.web.problems.TestGroupBean"

    %><%@ attribute name="withoutActions" required="true"
    %><%@ attribute name="singleBuildTypeContext" required="false"
    %><%@ attribute name="maxTests" type="java.lang.Integer" required="true"
    %><%@ attribute name="maxTestsPerGroup" type="java.lang.Integer" required="true"
    %><%@ attribute name="skipTestsWithSeveralConfigurations" type="java.lang.Boolean" required="false"

    %><%@ attribute name="ignoreMuteScope" type="java.lang.Boolean" required="false"
    %><%@ attribute name="showMuteFromTestRun" type="java.lang.Boolean" required="false"
    %><%@ attribute name="maxTestNameLength" type="java.lang.Integer" required="false"

    %><%@ attribute name="viewAllUrl" fragment="true" required="false"
    %><%@ attribute name="testMoreData" fragment="true" required="false"
    %><%@ attribute name="testAfterName" fragment="true" required="false"
    %><%@ attribute name="testLinkAttrs" fragment="true" required="false"

%><%@ variable name-given="testBean" %>

<c:set var="shownCounter" value="${0}"/>
<c:forEach var="group" items="${rootGroup.groups}" varStatus="groupStatus">

  <c:set var="shownInGroup" value="${0}"/>
  <c:set var="groupDataText">
  <c:if test="${shownCounter < maxTests}">

      <c:set var="groupNameId" value="${util:blockId(group.name)}"/>
      ${util:blockHiddenJs(pageContext.request, groupNameId, true)}
      <div class="group-name" data-blockId="${groupNameId}">

        <c:if test="${empty withoutActions}">
          <forms:checkbox name="" custom="true" className="multi-select"/>
          <span class="chkboxPlace"></span>
        </c:if>
        <bs:handle/><bs:trimWithTooltip maxlength="120" trimCenter="true">${empty group.name ? "<Root>" : group.name}</bs:trimWithTooltip>
        <span class="testCount" title="Tests in the package">(${group.testCount})</span>
      </div>

      <c:set var="shouldShowMore" value="${false}"/>
      <c:set var="hasSkippedWithMultipleBT" value="${false}"/>
      <table class="testList" style="${util:blockHiddenCss(pageContext.request, groupNameId, false)}">
          <c:forEach var="testBean" items="${group.items}">
            <c:set var="shouldShowBySize" value="${shownCounter < maxTests && (shownInGroup < maxTestsPerGroup || groupStatus.last)}"/>
            <c:set var="shouldShow" value="${shouldShowBySize}"/>
            <c:set var="severalBT" value="${testBean.buildTypeCount > 1}"/>

            <c:if test="${skipTestsWithSeveralConfigurations}">
              <c:set var="shouldShow" value="${shouldShowBySize and not severalBT}"/>
              <c:set var="hasSkippedWithMultipleBT" value="${severalBT}"/>
            </c:if>

            <c:if test="${shouldShow}">
              <c:set var="shownCounter" value="${shownCounter + 1}"/>
              <c:set var="shownInGroup" value="${shownInGroup + 1}"/>

              <bs:changeRequest key="testBean" value="${testBean}">
                <c:set var="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></c:set>
                <tt:_testWithBuilds groupId="${groupId}" testBean="${testBean}" withoutActions="${withoutActions}"
                                    checkboxRequired="${empty withoutActions}" showPackage="false"
                                    singleBuildTypeContext="${singleBuildTypeContext}"
                                    testLinkAttrs="${testLinkAttrs}" maxTestNameLength="${maxTestNameLength}"
                                    ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}">
                  <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
                  <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
                </tt:_testWithBuilds>
                ${util:add(allShownTestBeans, testBean)}
              </bs:changeRequest>
            </c:if>
            <c:if test="${!shouldShowBySize}"><c:set var="shouldShowMore" value="${true}"/></c:if>
          </c:forEach>

          <c:choose>
            <c:when test="${hasSkippedWithMultipleBT}">
              <tr><td class="testNamePart more">
                  There are <a href='#'
                               onclick="BS.TestGroup.highlight_multiple_bt_group(this, '${groupNameId}'); return false;">some tests</a> failed in several configurations, including this one
              </td></tr>
            </c:when>
            <c:when test="${shouldShowMore}" >
              <tr><td class="testNamePart more">
                  ...
              </td></tr>
            </c:when>
          </c:choose>
      </table>

  </c:if>
  </c:set>
  <c:if test="${shownInGroup > 0}">
    ${groupDataText}
  </c:if>
</c:forEach>
<c:if test="${fn:length(rootGroup.items) >= maxTests}">
  <div class="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></div>
</c:if>
