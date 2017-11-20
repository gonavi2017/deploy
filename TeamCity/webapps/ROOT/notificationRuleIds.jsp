<%@ include file="include-internal.jsp"%>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"%>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<jsp:useBean id="notificationRulesForm" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm" scope="request"/>
<jsp:useBean id="idsMap" type="java.util.Map<java.lang.String, java.lang.String>" scope="request"/>

<script type="text/javascript">
  BS.NotificationRuleIds = {};
  BS.NotificationRuleIds._ids = {};
  BS.NotificationRuleIds.getNewId = function(oldId) {
    return this._ids[oldId];
  };
  <c:forEach items="${idsMap}" var="pairOfIds">
    BS.NotificationRuleIds._ids[${pairOfIds.key}] = ${pairOfIds.value};
  </c:forEach>
</script>
