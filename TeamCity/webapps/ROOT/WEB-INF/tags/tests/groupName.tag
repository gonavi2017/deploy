<%@ tag import="jetbrains.buildServer.controllers.viewLog.TestsTabForm" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    attribute name="group" type="jetbrains.buildServer.serverSide.TestGroupName" %><%@
    attribute name="currLevel" %><%@
    attribute name="prevLevel" %>
<c:choose>
  <c:when test="${'class' == currLevel}">
    <tt:classLink group="${group}" showEmpty="true"/>
    <c:if test="${group.packageSet or group.suiteSet}">
      <span class="package">
        (<tt:suiteLink group="${group}" levelToSet="${prevLevel}"><c:if test="${group.packageSet}">:</c:if></tt:suiteLink><tt:packageLink group="${group}" levelToSet="${prevLevel}"/>)
      </span>
    </c:if>
  </c:when>
  <c:when test="${'package' == currLevel}">
    <tt:packageLink group="${group}" levelToSet="${prevLevel}" showEmpty="true"/>
    <c:if test="${group.suiteSet}">
      <span class="package">
        (<tt:suiteLink group="${group}" levelToSet="${prevLevel}"/>)
      </span>
    </c:if>
  </c:when>
  <c:when test="${'suite' == currLevel}">
    <tt:suiteLink group="${group}" levelToSet="${prevLevel}" showEmpty="true"/>
  </c:when>
  <c:otherwise><tt:groupNameLink text="${group.fullName}" scope='<%= TestsTabForm.scope(group)%>' levelToSet="${prevLevel}"/></c:otherwise>
</c:choose>