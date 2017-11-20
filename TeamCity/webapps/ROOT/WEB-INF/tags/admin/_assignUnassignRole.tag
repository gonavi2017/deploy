<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="availableRolesBean" type="jetbrains.buildServer.controllers.user.AvailableRolesBean" required="true"
  %><%@attribute name="formId" required="true"
  %><%@attribute name="dialogObject" required="true"
  %><%@attribute name="assignMode" required="true" %>
<c:set var="projectsMap" value="${availableRolesBean.projectsMap}"/>
<c:set var="projects" value="${availableRolesBean.collectProjects(projectsMap)}" />
<script type="text/javascript">
  ${dialogObject}._projectBasedRoles = {};
  ${dialogObject}._roles = {};
  ${dialogObject}._projects = {};
  <c:forEach items="${projects}" var="id2project">${dialogObject}._projects['${id2project.key}'] = {id: '${id2project.value.externalId}', name: '<bs:escapeForJs text="${id2project.value.extendedName}"/>', fullName: '<bs:escapeForJs text="${id2project.value.fullName}"/>'};
  </c:forEach>
  <c:forEach items="${projectsMap}" var="entry">
    <c:set var="roleBean" value="${entry.key}"/>
    <c:set var="projectBeans" value="${entry.value}"/>
    <c:if test="${roleBean.projectAssociationSupported}">${dialogObject}._projectBasedRoles['${roleBean.role.id}'] = true;</c:if>
    ${dialogObject}._roles['${roleBean.role.id}'] = {
      name: '<bs:escapeForJs text="${roleBean.role.name}"/>',
      projects: []
    };
    <c:forEach items="${projectBeans}" var="bean"><c:choose><c:when
      test="${null == bean}">${dialogObject}._roles['${roleBean.role.id}'].projects.push({id: '', name: ''});<c:set var="globalScopeAvailable" value="true"/></c:when>
    <c:otherwise>${dialogObject}.push('${roleBean.role.id}', '${bean.project.projectId}', ${availableRolesBean.isRoleCanBeGranted(roleBean.role, bean.project)}, '${bean.limitedDepth}');</c:otherwise></c:choose></c:forEach>
  </c:forEach>
</script>
<table width="100%" class="assignUnassignRoleDialogTable">
  <tr>
    <td valign="top" class="header"><label for="${formId}_role">Role: </label></td>
    <td valign="top">
      <forms:select name="role" id="${formId}_role" onchange="${dialogObject}.roleChanged()" className="longField" enableFilter="true">
        <c:forEach items="${projectsMap}" var="entry">
          <c:set var="roleBean" value="${entry.key}"/>
          <forms:option value="${roleBean.role.id}"><c:out value="${roleBean.role.name}"/></forms:option>
        </c:forEach>
      </forms:select>
    </td>
  </tr>
  <tr>
    <td></td>
    <td>
      <span class="grayNote" style="margin-right: 2em; font-size: 85%; float: right;">View "<span id="${formId}_roleName"></span>" role <a href="#" onclick="${dialogObject}.showRolesDescription(); return false" title="View role permissions">permissions</a></span>
    </td>
  </tr>
  <c:if test="${globalScopeAvailable}">
    <tr class="globalScopeRow">
      <td valign="top">Scope:</td>
      <td><div class="globalText"></div></td>
    </tr>
  </c:if>
  <tr class="projectsRow">
    <td valign="top"><label for="${formId}_projectId">Scope: </label></td>
    <td valign="top">
      <bs:inplaceFilter containerId="${formId}_projectId" afterApplyFunc="function() {BS.expandMultiSelect($j('#${formId}_projectId'))}" activate="true" filterText="&lt;filter projects>" className="longField"/>
      <forms:selectMultipleHScroll name="projectId" id="${formId}_projectId" wrapperClassName="select-multiple__wrapper_change-user-roles longField"/>
    </td>
  </tr>
</table>
<input class="roleScopeInput" type="hidden" name="roleScope" value="${not globalScopeAvailable ? 'perProject' : ''}"/>
