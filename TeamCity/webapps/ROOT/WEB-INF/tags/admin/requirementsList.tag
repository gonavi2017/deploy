<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ attribute name="requirementsBean" required="true" type="jetbrains.buildServer.controllers.buildType.RequirementsBean"%>
<%@ attribute name="requirements" required="true" type="java.util.Collection"%>
<%@ attribute name="editable" required="true" type="java.lang.Boolean"%>
<c:if test="${not empty requirements}">
<c:choose>
  <c:when test="${editable}">
    <l:tableWithHighlighting className="parametersTable">
      <tr style="background-color: #f5f5f5;">
        <th>Parameter Name</th>
        <th colspan="3">Condition</th>
      </tr>
      <c:forEach var="requirement" items="${requirements}">
      <c:set var="onclick">BS.EditRequirementDialog.showDialog('${requirement.id}', $('name_${requirement.id}').value, $('value_${requirement.id}').value, '${requirement.type.name}', ${requirement.inherited});</c:set>
      <c:set var="if_disabled">${requirement.enabled ? '' : 'contentDisabled'}</c:set>
      <tr>
        <td class="name highlight ${if_disabled}" onclick="${onclick}">
          <c:if test="${not requirement.compatibleWithAnything}">
            <span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="No agents satisfy this requirement."/>></span>
          </c:if>
          <c:out value="${requirement.parameterNameWithPrefix}"/>
          <admin:buildTypeSettingStatusDescription inherited="${requirement.inherited}" disabled="${not requirement.enabled}" overridden="${requirement.overridden}" />
        </td>
        <td class="value highlight ${if_disabled}" onclick="${onclick}">
          <admin:requirementValue requirementType="${requirement.type}" parameterValue="${requirement.parameterValue}" doNotHighlight="${true}"/>
        </td>
        <td class="edit highlight" onclick="${onclick}">
          <a href="#" onclick="${onclick}; Event.stop(event)">Edit</a>
          <input type="hidden" id="name_${requirement.id}" value="<c:out value='${requirement.parameterNameWithPrefix}'/>"/>
          <input type="hidden" id="value_${requirement.id}" value="<c:out value='${requirement.parameterValue}'/>"/>
        </td>
        <td class="edit">
          <c:set var="rqId" value="${requirement.id}"/>
          <bs:actionsPopup controlId="rqActions${rqId}"
                           popup_options="shift: {x: -150, y: 20}, className: 'quickLinksMenuPopup'">
                  <jsp:attribute name="content">
                    <div>
                      <ul class="menuList">
                        <c:if test="${requirement.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${requirement.id}', false, 'Requirement'); return false">Disable requirement</a>
                          </l:li>
                        </c:if>
                        <c:if test="${not requirement.enabled}">
                          <l:li>
                            <a href="#" onclick="BS.AdminActions.setParametersDescriptorEnabled('${buildForm.settingsId}', '${requirement.id}', true, 'Requirement'); return false">Enable requirement</a>
                          </l:li>
                        </c:if>
                        <c:choose>
                          <c:when test="${not requirement.inherited}">
                            <l:li>
                              <a href="#" onclick="BS.RequirementsForm.removeRequirement('${requirement.id}'); return false">Delete</a>
                            </l:li>
                          </c:when>
                          <c:when test="${requirement.inherited and requirement.overridden}">
                            <l:li>
                              <a href="#" onclick="BS.RequirementsForm.resetRequirement('${requirement.id}'); return false">Reset</a>
                            </l:li>
                          </c:when>
                        </c:choose>
                      </ul>
                    </div>
                  </jsp:attribute>
            <jsp:body></jsp:body>
          </bs:actionsPopup>
        </td>
      </tr>
      </c:forEach>
    </l:tableWithHighlighting>
  </c:when>
  <c:otherwise>
    <table class="parametersTable">
      <tr style="background-color: #f5f5f5;">
        <th>Parameter Name</th>
        <th>Condition</th>
      </tr>
      <c:forEach var="requirement" items="${requirements}">
      <c:set var="if_disabled">${requirement.enabled ? '' : 'contentDisabled'}</c:set>
      <tr>
        <td class="name  ${if_disabled}" >
          <c:if test="${not requirement.compatibleWithAnything}">
            <span class="icon icon16 yellowTriangle" <bs:tooltipAttrs text="No agents satisfy this requirement."/>></span>
          </c:if>
          <c:out value="${requirement.parameterNameWithPrefix}"/>
        </td>
        <td class="value  ${if_disabled}">
          <admin:requirementValue requirementType="${requirement.type}" parameterValue="${requirement.parameterValue}"/>
        </td>
      </tr>
      </c:forEach>
    </table>
  </c:otherwise>
</c:choose>
</c:if>


