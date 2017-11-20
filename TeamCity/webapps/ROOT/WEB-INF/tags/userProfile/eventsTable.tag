<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<jsp:useBean id="ruleBean" type="jetbrains.buildServer.controllers.profile.notifications.NotificationRulesForm.EditableNotificationRule" scope="request"/>

<table style="width: 65%;" class="eventsTable">
  <tr>
    <td><forms:checkbox name="editingEvents['BUILD_STARTED']" checked="${ruleBean.editingEvents['BUILD_STARTED']}"/> <label for="editingEvents['BUILD_STARTED']">Build started</label></td>
    <td><forms:checkbox name="editingEvents['BUILD_FAILING']" checked="${ruleBean.editingEvents['BUILD_FAILING']}"/> <label for="editingEvents['BUILD_FAILING']">Build failing</label></td>
  </tr>
  <tr>
    <td><forms:checkbox name="editingEvents['BUILD_FINISHED_SUCCESS']" checked="${ruleBean.editingEvents['BUILD_FINISHED_SUCCESS']}"/> <label for="editingEvents['BUILD_FINISHED_SUCCESS']">Build successful</label></td>
    <td><forms:checkbox name="editingEvents['BUILD_FINISHED_FAILURE']" checked="${ruleBean.editingEvents['BUILD_FINISHED_FAILURE']}"/> <label for="editingEvents['BUILD_FINISHED_FAILURE']">Build failed</label></td>
  </tr>
  <tr>
    <td><forms:checkbox name="editingEvents['RESPONSIBILITY_CHANGES']" checked="${ruleBean.editingEvents['RESPONSIBILITY_CHANGES']}"/> <label for="editingEvents['RESPONSIBILITY_CHANGES']">Responsibility changes</label></td>
    <td>&nbsp;</td>
  </tr>
</table>

