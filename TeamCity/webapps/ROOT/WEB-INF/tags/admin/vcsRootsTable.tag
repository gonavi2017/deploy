<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout" %><%@
    taglib prefix="admfn" uri="/WEB-INF/functions/admin" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@
    attribute name="vcsRootsBean" required="true" type="jetbrains.buildServer.controllers.admin.projects.VcsSettingsBean"%><%@
    attribute name="pageUrl" required="true" type="java.lang.String"%><%@
    attribute name="buildForm" required="true" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm"%><%@
    attribute name="pageTitle" required="false" type="java.lang.String"
%><bs:messages key="vcsRootsUpdated"
/><bs:messages key="checkoutRulesUpdated"
/><bs:messages key="vcsRootUpdateFailure"
/>
<c:set value="<%=jetbrains.buildServer.serverSide.systemProblems.StandardSystemProblemTypes.VCS_CONFIGURATION%>" var="vcsProblemType"/>

<c:if test="${not empty vcsRootsBean.vcsRoots}">
  <l:tableWithHighlighting className="parametersTable" id="vcsRoots" highlightImmediately="true">
    <tr>
      <th colspan="3">Name</th>
      <th style="width: 20%;">Checkout Rules</th>
    </tr>
    <c:forEach items="${vcsRootsBean.vcsRoots}" var="vcsRootEntry" varStatus="status">
      <c:set var="vcsRoot" value="${vcsRootEntry.vcsRoot}"/>
      <c:set var="canEditVcsRoot" value="${afn:canEditVcsRoot(vcsRoot)}"/>
      <c:set var="highlight" value="${canEditVcsRoot ? 'highlight' : ''}"/>
      <admin:vcsRootEditScope vcsRootsBean="${vcsRootsBean}" vcsRoot="${vcsRoot}" buildForm="${buildForm}"/>
      <c:set var="cameFromUrl">${pageUrl}&init=1</c:set>
      <c:set var="editVcsRootLink"><admin:editVcsRootLink vcsRoot="${vcsRoot}" editingScope="${editingScope}" cameFromUrl="${pageUrl}" cameFromTitle="${pageTitle}" withoutLink="true"/></c:set>
      <c:set var="onclick"><c:if test="${canEditVcsRoot}">BS.openUrl(event, '${editVcsRootLink}');</c:if></c:set>
      <c:set var="inherited" value="${not buildForm.template and not vcsRootsBean.detacheableVcsRoots[vcsRoot.id]}"/>
      <tr>
        <td class="${highlight}" onclick="${onclick}">
          <admin:vcsRootName editingScope="${editingScope}" cameFromUrl="${pageUrl}" cameFromTitle="${pageTitle}" vcsRoot="${vcsRoot}"/>
          belongs to <admin:projectName project="${vcsRoot.project}"/>
          <c:if test="${inherited}"><span class="inheritedParam">(inherited)</span></c:if>
          <c:if test="${not buildForm.template}">
          <span style="float: right">
            <bs:systemProblemCountLabel problemsCount="${vcsRootsBean.vcsRootsProblemsCount[vcsRoot]}"
                                        onclick="BS.SystemProblemsPopup.showDetails('${buildForm.settingsBuildType.buildTypeId}', '${vcsProblemType}', '${vcsRoot.id}', true, this); return false;"/>

          </span>

            <c:set var="vri" value="${vcsRootsBean.instances[vcsRoot]}"/>
            <c:if test="${not empty vri}">
              <br>
              <bs:vcsRootInstanceInfo vri="${vri}"/>
            </c:if>

          </c:if>

        </td>
        <td class="edit ${highlight}" onclick="${onclick}">
          <c:choose>
            <c:when test="${canEditVcsRoot}">
              <a href="${editVcsRootLink}" showdiscardchangesmessage="false">Edit</a>
            </c:when>
            <c:otherwise>
              <span style="white-space:nowrap" title="You do not have enough permissions to edit this VCS root">cannot be edited</span>
            </c:otherwise>
          </c:choose>
        </td>
        <td class="edit" style="white-space: nowrap;">
          <c:choose>
            <c:when test="${not inherited and not buildForm.readOnly}">
              <a href="#" onclick="BS.EditVcsRootsForm.detachVcsRoot('${vcsRoot.externalId}'); return false" showdiscardchangesmessage="false">Detach</a>
            </c:when>
            <c:when test="${buildForm.readOnly}">
              <span title="Build configuration is in read-only mode">can't detach</span>
            </c:when>
            <c:otherwise>
              <span title="Inherited VCS roots cannot be detached">can't detach</span>
            </c:otherwise>
          </c:choose>
        </td>
        <!-- TODO: remove inline styles from here! -->
        <td style="white-space: nowrap;">
          <a href="#" showdiscardchangesmessage="false" onclick="BS.EditCheckoutRulesForm.showDialog('${vcsRoot.externalId}', '<bs:escapeForJs text="${vcsRoot.name}" forHTMLAttribute="true"/>', '<bs:escapeForJs text="${vcsRootEntry.checkoutRules.asString}" forHTMLAttribute="true"/>', ${inherited or buildForm.readOnly}); return false">${not inherited and not buildForm.readOnly ? 'Edit' : 'View'} checkout rules (${fn:length(vcsRootEntry.checkoutRules.body)})</a>
          <span style="display: none" id="vcsTreeSource_${vcsRoot.externalId}">
            <bs:vcsTree dirsOnly="true" callback="BS.EditCheckoutRulesForm.insertRule" vcsRootId="${vcsRoot.externalId}" treeId="vcsTree_${vcsRoot.externalId}"/>
          </span>
        </td>
      </tr>
    </c:forEach>
  </l:tableWithHighlighting>
</c:if>
