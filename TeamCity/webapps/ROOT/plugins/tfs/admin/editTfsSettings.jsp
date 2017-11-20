<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="cons" class="jetbrains.buildServer.buildTriggers.vcs.tfs.TfsConstants"/>

<table class="runnerFormTable">
  <l:settingsGroup title="TFS Settings">
    <tr>
      <th><label for="${cons.propertyUrl}">URL: <l:star/></label></th>
      <c:set var="tfsUrl" value="${propertiesBean.properties[cons.propertyUrl]}"/>
      <c:set var="tfsProtocol" value="${propertiesBean.properties[cons.propertyProtocol]}"/>
      <c:set var="tfsServer" value="${propertiesBean.properties[cons.propertyServer]}"/>
      <c:set var="tfsPort" value="${propertiesBean.properties[cons.propertyPort]}"/>
      <c:set var="aUrl"><c:choose
      ><c:when test="${not empty tfsUrl and fn:length(tfsUrl) gt 0}">${tfsUrl}</c:when
      ><c:when test="${not empty tfsProtocol and fn:length(tfsProtocol) gt 0}">${tfsProtocol}://${tfsServer}:${tfsPort}</c:when
      ></c:choose
      ></c:set>
      <td><props:textProperty name="${cons.propertyUrl}" className="longField" value="${aUrl}"/>
        <span class="error" id="error_${cons.propertyUrl}"></span>
      <span class="smallNote">
        URL format:<br/>
        TFS 2010+: http[s]://&lt;TFS Server&gt;:&lt;Port&gt;/tfs/&lt;Collection Name&gt;<br/>
        TFS 2005/2008: http[s]://&lt;TFS Server&gt;:&lt;Port&gt;<br/>
        Visual Studio Team Services: https://{account}.visualstudio.com
      </span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyRoot}">Root: <l:star/></label></th>
      <td><props:textProperty name="${cons.propertyRoot}" className="longField"/>
        <span class="error" id="error_${cons.propertyRoot}"></span>
        <span class="smallNote">TFS path to checkout. Format: $/path.</span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyUsername}">Username:</label></th>
      <td><props:textProperty name="${cons.propertyUsername}" className="longField"/>
        <span class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">Leave blank to use the TeamCity server user account.</span>
        <span class="smallNote">To login to VSTS you can use alternate credentials or access tokens
          <bs:help file="Team+Foundation+Server" anchor="VisualStudioOnline"/></span>
        <span class="error" id="error_${cons.propertyUsername}"></span></td>
    </tr>
    <tr>
      <th><label for="${cons.propertyPassword}">Password:</label></th>
      <td><props:passwordProperty name="${cons.propertyPassword}" className="longField"/>
        <span class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">Leave blank to use the TeamCity server user account</span>
        <span class="error" id="error_${cons.propertyPassword}"></span></td>
    </tr>
    <tr class="advancedSetting">
      <th class="noBorder"><label for="${cons.propertyForceAgentGet}">Agent checkout:</label></th>
      <td class="noBorder"><props:checkboxProperty name="${cons.propertyForceAgentGet}"/> Enforce overwrite all files
        <span class="error" id="error_${cons.propertyForceAgentGet}"></span></td>
    </tr>
  </l:settingsGroup>
</table>
