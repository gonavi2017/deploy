<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    attribute name="groupedTestsBean" type="jetbrains.buildServer.web.problems.GroupedTestsBean" required="true" %><%@
    attribute name="showFullProjectName" type="java.lang.Boolean" required="false" %><%@
    attribute name="id" required="true"
%><tt:testGroupWithActions groupedTestsBean="${groupedTestsBean}" showFullProjectName="${showFullProjectName}"
                           groupSelector="true" defaultOption="nothing" selectorStateKey="investigations"
                           ignoreMuteScope="true" id="${id}">
  <jsp:attribute name="afterToolbar">
  </jsp:attribute>
  <jsp:attribute name="testAfterName">
      <c:set var='test' value="${testBean.test}"/>
      <%--@elvariable id="test" type="jetbrains.buildServer.serverSide.TestEx"--%>
      <c:set var="resp" value="${test.responsibility}"/>
    </td>
    <td class="details">
      <resp:investigationDetails entry="${resp}" />
      <c:if test="${groupedTestsBean.testsNumber == 1}">
        <span class="testActionsLinks">
          <span class="separator">|</span>
          <c:set var="buildId" value="${not empty testBean.run.buildOrNull ? testBean.run.buildOrNull.buildId : ''}"/>
          <tt:testInvestigationLinks test="${test}" buildId="${buildId}" withFix="${resp.state.active}"/>
        </span>
      </c:if>
    </td>
    <td>
  </jsp:attribute>
</tt:testGroupWithActions>