<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="agent" tagdir="/WEB-INF/tags/agent"%><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    attribute name="data" required="true" type="jetbrains.buildServer.controllers.agent.CompatibleConfigurationsBean"%><%@
    attribute name="selectedConfigurationsPolicy" required="true" type="java.lang.Boolean"%><%@
    attribute name="cssClass" required="true" type="java.lang.String"%><%@
    attribute name="active" required="true" type="java.lang.Boolean"

%>
<c:set var="nameSuffix" value=""/>
<c:if test="${not active}">
  <c:set var="nameSuffix" value="Inactive"/>
</c:if>
<table class="agentsCompatibilityTable">
  <tr>
    <th class="compatible ${cssClass}">
      <c:if test="${selectedConfigurationsPolicy}">
        <span class="toggleAll">
          <c:if test="${data.numCompatible > 0}">
            <forms:checkbox custom="${true}"
                            name="toggleAllCompatible${nameSuffix}"
                            onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all compatible configurations')"
                            onmouseout="BS.Tooltip.hidePopup()"
                            onclick="BS.AgentRunPolicy.toggle(this.checked, $('runConfigurationForm'), 'canRunCompatible${nameSuffix}')"/>
          </c:if>
          <c:if test="${data.numCompatible == 0}">&nbsp;</c:if>
        </span>
      </c:if>
      ${selectedConfigurationsPolicy ? 'Assigned compatible' : 'Compatible'} configurations (${data.numTotalCompatible})
    </th>
    <th class="empty">&nbsp;</th>
    <th class="incompatible ${cssClass}">
      <c:if test="${selectedConfigurationsPolicy}">
        <span class="toggleAll">
          <c:if test="${data.numIncompatible > 0}">
            <forms:checkbox custom="${true}"
                            name="toggleAllIncompatible${nameSuffix}"
                            onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all incompatible configurations')"
                            onmouseout="BS.Tooltip.hidePopup()"
                            onclick="BS.AgentRunPolicy.toggle(this.checked, $('runConfigurationForm'), 'canRunIncompatible${nameSuffix}')"/>
          </c:if>
          <c:if test="${data.numIncompatible == 0}">&nbsp;</c:if>
        </span>
      </c:if>
      ${selectedConfigurationsPolicy ? 'Assigned incompatible' : 'Incompatible'} configurations (${data.numTotalIncompatible})
    </th>
  </tr>
  <tr>
    <td class="compatible ${cssClass}">
      <c:forEach items="${data.compatibleByProject}" var="entry">
        <agent:projectCompatibleEntries project="${entry.key}"
                                        compatibilities="${entry.value}"
                                        compatible="true"
                                        selectedConfigurationsPolicy="${selectedConfigurationsPolicy}"/>
      </c:forEach>
      <c:if test="${data.numTotalCompatible == 0}">
        <div class="nothing">None</div>
      </c:if>
      <c:if test="${data.numInaccessibleCompatible > 0}">
        <div class="icon_before icon16 attentionComment">
          There <bs:are_is val="${data.numInaccessibleCompatible}"/> ${data.numInaccessibleCompatible}
          compatible build configuration<bs:s val="${data.numInaccessibleCompatible}"/> you do not have access to.
        </div>
      </c:if>
    </td>
    <td class="empty">&nbsp;</td>
    <td class="incompatible ${cssClass}">
      <c:forEach items="${data.incompatibleByProject}" var="entry">
        <agent:projectCompatibleEntries project="${entry.key}"
                                        compatibilities="${entry.value}"
                                        compatible="false"
                                        selectedConfigurationsPolicy="${selectedConfigurationsPolicy}"/>
      </c:forEach>
      <c:if test="${data.numTotalIncompatible == 0}">
        <div class="nothing">None</div>
      </c:if>
      <c:if test="${data.numInaccessibleIncompatible > 0}">
        <div class="icon_before icon16 attentionComment">
          There <bs:are_is val="${data.numInaccessibleIncompatible}"/> ${data.numInaccessibleIncompatible}
          incompatible build configuration<bs:s val="${data.numInaccessibleIncompatible}"/> you do not have access to.
        </div>
      </c:if>
    </td>
  </tr>
</table>
