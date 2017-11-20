<%@ tag import="jetbrains.buildServer.controllers.viewLog.TestsTabForm" %><%@ 
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="noLink"  %><%@
    attribute name="showEmpty" %><%@
    attribute name="group" type="jetbrains.buildServer.serverSide.TestGroupName" %><c:if test="${showEmpty or group.classNameSet}"><c:set 
    var="t"><tt:grp_txt txt="${group.className}" word="class"/></c:set><c:if test="${not empty t}"><tt:groupNameLink 
    noLink="${noLink}" levelToSet="test" scope="<%= TestsTabForm.scope(group)%>" text="${t}"/><jsp:doBody/></c:if></c:if>