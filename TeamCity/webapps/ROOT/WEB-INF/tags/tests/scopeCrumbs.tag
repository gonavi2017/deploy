<%@ tag import="jetbrains.buildServer.controllers.viewLog.TestsTabForm" %><%@ 
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="levelToSet" %><%@
    attribute name="group" type="jetbrains.buildServer.serverSide.TestGroupName" %>    
<span class="scopeCrumbs">
  <tt:groupNameLink levelToSet="${levelToSet}" scope='<%= TestsTabForm.scope("*", "*", "*")%>' text="All" clazz="scopeCrumbsReset"/>
  <span class="separator">|</span>
  <c:set var="noLink" value="${group.packageName == '*' and group.className == '*'}"/>
  <tt:suiteLink group="${group}" levelToSet="${levelToSet}" showEmpty="true" noLink="${noLink}"><c:if test="${not noLink}"><span class="separator">|</span></c:if></tt:suiteLink>
  <c:set var="noLink" value="${group.className == '*'}"/>
  <tt:packageLink group="${group}" levelToSet="${levelToSet}" showEmpty="true" noLink="${noLink}"><c:if test="${not noLink}"><span class="separator">|</span></c:if></tt:packageLink>
  <tt:classLink group="${group}" noLink="true" showEmpty="true"/>
</span>
