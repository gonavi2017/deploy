<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<%@ include file="include-internal.jsp"%>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"%>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<jsp:useBean id="notificationRulesForm" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm" scope="request"/>
<c:set var="inheritedRulesMap" value="${notificationRulesForm.inheritedRules}"/>
<c:set var="groups" value="<%=notificationRulesForm.getInheritedRules().keySet()%>"/>

<bs:linkScript>
  /js/bs/blocks.js
  /js/bs/blockWithHandle.js
  /js/bs/collapseExpand.js
</bs:linkScript>

<script type="text/javascript">
  BS.NotificationRuleForm.setNotificatorType('<%=WebUtil.encode(notificationRulesForm.getNotificatorType())%>');
  BS.NotificationRuleForm.setHolderId('${notificationRulesForm.editeeId}');
</script>

<div class="settingsBlock">
<c:if test="${not empty inheritedRulesMap}">
  <div class="settingsBlockTitle">Own rules</div>
</c:if>

<c:if test="${not notificationRulesForm.canEditRules and not empty notificationRulesForm.notificationsRules}">
  <n:readOnlyRules rules="${notificationRulesForm.notificationsRules}"/>
</c:if>

<c:if test="${notificationRulesForm.canEditRules}">
<c:if test="${fn:length(notificationRulesForm.notificationsRules) > 1}">
  <div>Use drag-and-drop to reorder the rules. The first matching rule will apply.</div>
</c:if>

<div class="messagesHolder">
  <div id="savingData"><i class="icon-refresh icon-spin"></i> Saving...</div>
  <div id="dataSaved">New notification rules order applied</div>
  <bs:messages key="ruleUpdated" style="margin: 0em; "/>
  <bs:messages key="ruleAdded" style="margin: 0em;"/>
  <bs:messages key="ruleDeleted" style="margin: 0em;"/>
</div>

<c:if test="${not empty notificationRulesForm.notificationsRules}">
  <c:set var="idsIndex">1</c:set>

  <div class="rulesWrapper">
    <table class="dark rulesTable">
      <thead>
        <tr class="header">
          <th class="dragHandle"><img src="<c:url value='/img/empty.png'/>" alt="" width="16" height="16" class="invisible" data-no-retina/></th>
          <th class="moveTop"><img src="<c:url value='/img/empty.png'/>" alt="" width="16" height="16" class="invisible" data-no-retina/></th>
          <th class="builds">Watching</th>
          <th class="condition">Send notification when</th>
          <th class="edit"><span style="visibility:hidden;">Edit</span></th>
          <th class="remove"><span style="visibility:hidden;">Delete</span></th>
        </tr>
      </thead>
    </table>

    <div id="notificationRulesRows">
    <c:set var="editing">${not empty notificationRulesForm.editingRule}</c:set>
    <c:forEach items="${notificationRulesForm.notificationsRules}" var="rule" varStatus="pos">
    <div class="draggable tc-icon_before icon16 tc-icon_draggable <c:choose>
           <c:when test="${editing and notificationRulesForm.editingRule.id == rule.id}">draggableEditingRow</c:when>
           <c:when test="${not editing and rule.addedOrEdited}">draggableChangedRow</c:when>
         </c:choose>" id="rule_${rule.id}">
      <jsp:useBean id="rule" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm.EditableNotificationRule"/>
      <table class="dark rulesTable">
        <tr>
          <td class="moveTop">
            <span id="id_${idsIndex}"
                 class="tc-icon icon16 tc-icon_move-top"
                 <c:if test="${pos.first}">style='visibility:hidden'</c:if>
                 onclick="BS.NotificationRuleForm.moveToTop('id_${idsIndex}')"
                 alt="Move to top"></span>
            <c:set var="idsIndex">${idsIndex + 1}</c:set>
          </td>
          <td class="builds">
            <n:watchedBuilds rule="${rule}"/>
          </td>
          <td class="condition">
            <n:eventsList rule="${rule}"/>
          </td>
          <td class="edit">
            <c:set var="onclick">BS.NotificationRuleForm.editRule('<c:url value='/notificationRules.html'/>', 'id_${idsIndex}')</c:set>
            <a id="id_${idsIndex}" href="#" onclick="${onclick}; return false">Edit</a>
            <c:set var="idsIndex">${idsIndex + 1}</c:set>
          </td>
          <td class="remove" title="Remove rule">
            <a id="id_${idsIndex}" href="#" onclick="BS.NotificationRuleForm.removeRule('<c:url value='/notificationRules.html'/>', 'id_${idsIndex}'); return false">Delete</a>
            <c:set var="idsIndex">${idsIndex + 1}</c:set>
          </td>
        </tr>
      </table>
    </div>
    </c:forEach>
    </div>
  </div>

  <script type="text/javascript">
    Sortable.create('notificationRulesRows', {
      tag : "div",
      onUpdate: function(el) {
        BS.NotificationRuleForm.scheduleUpdate(el);
      }
    });
  </script>
</c:if>

<c:if test="${empty ruleBean or not ruleBean.newRule}">
<div>
  <c:if test="${fn:startsWith(notificationRulesForm.editeeId, 'user:') and (fn:length(notificationRulesForm.notificationsRules) > 0 or fn:length(groups) > 0)}">
  <div class="smallNote" style="margin-left: 0; margin-bottom: .5em;">
    To unsubscribe from group notifications, add your own rule with the same watched builds and different notification events.
    To unsubscribe from all events, add a rule with the corresponding watched builds and no events selected. <bs:help file="Subscribing+to+Notifications"/>
  </div>
  </c:if>
  <c:url value='/notificationRules.html' var="editRuleUrl"/>
  <forms:addButton onclick="BS.NotificationRuleForm.editRule('${editRuleUrl}', null); return false">Add new rule</forms:addButton>
</div>
</c:if>

<c:if test="${not empty ruleBean}">
  <a name="ruleEditingForm"></a>
  <jsp:include page="/notificationRuleForm.jsp"/>
</c:if>

</c:if>
</div>

<br/>

<c:if test="${not empty inheritedRulesMap}">
<div class="settingsBlock">
  <div class="settingsBlockTitle">Inherited rules</div>

  <table class="rulesTable inheritedRulesTable dark">
    <thead>
      <tr class="header">
        <th class="group">Group</th>
        <th class="builds">Watching</th>
        <th class="condition">Send notification when</th>
      </tr>
    </thead>
    <c:forEach items="${groups}" var="group">
      <c:set var="inheritedRules" value="${inheritedRulesMap[group]}"/>
      <c:if test="${not empty inheritedRules}">
        <c:forEach items="${inheritedRules}" var="rule" varStatus="ruleStatus">
          <tr>
            <c:if test="${ruleStatus.first}">
              <td rowspan="${fn:length(inheritedRules)}" class="group">
                <bs:editGroupLink group="${group}"><strong><c:out value="${group.name}"/></strong></bs:editGroupLink>
                <c:if test="${not empty group.description}">
                  <div class="group-description"><c:out value="${group.description}"/></div>
                </c:if>
              </td>
            </c:if>
            <td class="watchedBuilds">
              <n:watchedBuilds rule="${rule}"/>
            </td>
            <td class="events">
              <n:eventsList rule="${rule}"/>
            </td>
          </tr>
        </c:forEach>
      </c:if>
    </c:forEach>
  </table>
</div>
</c:if>
