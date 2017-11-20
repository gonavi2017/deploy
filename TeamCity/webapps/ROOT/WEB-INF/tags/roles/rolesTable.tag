<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@attribute name="rolesList" type="java.util.List" required="true" %>
<%@attribute name="editable" type="java.lang.Boolean" required="true" %>
<%@attribute name="showTableCaption" type="java.lang.Boolean" required="false" %>
<%@attribute name="modifiableRolesAvailable" type="java.lang.Boolean" required="true" %>
<table class="settings userRolesTable ${editable ? 'editable' : ''}">
<c:if test="${empty showTableCaption or showTableCaption}">
  <tr style="background-color: #f5f5f5;">
    <th class="roleProjects">Projects</th>
    <th class="roleName">Role</th>
    <c:if test="${editable and modifiableRolesAvailable}">
      <th class="unassign">
        <forms:checkbox name="selectAll"
                        onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all roles')"
                        onmouseout="BS.Tooltip.hidePopup()"
                        onclick="if (this.checked) BS.UnassignRolesForm.selectAll(true); else BS.UnassignRolesForm.selectAll(false)"/>
      </th>
    </c:if>
  </tr>
</c:if>  
  <c:forEach items="${rolesList}" var="roleBean">
    <tr>
      <td class="roleProjects">
        <c:choose>
          <c:when test="${empty roleBean.project}">
            <c:choose>
              <c:when test="${roleBean.projectAssociationSupported or roleBean.projectPermissionsAvailable}">&lt;Root project&gt;</c:when>
              <c:otherwise><i>N/A</i></c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <bs:projectLinkFull project="${roleBean.project}"/>
            <span class="grayNote" style="margin-left: 1em;"><i>(and all its subprojects)</i></span>
          </c:otherwise>
        </c:choose>
      </td>
      <td class="roleName"><c:out value="${roleBean.role.name}"/></td>
      <c:if test="${editable and modifiableRolesAvailable}">
      <td class="edit unassign">
        <c:if test="${roleBean.modifiable}">
          <forms:checkbox name="unassign" value="${roleBean.role.id}:${empty roleBean.project ? '' : roleBean.project.projectId}"/>
        </c:if>
      </td>
      </c:if>
    </tr>
  </c:forEach>
</table>
