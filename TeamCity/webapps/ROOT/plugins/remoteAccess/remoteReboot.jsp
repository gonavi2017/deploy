<%@ include file="/include.jsp" %>
<jsp:useBean id="remoteAccessAgent" scope="request" type="jetbrains.buildServer.serverSide.SBuildAgent"/>
<div class="rebootControl rebootAfterBuild"><img src="<c:url value='/img/attentionComment.png'/>" class="icon"/> Agent is scheduled to reboot after current build finishes</div>
<div class="rebootControl reboot"><img src="<c:url value='/img/attentionComment.png'/>" class="icon"/> Agent is scheduled to reboot</div>
<div class="rebootControl localhost"><a style="color:gray" title="Can not reboot: this agent is installed on TeamCity server host">Reboot agent machine</a></div>
<div class="rebootControl default">
<bs:dialog dialogId="rebootAgent" title="Confirm reboot" closeCommand="BS.RebootAgentDialog.close();">
  <forms:saving id="rebootAgentLoader"/>
  Warning: This will reboot host [<c:out value="${remoteAccessAgent.hostAddress}"/>]<p/>
  <forms:checkbox name="rebootAfterBuild" checked="true"/><label for="rebootAfterBuild">Wait for current build to finish</label>
  <div class="popupSaveButtonsBlock">
    <c:set var="rebootCommand">BS.RebootAgentDialog.sendReboot('<c:url value="${remoteAccessAgent.id}"/>');</c:set>
    <forms:button onclick="${rebootCommand}">Reboot</forms:button>
    <forms:button onclick="BS.RebootAgentDialog.close();" showdiscardchangesmessage="false">Cancel</forms:button>
  </div>
</bs:dialog>
<a onclick="BS.RebootAgentDialog.showCentered(); return false" href="#">Reboot agent machine</a>
</div>
<script type="text/javascript">
  BS.Util.toggleDependentElements('<c:out value="${state}"/>', 'rebootControl');
</script>