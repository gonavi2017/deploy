<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ include file="/include-internal.jsp" %>

<c:forEach items="${refs}" var="bt" varStatus="pos">
  <c:set value="${bt.buildTypeId}" var="btId"/>
  <c:url value="/viewType.html?buildTypeId=${bt.externalId}" var="redirectTo"/>
  <c:set var="contextProjectInfo" value="${util:contextProjectInfo(bt.project, (!skipContextProject ? contextProject : null) )}"/>
  <tr class="${bt.project.archived ? 'archived' : 'inplaceFiltered'}" data-title="${contextProjectInfo.visiblePathAsText} :: ${bt.name}">
    <td class="header ${pos.last ? 'last' : ''}">
      <bs:buildTypeLinkFull buildType="${bt}" contextProject="${contextProject}"/>
      <c:if test="${bt.project.archived}">
        <span class="archived_project">archived</span>
      </c:if>
      <c:if test="${not empty bt.description}">
        <div class="buildType_description"><c:out value="${bt.description}"/></div>
      </c:if>
    </td>
    <td class="runButton ${pos.last ? 'last' : ''}">
      <c:set var="caption"><c:out value="${bt.runBuildActionName}"/></c:set
      ><span class="btn-group">
            <button class="btn btn_mini action" type="button" id="runButton:${btId}"
                    onclick="BS.RunBuild.runOnAgent(this, '${bt.externalId}',
                        { redirectTo: '${redirectTo}', dependOnPromotionIds: ${build.buildPromotion.id}<c:if test="${not empty modificationIdsMap[bt]}">, modificationId: ${modificationIdsMap[bt]}</c:if>${branchOpts}, init: true, stateKey: 'promote' }); return false;"
                    title="Click to run build on any agent">${caption}</button
            ><button class="btn btn_mini btn_append" type="button" id="run_${btId}"
                     onclick="BS.RunBuild.runCustomBuild('${bt.externalId}',
                         { redirectTo: '${redirectTo}', dependOnPromotionIds: ${build.buildPromotion.id}<c:if test="${not empty modificationIdsMap[bt]}">, modificationId: ${modificationIdsMap[bt]}</c:if>${branchOpts}, init: true, stateKey: 'promote' }); return false"
                     title="Run custom build">...</button>
          </span>
    </td>
  </tr>
</c:forEach>
