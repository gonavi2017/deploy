<%@ tag import="jetbrains.buildServer.controllers.viewLog.TestsTabForm"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="noLink"  %><%@
    attribute name="showEmpty" %><%@
    attribute name="group" type="jetbrains.buildServer.serverSide.TestGroupName" %><%@
    attribute name="levelToSet" %><c:if test="${showEmpty or group.suiteSet}"><c:set 
    var="t"><tt:grp_txt txt="${group.suite}" word="suite"/></c:set><c:if test="${not empty t}"><tt:groupNameLink
    levelToSet="${levelToSet}" noLink="${noLink}" scope='<%= TestsTabForm.scope(group.getSuite(), "*", "*")%>'
    text="${t}"/><jsp:doBody/></c:if></c:if>