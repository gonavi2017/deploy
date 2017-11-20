<%@ tag import="jetbrains.buildServer.web.problems.GroupedTestsBean" %>
<%@ tag import="jetbrains.buildServer.web.util.SessionUser" %>
<%@ tag import="jetbrains.buildServer.web.util.WebUtil" %>
<%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop" %><%@

    attribute name="tests" fragment="false" required="true" type="java.util.List" %><%@
    attribute name="id" fragment="false" required="false" type="java.lang.String" %><%@
    attribute name="maxTests2Show" required="true" type="java.lang.Integer" %><%@
    attribute name="buildData" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SBuild" %><%@
    attribute name="showMuteFromTestRun" fragment="false" required="true" type="java.lang.Boolean"

%><c:set var="maxTestsDefault" value="<%= WebUtil.getMaxUiTestLimit() %>"
/><tt:testGroupWithActions groupedTestsBean="<%= GroupedTestsBean.createForTests(tests, SessionUser.getUser(request))%>"
                           maxTests="${maxTests2Show > 0 ? maxTests2Show : maxTestsDefault}" maxTestNameLength="140"
                           maxTestsPerGroup="${maxTests2Show > 0 ? maxTests2Show/2 : maxTestsDefault}"
                           groupSelector="noBuildType" defaultOption="package" singleBuildTypeContext="true"
                           ignoreMuteScope="false" showMuteFromTestRun="${showMuteFromTestRun}" id="${id}"
  />