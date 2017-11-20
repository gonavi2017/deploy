<%@ include file="/include-internal.jsp" %>

<bs:refreshable containerId="importProjects" pageUrl="${pageUrl}">

  <c:choose>
    <c:when test="${selectArchiveStep != null}">
      <jsp:include page="selectArchiveStep.jsp"/>
    </c:when>
    <c:when test="${configureImportStep != null}">
      <jsp:include page="configureImportStep.jsp"/>
    </c:when>
    <c:when test="${importProgressStep != null}">
      <jsp:include page="importProgressStep.jsp"/>
    </c:when>
  </c:choose>

</bs:refreshable>

