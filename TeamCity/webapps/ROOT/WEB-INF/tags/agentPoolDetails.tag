<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ attribute name="pool" required="true" type="jetbrains.buildServer.controllers.agent.PoolBox"%>
<%@ attribute name="defaultPoolAdmin" required="false" type="java.lang.Boolean"%>
<%@ attribute name="includeDialogs" required="true" type="java.lang.Boolean"
              description="Set to true to make all action accessible from a 'Single pool details' page. Set to false and include bs:agentPoolDialogs direcly in any page with list of agent pools" %>
<%@ attribute name="includeHeader" required="true" type="java.lang.Boolean"
              description="Set to true to make pool name and related actions visible on a 'Single pool details' page. Set to false when pools list page has pool name already included" %>

<c:set var="poolId" value="${pool.agentPool.agentPoolId}"/>
<c:set var="poolName"><c:out value='${pool.agentPool.name}'/></c:set>
<c:set var="poolNameForJS"><bs:escapeForJs text="${pool.agentPool.name}" forHTMLAttribute="${true}"/></c:set>

<div id="pool-${poolId}" class="pool-box">
  <c:if test="${includeHeader}">
    <bs:agentPoolHeader pool="${pool}"/>
  </c:if>

    <table class="pool-layout-table">
    <tr>
      <td class="pool-layout-content agents">
          <c:if test="${pool.admin && pool.canAddMoreAgentTypes}">
              <div class="head-row">
                 <forms:addButton onclick="BS.AP.clickOnAddAgentType(${poolId}, this); return false">Assign agents...</forms:addButton>
                  <c:if test="${not pool.poolHasCapacity}">
                      <span class="icon icon16 yellowTriangle" style="margin-left:5px; vertical-align: middle"
                          <bs:tooltipAttrs text="Pool capacity is full. No agents can be added or registered."/> ></span>
                      Pool capacity is full
                  </c:if>
              </div>
          </c:if>
          <c:if test="${empty pool.agents}">
              <div class="head-row info" style="padding-left: 20px;">No assigned agents</div>
          </c:if>
        <table class="agents-list">

          <c:forEach items="${pool.agents}" var="agt">

            <c:set var="agtId" value="${agt.id}"/>
            <c:set var="crossId" value="pool_${poolId}_agt_${agtId}"/>
            <c:set var="agtName"><c:out value='${agt.name}'/></c:set>
            <c:set var="agtNameForJS"><bs:escapeForJs text="${agt.name}" forHTMLAttribute="${true}"/></c:set>

            <tr class="agt-row">
              <td width="15px">
                <c:if test="${agt.cloudAgent}">
                  <span class="icon icon16 cloudIcon" title="Cloud agent image"></span>
                </c:if>
              </td>
              <td style="padding-left: 7px; width: 1%;">
                <bs:osIcon osName="${agt.OSName}" small="true"/>
              </td>
              <td class="agentNameRow">
                <bs:agentDetailsLink agentName="${agt.name}" agentTypeId="${agtId}"/>
              </td>
              <td width="15%">
                      <span class="agent-note">
                        <c:if test="${not agt.cloudAgent}">
                          <c:set var="instance1" value="${agt.firstInstance}"/>
                          <c:if test="${instance1 ne null}">
                            <c:if test="${instance1.authorized and instance1.registered and not instance1.enabled}">
                              <span class="agent-bad-status red-text" title="<c:out value="${instance1.statusComment.comment}"/>">Disabled</span>
                            </c:if>
                            <c:if test="${instance1.authorized and not instance1.registered}">
                              <span class="agent-bad-status red-text" title="<bs:disconnectedStatusTitle agent='${instance1}'/>">Disconnected</span>
                            </c:if>
                            <c:if test="${not instance1.authorized}">
                              <span class="agent-bad-status red-text" title="<c:out value="${instance1.authorizeComment.comment}"/>">Not authorized</span>
                            </c:if>
                          </c:if>
                        </c:if>
                        <c:if test="${agt.cloudAgent}">
                          <c:if test="${not empty(agt.instances)}">
                            <c:set var="agtInstancesCount" value="${fn:length(agt.instances)}"/>
                            <b>${agtInstancesCount}</b> agent<bs:s val="${agtInstancesCount}"/>
                          </c:if>
                        </c:if>
                      </span>
              </td>
              <td>
                      <span class="agent-note">
                        <c:if test="${agt.incompatibleWarning or agt.willRunNothingWarning}">
                          <c:if test="${agt.incompatibleWarning}">
                            <c:set var="warningShortcut" value="Incompatible"/>
                            <c:set var="warningNote" value="This build agent is not compatible with any of build configurations from projects assigned to this pool."/>
                          </c:if>
                          <c:if test="${agt.willRunNothingWarning and not agt.incompatibleWarning}">
                            <c:set var="warningShortcut" value="Incompatible"/>
                            <c:set var="warningNote" value="Run policy of this agent doesn't allow to run build configurations from projects associated with this pool."/>
                          </c:if>
                          <i class="tc-icon icon16 tc-icon_attention_red" title="${warningNote}"></i>
                          <a href="agentDetails.html?agentTypeId=${agtId}&tab=agentCompatibleConfigurations"
                             title="${warningNote}"><span title="${warningNote}">${warningShortcut}</span>
                          </a>
                        </c:if>
                      </span>
              </td>
              <td class="remove-cell" width="30px">

                <c:choose>
                  <c:when test="${pool.admin && !(pool.defaultPool ||  pool.projectPool) && defaultPoolAdmin}">
                    <a href="#"
                       id="drop-agt-${agtId}-cross"
                       onclick="{BS.AP.clickOnDropAgentCross(${agtId}, ${!defaultPoolAdmin}, '${agtNameForJS}'); return false;}"
                       title="Move ${agtName} to Default pool"
                    >&#xd7;</a>
                    <forms:saving id="drop-agt-${agtId}-progress"/>
                  </c:when>
                  <c:otherwise>&nbsp;</c:otherwise>
                </c:choose>
              </td>
            </tr>

          </c:forEach>

        </table>

      </td>
      <td class="pool-layout-content projects">
         <c:if test="${pool.admin && pool.canAddMoreProjects}">
            <div class="head-row">
              <forms:addButton onclick="BS.AP.clickOnAssociateProjects(${poolId}, this); return false">Assign projects...</forms:addButton>
            </div>
        </c:if>
        <c:set var="poolProjects" value="${pool.allProjects}"/>
        <c:if test="${pool.projectsCount==0 and pool.hiddenProjectCount == 0}">
            <div class="head-row info" style="padding-left: 20px;">No assigned projects</div>
        </c:if>
        <c:if test="${not empty poolProjects}">
          <table class="projects-list" data-pid="${poolId}">
            <c:forEach items="${poolProjects}" var="poolProject">

              <c:set var="project" value="${poolProject.project}"/>
              <c:set var="projectId"><c:out value='${project.projectId}'/></c:set>
              <c:set var="projectName"><c:out value='${project.name}'/></c:set>
              <c:set var="projectNameForJS"><bs:escapeForJs text="${project.name}" forHTMLAttribute="${true}"/></c:set>
              <c:set var="associatedPools" value="${poolProject.associatedPools}"/>
              <c:set var="associatedPoolsCount" value="${poolProject.associatedPoolsCount}"/>
              <c:set var="removableChildrenCount" value="${poolProject.removableChildrenCount}"/>
              <c:set var="crossId" value="drop-pro-${projectId}-from-pool-${poolId}-cross"/>
              <c:set var="rowClass" value="associated"/>
              <c:if test="${!poolProject.associated}">
                <c:set var="rowClass" value="not-associated"/>
              </c:if>
              <c:if test="${poolProject.archived}">
                <c:set var="rowClass" value="associated archived"/>
                <c:if test="${pool.hideArchivedProjects}">
                  <c:set var="rowClass" value="${rowClass} invisible"/>
                </c:if>
              </c:if>
              <c:if test="${poolProject.canBeDissociated}">
                <c:set var="rowClass" value="${rowClass} canBeDissociated"/>
              </c:if>
              <c:if test="${removableChildrenCount>0}">
                <c:set var="rowClass" value="${rowClass} hasRemovableChildren"/>
              </c:if>
              <tr class="project-row ${rowClass}" data-depth="${poolProject.depth}" data-pid="${projectId}">
                <td>
                    <%--<a href="project.html?projectId=${project.externalId}" id="pool-${poolId}-project-${projectId}" class="project-name"><bs:trimWithTooltip trimLeft="true" maxlength="60">${project.fullName}</bs:trimWithTooltip></a>--%>
                    <span id="pool-${poolId}-project-${projectId}" class='project-name' style="padding-left: ${15 * poolProject.depth}px"
                    ><c:choose><c:when test="${poolProject.associated}"><bs:projectLink project="${project}"/></c:when
                    ><c:otherwise><bs:projectLink project="${project}" title="This project is actually not associated with this pool"/></c:otherwise></c:choose
                    ></span><c:if test="${project.archived}"><span class="archived_project">(archived)</span></c:if><c:if test="${associatedPoolsCount == 2}"><span class="another-pools-span"> also in <strong><bs:_otherPoolsList pools="${associatedPools}" poolId="${poolId}"/></strong> pool</span></c:if><c:if test="${associatedPoolsCount > 2}">
                          <span class="another-pools-span"> also in <bs:popup_static controlId="other-pools-popup-${crossId}" linkOpensPopup="true" popup_options="delay: 0, shift: {x: 0, y: 20}"
                          ><jsp:attribute name="content"><bs:_otherPoolsList pools="${associatedPools}" poolId="${poolId}"/></jsp:attribute
                          ><jsp:body>${associatedPoolsCount - 1} other pools</jsp:body
                          ></bs:popup_static></span></c:if>
                </td>
                <td class="remove-cell">
                  <c:if test="${not pool.agentPool.projectPool && (poolProject.canBeDissociated || removableChildrenCount>0)}">
                    <a href="#"
                       id="${crossId}"
                       onclick="{BS.AP.clickOnDropProjectCross({poolId: ${poolId}, projectId: '${projectId}', crossId: '${crossId}', showLastProjectWarning: ${pool.showLastProjectWarning}, poolName: '${poolNameForJS}', projectName: '${projectNameForJS}', associatedChildrenCount: ${removableChildrenCount}, projectsCount: ${pool.projectsCount}, associated: ${poolProject.associated}, canBeDissociated: ${poolProject.canBeDissociated}}); return false;}"
                       title="Dissociate '${projectName}' from pool ${poolName}"
                    >&#xd7;</a>
                    <forms:saving id="${crossId}-progress"/>
                  </c:if>
                </td>
              </tr>

            </c:forEach>
          </table>
        </c:if>
        <c:if test="${pool.hideArchivedProjects && pool.archivedProjectCount>0}">
          <div class="info">${pool.archivedProjectCount} archived project<bs:s val="${pool.archivedProjectCount}"/> <bs:are_is val="${pool.archivedProjectCount}"/> hidden from display. <a href="javascript:BS.AP.showArchivedProjects();">Show</a></div>
        </c:if>
        <c:if test="${pool.hiddenProjectCount != 0}">
          <div class="info">There <bs:are_is val="${pool.hiddenProjectCount}"/> ${pool.hiddenProjectCount}<c:if test="${not empty pool.allProjects}"> more</c:if> project<bs:s val="${pool.hiddenProjectCount}"/> you do not have permissions to see.</div>
        </c:if>

      </td>
    </tr>
  </table>

</div>

<c:if test="${includeDialogs}">
  <bs:agentPoolDialogs/>
</c:if>
