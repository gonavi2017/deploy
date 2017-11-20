<%@ include file="/include.jsp" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/plugins/changeViewers/style.css'/>" />

<%--@elvariable id="changeViewerUrl" type="java.lang.String"--%>
<%--@elvariable id="showType" type="java.lang.String"--%>

<c:if test="${not empty changeViewerUrl}">
  <c:set var="title" value="Open in external change viewer"/>
  <c:set var="icon"><span class="changeViewers_link"></span></c:set>
  <c:choose>
    <c:when test="${showType == 'compact'}">
      <a href="${changeViewerUrl}" title="${title}">
        ${icon}
      </a>
    </c:when>
    <c:otherwise>
      <dt>
        ${icon}
        <a href="${changeViewerUrl}">${title}</a>
      </dt>
    </c:otherwise>
  </c:choose>
</c:if>
