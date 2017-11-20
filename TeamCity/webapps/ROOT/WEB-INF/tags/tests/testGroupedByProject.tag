<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="util" uri="/WEB-INF/functions/util"

    %><%@ attribute name="groupId" type="java.lang.String" required="false"
    %><%@ attribute name="projectGroups" type="java.util.List"

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

%><c:forEach var="projectGroup" items="${projectGroups}">
  <tt:projectTestGroups projectGroup="${projectGroup}"
                           withoutActions="${withoutActions}"
                           maxTests="${maxTests}" maxTestsPerGroup="${maxTestsPerGroup}"
                           ignoreMuteScope="${ignoreMuteScope}" showMuteFromTestRun="${showMuteFromTestRun}" maxTestNameLength="${maxTestNameLength}"
      >
    <jsp:attribute name="viewAllUrl"><jsp:invoke fragment="viewAllUrl"/></jsp:attribute>
    <jsp:attribute name="testMoreData"><jsp:invoke fragment="testMoreData"/></jsp:attribute>
    <jsp:attribute name="testAfterName"><jsp:invoke fragment="testAfterName"/></jsp:attribute>
    <jsp:attribute name="testLinkAttrs"><jsp:invoke fragment="testLinkAttrs"/></jsp:attribute>
  </tt:projectTestGroups>
</c:forEach>
