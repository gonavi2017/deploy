<%@include file="/include.jsp"%>

<%--@elvariable id="perforceJobs" type="java.util.List<PerforceJob>"--%>
<c:if test="${not empty perforceJobs}">

  <bs:executeOnce id="perforceJobsStyles">
    <script>
      BS.LoadStyleSheetDynamically("<c:url value='/plugins/perforce/perforceJobs.css'/>")
    </script>
  </bs:executeOnce>


  <c:set var="pjControl">
    <bs:popup_static controlId="jobs${modification.id}" controlClass="${showType == 'compact' ? 'jobsToggler' : ''}" linkOpensPopup="true">
          <jsp:attribute name="content">
            <div class="perforceJobs">
                <c:forEach items="${perforceJobs}" var="job">
                  <div class="perforceJobLine"><bs:out value="${job.summaryLine}" resolverContext="${resolverContext}"/></div>
                  <div class="perforceJobDesc"><bs:out value="${job.description}" resolverContext="${resolverContext}"/></div>
                </c:forEach>
            </div>
          </jsp:attribute>
      <jsp:body>
        <i class="icon-wrench icon-dark jobIcon" title="Perforce Job info"></i><span
          class="perforceJobLabel">${fn:length(perforceJobs)} perforce job<bs:s val="${fn:length(perforceJobs)}"/></span></jsp:body>
    </bs:popup_static>
  </c:set>


  <c:choose>
    <c:when test="${showType == 'compact'}">
         ${pjControl}
    </c:when>
    <c:otherwise>
      <dt>
          ${pjControl}
      </dt>
    </c:otherwise>
  </c:choose>


</c:if>
