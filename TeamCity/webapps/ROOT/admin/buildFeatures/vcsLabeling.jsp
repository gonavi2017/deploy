<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>

<tr>
  <td colspan="2"><em>This build feature sets a label on a chosen VCS root upon build completion.</em></td>
</tr>
<tr class="noBorder">
  <th><label for="vcsRootId">VCS root to label:</label><bs:help file="VCS+Labeling"/></th>
  <td>
    <props:selectProperty name="vcsRootId" style="width: 99%;" enableFilter="true">
      <props:option value="">-- Choose VCS root to label --</props:option>
      <props:option value="__ALL__">&lt;All attached VCS roots&gt;</props:option>
      <c:forEach items="${buildForm.vcsRootsBean.vcsRootsWithLabelingSupport}" var="vcsRoot">
        <props:option value="${vcsRoot.externalId}"><c:out value="${vcsRoot.name}"/></props:option>
      </c:forEach>
    </props:selectProperty>
    <span class="error" id="error_vcsRootId"></span>
  </td>
</tr>
<tr class="noBorder">
  <th><label for="labelingPattern">Labeling pattern:</label></th>
  <td><props:textProperty name="labelingPattern" className="longField textProperty_max-width js_max-width"/></td>
</tr>
<c:if test="${buildForm.branchesConfigured}">
  <tr class="noBorder">
    <th>Label builds in branches:</th>
    <td>
      <c:set var="note">Newline-delimited set of rules in the form of +|-:logical branch name (with an optional * placeholder)<bs:help file="Configuring+VCS+Triggers" anchor="BranchFilter"/></c:set>
      <props:multilineProperty name="branchFilter" linkTitle="Branch filter" cols="35" rows="3" className="buildTypeParams" note="${note}"/>
      <span class="error" id="error_branchFilter"></span>

      <script type="text/javascript">
      BS.BranchesPopup.attachHandler('${buildForm.settingsId}', 'branchFilter');
      <c:if test="${buildForm.vcsRootsBean.defaultExcluded}">
        if ($('vcsRootId').value == '' && $('branchFilter').value == '+:<default>') {
          <%--
          when new feature is added (vcsRootId is empty) and default branch is excluded,
          configure a branch filter to include builds in all branches, because there will
          be no builds in the default branch
           --%>
          $('branchFilter').value = '+:*';
        }
      </c:if>
      </script>
    </td>
  </tr>
</c:if>
<tr class="noBorder">
  <th></th>
  <td><props:checkboxProperty name="successfulOnly" value="true"/> <label for="successfulOnly">Label successful builds only</label></td>
</tr>
