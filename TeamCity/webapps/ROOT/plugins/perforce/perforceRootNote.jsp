<%@include file="/include.jsp"%>

<c:choose>
  <c:when test="${not empty label_revision}">
    The highest changelist number in the build is ${label_revision}
  </c:when>
  <c:otherwise>
    This build uses fixed VCS root revision
  </c:otherwise>
</c:choose>
