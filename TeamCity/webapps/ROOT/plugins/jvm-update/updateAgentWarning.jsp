<%@ page import="jetbrains.buildserver.jvmUpdate.server.JvmUpdateController" %>
<%@include file="/include-internal.jsp" %>
<jsp:useBean id="jvmUpgradeControllerPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="agentJavaVersion" scope="request" type="java.lang.String"/>
<jsp:useBean id="opts" type="java.util.Collection<jetbrains.buildserver.jvmUpdate.server.OptionInfo>" scope="request"/>
<jsp:useBean id="buildAgent" type="jetbrains.buildServer.serverSide.BuildAgentEx" scope="request"/>

<c:set var="showUpdateDialog" value="${buildAgent.registered and fn:length(opts) gt 0}"/>
<div>
  <bs:messages key="<%=JvmUpdateController.MESSAGES_KEY%>"/>
  <span class="icon icon16 yellowTriangle agentVersion" <bs:tooltipAttrs text="Agent is running under Java ${agentJavaVersion} that will not be supported in future TeamCity releases" /> ></span>
  <c:choose>
    <c:when test="${buildAgent.agentType.details.cloudAgent}">
      Please update Java in <bs:agentDetailsLink agentType="${buildAgent.agentType}">${buildAgent.agentType.details.name}</bs:agentDetailsLink>
    </c:when>
    <c:when test="${showUpdateDialog}">
      <a href="#" onclick="BS.JVMUpdate.Dialog.showDialog()">Update Agent Java</a>
    </c:when>
    <c:when test="${not buildAgent.registered}">
      <a style="color:gray" title="Manual Java update is required: agent is disconnected">Update Agent Java</a>
    </c:when>
    <c:otherwise>
      <a style="color:gray" title="Manual Java update is required: no suitable Java is found on agent">Update Agent Java</a>
    </c:otherwise>
  </c:choose>
  <bs:help file="Setting+up+and+Running+Additional+Build+Agents" anchor="UpgradingJavaonAgents"/>
</div>

<div>
  <c:url var="postUrl" value="${jvmUpgradeControllerPath}"/>
  <bs:modalDialog formId="jvmUpdate" title="Update Agent Java" action="${postUrl}" closeCommand="BS.JVMUpdate.Dialog.close()" saveCommand="BS.JVMUpdate.Dialog.submitJvmUpdate()">
    <input type="hidden" name="agentId" id="agentId" value="${buildAgent.id}"/>
    <table class="runnerFormTable" style="width:99%;">
      <tr>
        <th style="vertical-align:top;">
          <label for="jvm">Path to Java:</label>
        </th>
        <td>
          <c:choose>
            <c:when test="${fn:length(opts) == 1}">
              <span><bs:makeBreakable text="${opts[0].pathToJava}" regex="[/\\\\]"/></span>
              <input type="hidden" name="jvm" id="jvm" value="${opts[0].key}"/>
            </c:when>
            <c:otherwise>
              <forms:select name="jvm" style="width: 90%;">
                <c:forEach var="opt" items="${opts}">
                  <forms:option value="${opt.key}"><bs:makeBreakable text="${opt.pathToJava}" regex="[/\\\\]"/></forms:option>
                </c:forEach>
              </forms:select>
              <span class="smallNote">Please select path to JRE or JDK to use by the agent.</span>
            </c:otherwise>
          </c:choose>
        </td>
      </tr>
      <tr class="noBorder">
        <td colspan="2">
          Java will be updated when the agent is idle. The build agent process will be restarted.
        </td>
      </tr>
    </table>

    <div class="saveButtonsBlock">
      <forms:submit label="Update Java"/>
      <forms:cancel onclick="BS.JVMUpdate.Dialog.close()"/>
      <forms:saving id="jvm-saving"/>
    </div>
  </bs:modalDialog>

</div>

<c:if test="${showUpdateDialog}">
  <script type="text/javascript">
    (function () {
      var parsedHash = BS.Util.paramsFromHash('&');
      if (parsedHash['updateJavaDialog']) {
        BS.Util.removeParamFromHash('updateJavaDialog', '&', true);
        BS.JVMUpdate.Dialog.showDialog();
      }
    })();
  </script>
</c:if>


