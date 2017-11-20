<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="project" scope="request" type="jetbrains.buildServer.serverSide.SProject"/>
<jsp:useBean id="controllerPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="resourcesPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="updateAllowed" scope="request" type="java.lang.Boolean"/>
<jsp:useBean id="spec" scope="request" type="jetbrains.buildServer.runners.metaRunner.ui.model.MetaSpecEditBean"/>
<c:url var="controllerUrl" value="${controllerPath}"/>

<bs:linkCSS>
  ${resourcesPath}/editRunner.css
</bs:linkCSS>
<bs:linkScript>
  ${resourcesPath}/editRunner.js
</bs:linkScript>

<div class="metaRunnerEditSettings section noMargin" data-project-id="${project.externalId}" data-controller="${controllerUrl}" data-meta-runner-id="${spec.runType}">
  <h2 class="noBorder">Meta-Runners</h2>
  <bs:smallNote>In this section you can edit the selected meta runner<bs:help file="Working+with+Meta-Runner"/></bs:smallNote>

  <form action="#">
    <table class="runnerFormTable metaRunnerParameters">
      <tr>
        <th>ID:</th>
        <td><c:out value="${spec.runType}"/></td>
      </tr>
      <tr>
        <th>Name:</th>
        <td><c:out value="${spec.shortName}"/></td>
      </tr>
      <tr>
        <th>Description:</th>
        <td><c:out value="${spec.description}"/></td>
      </tr>
      <tr>
        <th>Usages:</th>
        <td>
          <bs:changeRequest key="it" value="${spec}">
            <%@ include file="runnerUsages.jspf"%>
          </bs:changeRequest>
        </td>
      </tr>
      <tr>
        <th>Source:</th>
        <td></td>
      </tr>
    </table>

    <c:set var="editable" value="${afn:permissionGrantedForProject(project, 'EDIT_PROJECT')}"/>
    <textarea id="metaRunnerContent" class="metaRunnerContent"><c:out value="${spec.content}"/></textarea>
    <br/>
    <span class="error" id="error_metaRunnerContent"></span>
    <br/>

    <c:if test="${not updateAllowed}">
      <div class="icon_before icon16 attentionComment">You do not have enough permissions to edit this meta-runner</div>
    </c:if>

    <div class="saveButtonsBlock">
      <c:if test="${updateAllowed}">
        <forms:submit label="Save" disabled="${not editable}"/>
      </c:if>
      <c:set var="cancelLink"><admin:editProjectLink projectId="${project.externalId}" withoutLink="true"/>&tab=metaRunner</c:set>
      <forms:cancel href="${cancelLink}"/>
      <forms:progressRing id="metaRunnerEditSaving" style="display:none;"/>
    </div>
  </form>
</div>
