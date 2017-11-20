<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    attribute name="agentActionCode" required="true" %><%@
    attribute name="agentPoolsList" required="false" type="java.util.List" %><%@
    attribute name="selectedAgentPool" required="false" type="java.lang.String"

%><c:url value='/ajax.html' var="actionUrl"/>
<bs:modalDialog formId="${agentActionCode}"
                title="Enable agent"
                action="${actionUrl}"
                closeCommand="BS.Agent.close()"
                saveCommand="BS.Agent.submitChangeStatus()">
  <table border="0" style="width: 100%;">
    <tr>
      <td>
        <p class="tc-icon_before icon16 tc-icon_attention enableAgentWarning" id="disconnectedDisabledWarning" style="display:none;">Enabled agent can run builds only when <strong>connected</strong>.</p>
        <p class="tc-icon_before icon16 tc-icon_attention enableAgentWarning" id="disconnectedEnabledWarning" style="display:none;">No builds will run on this agent until it becomes <strong>connected</strong>.</p>
        <textarea name="reason" rows="5" cols="46" class="commentTextArea" onfocus="if (this.value == this.defaultValue) this.value = ''" onblur="if (this.value == '') this.value='&lt;your comment here&gt;'">&lt;your comment here&gt;</textarea>
      </td>
    </tr>
    <c:if test="${agentActionCode == 'changeAgentStatus'}">
      <tr>
        <td>
          <forms:checkbox name="should_restore_status" onclick="$('status_restoring_delay').disabled = !(this.checked);"/>
          <label for="should_restore_status" id="should_restore_status_label">Restore current status automatically in</label>
          <select name="status_restoring_delay" id="status_restoring_delay" disabled="true">
            <option selected="true" value="15">15 minutes</option>
            <option value="30">30 minutes</option>
            <option value="60">1 hour</option>
            <option value="120">2 hours</option>
            <option value="240">4 hours</option>
            <option value="480">8 hours</option>
            <option value="1440">1 day</option>
            <option value="2880">2 days</option>
            <option value="7200">5 days</option>
          </select>
        </td>
      </tr>
    </c:if>
    <c:if test="${agentActionCode == 'changeAuthorizeStatus' and not empty agentPoolsList}">
      <tr>
        <td>
          <div id="agent_pool_chooser_div">
            Associate with pool:
            <forms:select name="agent_pool" style="width: 18em; margin-left: 1.5em;" enableFilter="true">
              <c:forEach items="${agentPoolsList}" var="agentPool">
                <%--@elvariable id="agentPool" type="jetbrains.buildServer.serverSide.agentPools.AgentPool"--%>
                <authz:authorize anyPermission="AUTHORIZE_AGENT_FOR_PROJECT,AUTHORIZE_AGENT" checkGlobalPermissions="true" projectIds="${agentPool.projectIds}">
                <forms:option value="${agentPool.agentPoolId}"
                              selected="${selectedAgentPool == agentPool.agentPoolId}"><c:out value="${agentPool.name}"/></forms:option>
                </authz:authorize>
              </c:forEach>
            </forms:select>
          </div>
        </td>
      </tr>
    </c:if>
  </table>
  <input type="hidden" name="${agentActionCode}" value=""/>
  <input type="hidden" name="enable" value=""/>

  <div class="popupSaveButtonsBlock">
    <forms:submit label="Enable" id="${agentActionCode}SubmitButton"/>
    <forms:cancel onclick="BS.Agent.close()"/>
    <forms:saving id="${agentActionCode}Progress"/>
  </div>
</bs:modalDialog>