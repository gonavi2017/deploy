<%@ page import="java.util.TimeZone" %>
<%@ page import="jetbrains.buildServer.buildTriggers.scheduler.CronFieldInfo" %>
<%@ page import="jetbrains.buildServer.serverSide.Branch" %>
<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util"%>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<tr>
  <td colspan="2">
    <script type="text/javascript">
      var tabs = new TabbedPane("schedulerTabs");
      tabs.addTab('schedulerConditions', {
        caption: 'Triggering Conditions',
        url: '#',
        onselect: function() {
          $j('#conditionsContainer').show();
          $j('#optionsContainer').hide();
          BS.MultilineProperties.updateVisible();
          return false;
        }
      });
      tabs.addTab('schedulerOptions', {
        caption: 'Additional Options',
        url: '#',
        onselect: function() {
          $j('#conditionsContainer').hide();
          $j('#optionsContainer').show();
          BS.MultilineProperties.updateVisible();
          return false;
        }
      });

      tabs.showIn('schedulerTabs');
      tabs.setActiveCaption('schedulerConditions');
    </script>
    <div id="schedulerTabs" class="simpleTabs clearfix"></div>

    <div>

      <div id="conditionsContainer">
        <table class="runnerFormTable date-and-time-conditions">
          <tr>
            <td colspan="2"><em>Trigger build if all of the following conditions are met.</em></td>
          </tr>
          <tr class="groupingTitle">
            <td colspan="2">Date and Time</td>
          </tr>
          <tr>
            <td class="_label"><label for="schedulingPolicy">When:</label></td>
            <td>
              <c:set var="onchange">{
                var idx = $('schedulingPolicy').selectedIndex;
                $('weeklyPolicy').style.display = idx == 1 ? '' : 'none';
                $('cronPolicy').style.display = idx == 2 ? '' : 'none';
                $('dailyPolicy').style.display = idx == 0 || idx == 1 ? '' : 'none';
                if (idx == 2) {
                $('cronHelp').show();
                } else {
                $('cronHelp').hide();
                }
                BS.MultilineProperties.updateVisible();
                }</c:set>
              <props:selectProperty name="schedulingPolicy" onchange="${onchange}">
                <props:option value="daily">daily</props:option>
                <props:option value="weekly">weekly</props:option>
                <props:option value="cron">advanced (cron expression)</props:option>
              </props:selectProperty> <bs:help id="cronHelp" file="Configuring+Schedule+Triggers" style="${propertiesBean.properties['schedulingPolicy'] == 'cron' ? '' : 'display: none;'}"/>
            </td>
          </tr>
          <tr id="weeklyPolicy" style="${propertiesBean.properties['schedulingPolicy'] == 'weekly' ? '' : 'display: none;'}">
            <td class="_label">
              <label for="dayOfWeek">Day of the week:</label>
            </td>
            <td>
              <props:selectProperty name="dayOfWeek">
                <props:option value="Sunday">Sunday</props:option>
                <props:option value="Monday">Monday</props:option>
                <props:option value="Tuesday">Tuesday</props:option>
                <props:option value="Wednesday">Wednesday</props:option>
                <props:option value="Thursday">Thursday</props:option>
                <props:option value="Friday">Friday</props:option>
                <props:option value="Saturday">Saturday</props:option>
              </props:selectProperty>
            </td>
          </tr>
          <tr id="dailyPolicy" style="${propertiesBean.properties['schedulingPolicy'] == 'cron' ? 'display: none;' : ''}">
            <td class="_label">
              <label for="hour">Time (HH:mm):</label>
            </td>
            <td>
              <props:selectProperty name="hour">
                <c:forEach begin="0" end="23" step="1" varStatus="pos">
                  <props:option value="${pos.index}"><c:if test="${pos.index < 10}">0</c:if>${pos.index}</props:option>
                </c:forEach>
              </props:selectProperty>
              <props:selectProperty name="minute">
                <c:forEach begin="0" end="59" step="5" varStatus="pos">
                  <props:option value="${pos.index}"><c:if test="${pos.index < 10}">0</c:if>${pos.index}</props:option>
                </c:forEach>
              </props:selectProperty>
            </td>
          </tr>
          <tr id="cronPolicy" style="${propertiesBean.properties['schedulingPolicy'] == 'cron' ? '' : 'display: none;'}">
            <td colspan="2" class="cron-policy-wrapper">
              <table style="width: 100%; padding: 0">
                <tr>
                  <c:set var="cronFields" value="<%=CronFieldInfo.values()%>"/>
                  <c:forEach items="${cronFields}" var="field">
                    <c:set var="fieldElement" value="cronExpression_${field.key}"/>
                    <td class="cron-field _top">
                      <props:textProperty name="${fieldElement}" maxlength="100" className="disableBuildTypeParams"/>
                      <span class="error" id="error_${fieldElement}"></span>
                      <bs:smallNote><c:out value="${field.caption}"/><br/><c:out value="${field.descr}"/></bs:smallNote>
                    </td>
                  </c:forEach>
                </tr>
              </table>
              <span class="error" id="error_cronExpressionError"></span>
            </td>
          </tr>
          <tr class="noBorder advancedSetting" id="timezoneProps">
            <td class="_label">
              <label for="timezone">Timezone:</label>
            </td>
            <td class="noBorder">
              <c:set var="serverTimeZone" value="<%=TimeZone.getDefault()%>"/>
              <props:selectProperty name="timezone" enableFilter="true">
                <props:option value="SERVER">Server Time Zone - ${util:formatTimeZone(serverTimeZone)}</props:option>
                <c:forEach items="${util:timeZones()}" var="zone">
                  <props:option value="${zone.ID}">${util:formatTimeZone(zone)}</props:option>
                </c:forEach>
              </props:selectProperty>
            </td>
          </tr>
          <tr class="groupingTitle">
            <td colspan="2">VCS Changes</td>
          </tr>
          <tr>
            <td colspan="2">
              <props:checkboxProperty name="triggerBuildWithPendingChangesOnly"/>
              <label for="triggerBuildWithPendingChangesOnly">Trigger only if there are pending changes</label>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td class="_top _label">
              <label for="triggerRules" class="rightLabel">Trigger rules:</label><bs:help file="Configuring+Schedule+Triggers" anchor="buildTriggerRules"/>
            </td>
            <td class="_top">
              <admin:triggerRulesForm buildForm="${buildForm}"/>
            </td>
          </tr>
          <tr class="groupingTitle advancedSetting">
            <td colspan="2">Build Changes</td>
          </tr>
          <jsp:include page="/admin/triggers/schedulingTriggerBuildDependency.html"/>
        </table>
      </div>

      <div id="optionsContainer" style="display: none;">
        <table class="runnerFormTable">
          <tr>
            <td>
              <props:checkboxProperty name="enforceCleanCheckout" onclick="if (!this.checked) $j('#enforceCleanCheckoutForDependencies').prop('checked', false)"/>
              <label for="enforceCleanCheckout">Clean all files in checkout directory before build</label>
            </td>
          </tr>
          <tr>
            <td>
              <div style="padding-left: 1.5em; margin-top: -0.5em">
                <props:checkboxProperty name="enforceCleanCheckoutForDependencies" onclick="if (this.checked) $j('#enforceCleanCheckout').prop('checked', true)"/>
                <label for="enforceCleanCheckoutForDependencies" >apply to all snapshot dependencies</label>
              </div>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td>
              <props:checkboxProperty name="triggerBuildOnAllCompatibleAgents"/>
              <label for="triggerBuildOnAllCompatibleAgents">Trigger build on all enabled and compatible agents</label>
            </td>
          </tr>
          <tr class="advancedSetting">
            <td>
              <props:checkboxProperty name="enableQueueOptimization"/>
              <label for="enableQueueOptimization">Queued build can be replaced with an already started build or a more recent queued build</label>
            </td>
          </tr>
          <c:set var="branchFilter" value="${propertiesBean.properties['branchFilter']}"/>
          <c:set var="defaultBranchFilter" value='+:*'/>
          <c:if test="${buildForm.branchesConfigured or (not empty branchFilter and branchFilter != defaultBranchFilter)}">
          <tr class="groupingTitle advancedSetting">
            <td>Trigger Build in Branches</td>
          </tr>
          <tr class="advancedSetting">
            <td>
              <c:set var="note">
                Newline-delimited set of rules in the form of +|-:logical branch name (with an optional * placeholder)<bs:help file="Configuring+VCS+Triggers" anchor="BranchFilter"/>.<br/>
                If branch filter matches several branches, then build is triggered in matched branches where pending changes and build changes conditions are met.
              </c:set>
              <props:multilineProperty name="branchFilter" linkTitle="Edit Branch Filter" cols="55" rows="3" note="${note}"/>
              <script type="text/javascript">
              BS.BranchesPopup.attachHandler('${buildForm.settingsId}', 'branchFilter');
              </script>
            </td>
          </tr>
          </c:if>
        </table>
      </div>

    </div>

  </td>
</tr>

