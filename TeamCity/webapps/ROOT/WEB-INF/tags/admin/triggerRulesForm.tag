<%@attribute name="caption" required="false" type="java.lang.String" %>
<%@attribute name="buildForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>

<props:multilineProperty name="triggerRules" linkTitle="${empty caption ? 'Edit Trigger Rules' : caption}" cols="35" rows="5" note="Newline-delimited set of rules: +|-:[Ant-like wildcard]"/>

<forms:addButton id="addNewRule" onclick="BS.AddTriggerRuleDialog.showDialog(); return false">Add new rule</forms:addButton>
<style type="text/css">
  #addTriggerRuleDialog {
    width: 36em;
  }

  #addTriggerRuleDialog table {
    width: 98%;
  }

  #addTriggerRuleDialog table th {
    width: 30%;
    font-weight: normal;
  }

  #addTriggerRuleDialog table td, #addTriggerRuleDialog table th {
    padding: 5px;
  }
</style>
<bs:dialog dialogId="addTriggerRuleDialog" title="Add Trigger Rule" closeCommand="BS.AddTriggerRuleDialog.close()">
  <table class="runnerFormTable">
    <l:settingsGroup title="Rule Type" mandatory="true"/>
    <tr>
      <th colspan="2"><forms:radioButton name="triggerBuild" id="triggerBuild1" value="true"/> <label for="triggerBuild1">Trigger
        build</label></th>
    </tr>
    <tr>
      <th colspan="2"><forms:radioButton name="triggerBuild" id="triggerBuild2" value="false"/> <label for="triggerBuild2">Do not
        trigger build</label></th>
    </tr>
    <l:settingsGroup title="Condition"/>
    <tr>
      <th><label for="username">VCS username:</label></th>
      <td><forms:textField name="username" style="width: 98%" className="buildTypeParams"/></td>
    </tr>
    <tr>
      <th><label for="vcsRoot">VCS root:</label></th>
      <td>
        <select name="vcsRoot" id="vcsRoot" style="width: 98%">
          <forms:option value="">&lt;any VCS root&gt;</forms:option>
          <c:if test="${not empty buildForm.vcsRootsBean.vcsRootsCollection}">
            <optgroup label="Own VCS roots">
              <c:forEach items="${buildForm.vcsRootsBean.vcsRootsCollection}" var="vcsRoot">
                <forms:option value="${vcsRoot.externalId}"><c:out value="${vcsRoot.name}"/></forms:option>
              </c:forEach>
            </optgroup>
          </c:if>
          <c:forEach items="${buildForm.vcsRootsBean.childDependenciesVcsRoots}" var="buildTypeVcsRoots">
            <optgroup label="<c:out value="${buildTypeVcsRoots.buildType.fullName}"/>">
            <c:forEach items="${buildTypeVcsRoots.vcsRoots}" var="vcsRoot">
              <forms:option value="${vcsRoot.externalId}"><c:out value="${vcsRoot.name}"/></forms:option>
            </c:forEach>
            </optgroup>
          </c:forEach>
        </select>
      </td>
    </tr>
    <tr>
      <th><label for="comment">Comment regexp:</label></th>
      <td><forms:textField name="comment" style="width: 98%" className="buildTypeParams" defaultText="<comment regexp>"/></td>
    </tr>
    <tr>
      <th><label for="wildcard">File wildcard:<l:star/></label></th>
      <td><forms:textField name="wildcard" style="width: 98%" value="**" className="buildTypeParams"/></td>
    </tr>
  </table>

  <div class="popupSaveButtonsBlock">
    <forms:submit type="button" label="Add Rule" onclick="BS.AddTriggerRuleDialog.submit()"/>
    <forms:cancel onclick="BS.AddTriggerRuleDialog.close()" showdiscardchangesmessage="false"/>
  </div>
</bs:dialog>
