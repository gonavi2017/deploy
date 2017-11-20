<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="shouldBePositive" type="java.lang.Integer" required="true" %>
<%@ attribute name="disabled" fragment="true" %>
<c:choose>
  <c:when test="${serverSummary.enterpriseMode or shouldBePositive > 0}">
    <jsp:doBody/>
  </c:when>
  <c:otherwise>
    <jsp:invoke fragment="disabled"/>
  </c:otherwise>
</c:choose>