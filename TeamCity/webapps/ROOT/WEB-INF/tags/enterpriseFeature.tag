<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<c:if test="${serverSummary.enterpriseMode}">
  <jsp:doBody/>
</c:if>