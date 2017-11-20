<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="afn" uri="/WEB-INF/functions/authz"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
  %><%@ attribute name="build" fragment="false" required="true" type="jetbrains.buildServer.serverSide.SRunningBuild"
  %><%@ attribute name="ifAccessGranted" fragment="true"
  %><%@ attribute name="ifAccessDenied" fragment="true" %>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.User"--%>
<c:choose>
  <c:when test="${afn:canStopBuild(build)}"><jsp:invoke fragment="ifAccessGranted"/></c:when>
  <c:otherwise><jsp:invoke fragment="ifAccessDenied"/></c:otherwise>
</c:choose>
