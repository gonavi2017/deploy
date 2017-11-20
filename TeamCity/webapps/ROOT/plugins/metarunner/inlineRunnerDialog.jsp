<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="availableProjects" scope="request" type="java.util.List"/>
<jsp:useBean id="project" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<jsp:useBean id="metaSpec" scope="request" type="jetbrains.buildServer.runners.metaRunner.config.MetaSpec"/>

<table class="runnerFormTable">
  <tr>
    <th><label for="targetProjectId" class="tableLabel">Parent project: <l:star/></label></th>
    <td>
      <bs:projectsFilter id="targetProjectId" name="targetProjectId" style="width: 29em;"
                         selectedProjectExternalId="${project.rootProject ? '' : project.externalId}"
                         disableRoot="true"
                         projectBeans="${availableProjects}"
                         defaultOption="true"/>
      <span class="smallNote">Select parent project for build configuration</span>
      <span class="error" id="targetProjectError"></span>
    </td>
  </tr>
  <tr>
    <th><label for="buildTypeName">Name: <l:star/></label></th>
    <td>
      <forms:textField name="buildTypeName" value="" className="longField" style="width: 30em"/>
      <span class="error" id="buildTypeNameError"></span>
    </td>
  </tr>
  <tr>
    <th><label for="buildTypeExternalId">Build configuration ID: <l:star/><bs:help file="Identifier"/></label></th>
    <td>
      <forms:textField name="buildTypeExternalId" value="" className="longField" style="width: 30em"/>
      <span class="smallNote">This ID is used in URLs, REST API, HTTP requests to the server, and configuration settings in the TeamCity Data Directory.</span>
      <span class="error" id="buildTypeExternalIdError"></span>
    </td>
  </tr>
</table>
<input type="hidden" name="runnerType" value="${metaSpec.runTypeInfo.type}"/>
<input type="hidden" name="projectId" value="${project.externalId}"/>
<script type="text/javascript">
  BS.AdminActions.prepareBuildTypeIdGenerator("buildTypeExternalId", "buildTypeName", $("targetProjectId"));
</script>
