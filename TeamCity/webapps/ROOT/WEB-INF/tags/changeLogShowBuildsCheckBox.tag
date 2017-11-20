<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="changeLogBean" required="true" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" %>
<forms:checkbox name="showBuilds" checked="${changeLogBean.showBuilds}" onclick="BS.ChangeLog.submitFilter(null)"/><label for="showBuilds">Show builds</label>