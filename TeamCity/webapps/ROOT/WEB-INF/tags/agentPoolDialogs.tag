<%@ tag import="jetbrains.buildServer.serverSide.agentPools.AgentPoolConstants" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="poolNameMaxLength"><%=AgentPoolConstants.MAX_POOL_NAME_LENGTH%></c:set>

<authz:authorize allPermissions="MANAGE_AGENT_POOLS">

  <bs:dialog dialogId="PoolNameDialog"
             title=""
             closeCommand="BS.PoolNameDialog.close();"
             titleId="PoolNameDialogTitle">

    <div>
    </div>
    <table class="runnerFormTable">
      <tr>
        <th>      <label style="margin-right: 1em"
                         for="PoolNameDialogInputField">Pool name:</label>
        </th>
        <td>
          <input type="text"
                 style="width: 100%"
                 id="PoolNameDialogInputField"
                 value=""/>

        </td>
      </tr>
       <%--Temporary not in use--%>

<%--
      <tr>
        <th><label style="margin-right: 1em" for="MinAgentsDialogInputField">Min Agents:</label></th>
        <td><input type="text"
                         id="MinAgentsDialogInputField"
                         value=""/>
        </td>
      </tr>
--%>
      <tr>
        <th><label style="margin-right: 1em" for="MaxAgentsDialogInputField">Max Agents:</label><bs:help file="Agent+Pools#AgentPools-ManagingAgentPools"/>
          <input type="hidden" id="MinAgentsDialogInputField" value=""/>
        </th>
        <td>
          <input type="checkbox"
                 id="MaxAgentsDialogCheckbox"
                 value="-1"/> <label for="MaxAgentsDialogCheckbox">Unlimited</label>
          <div class="hidden" id="maxAgentsDiv">
            <input type="text"
                   id="MaxAgentsDialogInputField"
                   value=""/>
          </div>
        </td>
      </tr>
    </table>

    <div class="popupSaveButtonsBlock">
      <forms:submit
          id="PoolNameDialogSubmitButton"
          type="button"
          label="Save"
          onclick="BS.PoolNameDialog.doIt()"/>
      <forms:cancel onclick="BS.PoolNameDialog.close()" />
      <forms:saving id="agentPoolNameProgress"/>
    </div>
  </bs:dialog>

  <bs:dialog dialogId="RemovePoolDialog"
             title="Delete Agent Pool"
             closeCommand="BS.RemovePoolDialog.close();"
             titleId="RemovePoolDialogTitle">

    <div>
      <p>
        You are about to delete pool <b><span id="remove-pool-name"> </span></b>.
      </p>
      <p id="remove-agents-message">
        This pool contains <b><span id="remove-agents-number">0</span></b> agent<span id="remove-agents-singular">. It will be moved to the Default pool.</span><span id="remove-agents-plural">s. All of them will be moved to the Default pool.</span>
      </p>
      <p id="remove-projects-message">
        <b><span id="remove-projects-number">0</span></b> project<span id="remove-projects-singular"> is associated with this pool. It will be dissociated.</span><span id="remove-projects-plural">s are associated with this pool. All of them will be dissociated.</span>
      </p>
    </div>

    <div class="popupSaveButtonsBlock">
      <forms:submit
          id="RemovePoolDialogSubmitButton"
          type="button"
          label="Delete Pool"
          onclick="BS.RemovePoolDialog.doIt()"/>
      <forms:cancel onclick="BS.RemovePoolDialog.close()"/>
      <forms:saving id="agentPoolRemoveProgress"/>
    </div>
  </bs:dialog>

</authz:authorize>

<bs:dialog dialogId="DissociateLastProjectDialog"
           title="Dissociate last project from the pool"
           closeCommand="BS.DissociateLastProjectDialog.close();"
           titleId="DissociateLastProjectDialogTitle">

  <div>
    <p>
      You are about to dissociate project <b><span id="dissociate-last-project-name"> </span></b> from pool <b><span id="dissociate-last-project-from-pool-name"> </span></b>.
    </p>
    <p>
      This is the only project that is associated with this pool. If you dissociate it you will be unable to associate it back without global administrator. Are you sure you want to continue?
    </p>
  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit
        type="button"
        label="Dissociate project"
        onclick="BS.DissociateLastProjectDialog.doIt()"/>
    <forms:cancel onclick="BS.DissociateLastProjectDialog.close()"/>
  </div>
</bs:dialog>


<bs:dialog dialogId="DissociateParentWithChildren"
           title="Dissociate project from the pool"
           closeCommand="BS.withChildren.close();"
           titleId="DissociateParentWithChildrenTitle">
  <div>
    <forms:checkbox name="withChildren" checked="true" id="withChildren" onclick="BS.DissociateParentWithChildren.updateStatusText();"/><label for="withChildren"> dissociate all child projects</label>
  </div>
  <div id="removeWithChildrenDescription" style="display: none;">
    <p>
      You are about to dissociate project <b><span class="remove-project-name"></span></b> and all its children from pool <b><span class="remove-from-pool-name"></span></b>.
    </p>
    <p id="removeLastProjectInChildrenWarning" style="display: none;">There will be no more projects associated with this pool. You will be unable to associate any project back without global administrator.</p>
  </div>
  <div id="removeWithoutChildrenDescription" style="display: none;">
    <p>
      You are about to dissociate project <b><span class="remove-project-name"></span></b> from pool <b><span class="remove-from-pool-name"></span></b>.
    </p>
    <p id="removeLastProjectWarning" style="display: none;">This is the only project that is associated with this pool. If you dissociate it you will be unable to associate it back without global administrator. Are you sure you want to continue?</p>
  </div>
  <div id="removeChildrenOnlyDescription" style="display: none;">
    <p>
      You are about to dissociate all child projects of project <b><span class="remove-project-name"></span></b> from pool <b><span class="remove-from-pool-name"></span></b>.
    </p>
    <p id="removeLastProjectWarning" style="display: none;">There will be no more projects associated with this pool. You will be unable to associate any project back without global administrator. Are you sure you want to continue?</p>
  </div>
  <div class="popupSaveButtonsBlock">
    <forms:submit
        type="button"
        label="Dissociate projects"
        onclick="BS.DissociateParentWithChildren.doIt()"/>
    <forms:cancel onclick="BS.DissociateParentWithChildren.close()"/>
  </div>
</bs:dialog>

<bs:dialog dialogId="MoveAgentToDefaultPoolDialog"
           title="Move agent to Default pool"
           closeCommand="BS.MoveAgentToDefaultPoolDialog.close();"
           titleId="MoveAgentToDefaultPoolDialogTitle">

  <div>
    <p>
      You are about to move agent <b><span id="move-agent-to-default-pool-name"> </span></b> to <b><span>Default</span></b> pool.
    </p>
    <p>
      Please note that you will be unable to move it back without global administrator. Are you sure you want to continue?
    </p>
  </div>

  <div class="popupSaveButtonsBlock">
    <forms:submit
        type="button"
        label="Move agent"
        onclick="BS.MoveAgentToDefaultPoolDialog.doIt()"/>
    <forms:cancel onclick="BS.MoveAgentToDefaultPoolDialog.close()"/>
  </div>
</bs:dialog>
