<%@ include file="include-internal.jsp" %>
<jsp:useBean id="buildChain" type="jetbrains.buildServer.serverSide.dependency.BuildChain" scope="request"/>
<jsp:useBean id="changeLogBean" type="jetbrains.buildServer.controllers.buildType.tabs.ChangeLogBean" scope="request"/>

<c:choose>
  <c:when test="${buildChain.changesCollected}">
    <c:if test="${changeLogBean.pager.totalRecords == 0}">
      <div class="smallNote">There are no changes found</div>
    </c:if>
    <c:if test="${changeLogBean.pager.totalRecords gt 0}">
      <bs:changesList changeLog="${changeLogBean}"
                      url="viewChainChanges.html?chainId=${buildChain.id}"
                      filterUpdateUrl="viewChainChanges.html?chainId=${buildChain.id}"
                      hideBuildSelectors="true"
                      hideShowBuilds="true"
                      enableCollapsibleChanges="true"/>
      <script type="text/javascript">
        $j('#changeLogFilter').append('<input type="hidden" name="page" value="${changeLogBean.filter.page}"/>');

        // install callback to patch page URLs
        BS.ChangeLog.refreshCallback = function() {
          $j('#changeLog span.back a, #changeLog span.forward a, #changeLog a.page').each(function() {
            $j(this)[0].href = 'javascript:void(0)';
            $j(this).on("click", function() {
              $j('#changeLogFilter')[0].page.value = $j(this).data('page-num');
              BS.ChangeLog.submitFilter();
            });
          });
        };

        BS.ChangeLog.refreshCallback();
      </script>
    </c:if>
  </c:when>
  <c:otherwise>
    <div class="smallNote">Changes have not been collected yet</div>
  </c:otherwise>
</c:choose>
