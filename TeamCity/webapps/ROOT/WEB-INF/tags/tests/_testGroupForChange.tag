<%@ tag import="jetbrains.buildServer.web.problems.GroupedTestsBean" %>
<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="tt" tagdir="/WEB-INF/tags/tests"
  %><%@ attribute name="withoutActions" required="false" type="java.lang.Boolean"
  %><%@ attribute name="defaultOption" required="true" type="java.lang.String"
  %><%@ attribute name="selectorStateKey" required="false" type="java.lang.String"
  %><%@ attribute name="testList" required="true" type="java.util.List"
  %><%@ attribute name="maxCount" required="false" type="java.lang.Integer"
  %><%@ attribute name="id" required="true" type="java.lang.String"
  %><c:set var="maxCount" value="${not empty maxCount ? maxCount : 1000}"
    /><tt:testGroupWithActions groupedTestsBean="<%= GroupedTestsBean.createForTests(testList, SessionUser.getUser(request))%>" defaultOption="${defaultOption}"
                               maxTests="${maxCount}" withoutActions="${withoutActions}"
                               groupSelector="${withoutActions ? 'false' : 'true'}"
                               selectorStateKey="${selectorStateKey}" id="${id}"
    >
  <jsp:attribute name="viewAllUrl">There are more than ${maxCount} failed tests, see corresponding builds for more details</jsp:attribute>
</tt:testGroupWithActions>