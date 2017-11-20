<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<l:settingsGroup title="Branch Filter"/>
<tr>
  <th style="vertical-align: top;">
    <label for="branchFilter" class="rightLabel">Branch filter:</label><bs:help file="Configuring+VCS+Triggers" anchor="BranchFilter"/>
  </th>
  <td style="vertical-align: top;">
    <c:set var="note">Newline-delimited set of rules in the form of +|-:logical branch name (with an optional * placeholder)<bs:help file="Configuring+VCS+Triggers" anchor="BranchFilter"/></c:set>
    <props:multilineProperty name="branchFilter" linkTitle="Edit Branch Filter" cols="35" rows="3" note="${note}"/>
    <script type="text/javascript">
      <%--@elvariable id="buildTypeIdsFunc" type="java.lang.String"--%>
      <c:if test="${not empty buildTypeIdsFunc}">
      BS.BranchesPopup.attachBuildTypesHandler(${buildTypeIdsFunc}, 'branchFilter');
      </c:if>
      <c:if test="${empty buildTypeIdsFunc}">
      BS.BranchesPopup.attachHandler('${buildForm.settingsId}', 'branchFilter');
      </c:if>
      BS.MultilineProperties.updateVisible();
    </script>
  </td>
</tr>
