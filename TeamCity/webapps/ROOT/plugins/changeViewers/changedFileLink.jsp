<%@ include file="/include.jsp" %>
<link rel="stylesheet" type="text/css" href="<c:url value='/plugins/changeViewers/style.css'/>" />

<%--@elvariable id="fileDiffUrl" type="java.lang.String"--%>

<c:if test="${not empty fileDiffUrl}">
  <a href="${fileDiffUrl}" title="Open in external file viewer" class="noUnderline"><span class="changeViewers_link"></span></a>
</c:if>
