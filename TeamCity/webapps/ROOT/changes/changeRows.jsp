<%@ include file="../include-internal.jsp"%>
<%@ taglib prefix="ch" tagdir="/WEB-INF/tags/myChanges" %>

<jsp:useBean id="bean" scope="request" type="jetbrains.buildServer.controllers.changes.ChangesPageBean"/>

<c:set var="treeState" value="${ufn:getPropertyValue(currentUser, 'changesTreeState')}" scope="request"/>
<c:set var="showUsername" value="${param.changesOwnerId < 0 or currentUser.id < 0}"/>

<script type="text/javascript">
  <c:set var="updateGeneralData" value="${empty param['updateChanges']}"/>

  BS.ChangePreloadBlocks = [];
  <c:forEach var="jc" items="${bean.joinedChanges}"><c:set var="lastRowRecord" value="${jc.lastChangeStatus}"/><c:set var="firstRowRecord" value="${jc.firstChangeStatus}"/>
    BS.ChangePageData['jc_${jc.joinId}'] = {
      'updatable': ${jc.updatable},
      'lastRowRecord': <bs:_csJson changeStatus="${lastRowRecord}"/>,
      'records_with_same_builds':[]
    };
    BS.ChangePreloadBlocks.push('ct_node_<bs:_csId changeStatus="${firstRowRecord}"/>');

    <c:if test="${updateGeneralData and not empty jc.newDate}">
      BS.ChangePage.lastDay = ${jc.newDate.time};
    </c:if>

    <c:forEach var="cs" items="${jc.changeStatuses}">
      <c:set var="nodeId">ct_node_<bs:_csId changeStatus="${cs}"/></c:set>
      BS.ChangePageData['jc_${jc.joinId}'].records_with_same_builds.push(<bs:_csJson changeStatus="${cs}"/>);
      BS.changeTree.addNodeIfNotExists(
          new BS.ChangeNode('${nodeId}', <bs:_csJson changeStatus="${cs}"/>, <bs:_csJson changeStatus="${firstRowRecord}"/>,
          ${fn:contains(treeState, nodeId)}));</c:forEach>
  </c:forEach>

  <c:if test="${updateGeneralData}">
    // Update lastChanges record only if this is not "updateChanges" request
    BS.ChangePage.haveMoreChanges = ${bean.hasMoreChanges};
    <c:if test="${not empty bean.joinedChanges}">
      <c:set var="lastChangeStatus" value="${bean.joinedChanges[fn:length(bean.joinedChanges) - 1].lastChangeStatus}"/>
      BS.ChangePage.lastRecord = <bs:_csJson changeStatus="${lastChangeStatus}"/>;
    </c:if>
  </c:if>

  <c:if test="${not empty bean.joinedChanges}">
    <c:set var="firstChangeStatus" value="${bean.joinedChanges[0].firstChangeStatus}"/>
    if (!BS.ChangePage.firstRecord) {
      BS.ChangePage.firstRecord = <bs:_csJson changeStatus="${firstChangeStatus}"/>;
    }
  </c:if>

  <%@ include file="updateFilter.jspf"%>
  <c:forEach var="prj_data" items="${changesProjectsTabs}">
  BS.ChangePageFilter.addProject({
    id: '${prj_data.key.projectId}',
    externalId: '${prj_data.key.externalId}',
    name: '<bs:escapeForJs forHTMLAttribute="false" text="${prj_data.key.extendedFullName}"/>',
    usageCount: ${prj_data.value}
  });
  </c:forEach>
  BS.ChangePageFilter.updateFilterView();

</script>

<c:forEach var="jc" items="${bean.joinedChanges}" varStatus="status">
  <jsp:useBean id="jc" type="jetbrains.buildServer.controllers.changes.ChangesWithSameCarpet"/>
  <div id="jc_${jc.joinId}" class="joinedChange" data-personal="${jc.firstChangeStatus.change.personal}">

    <table class="joinedChangeTable" id="jct_<bs:_csId changeStatus="${jc.firstChangeStatus}"/>">

      <c:forEach var="changeStatus" items="${jc.changeStatuses}">
        <%@ include file="changeRow.jspf" %>
      </c:forEach>

    </table>
  </div>
</c:forEach>
