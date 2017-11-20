<%@ tag import="jetbrains.buildServer.groups.impl.UserGroupManagerImpl" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="group" type="jetbrains.buildServer.groups.SUserGroup" required="true" %>
<%@attribute name="ifAllUsersGroup" fragment="true" %>
<%@attribute name="ifUsualGroup" fragment="true" %>
<c:set var="ALL_USERS_GROUP_CODE" value="<%=UserGroupManagerImpl.ALL_USERS_GROUP_KEY%>"/>
<c:choose>
  <c:when test="${group.key == ALL_USERS_GROUP_CODE}"><jsp:invoke fragment="ifAllUsersGroup"/></c:when>
  <c:otherwise><jsp:invoke fragment="ifUsualGroup"/></c:otherwise>
</c:choose>