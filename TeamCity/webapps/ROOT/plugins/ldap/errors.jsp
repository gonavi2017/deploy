<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="status" scope="request" type="jetbrains.buildServer.serverSide.ldap.LdapStatusBean"/>

<div class="icon_before icon16 attentionComment">
  <c:forEach var="message" items="${status.lastErrors}" varStatus="pos">
    <div><c:out value="${message}"/></div>
    <c:if test="${not pos.last}"><br/></c:if>
  </c:forEach>
  <c:if test="${status.errorsClipped}">
    <div>
      <br/>
      And ${status.lastErrorsNumber - status.defaultErrorsNumber} more.
      See the <b>teamcity-ldap.log</b> for details.</div>
  </c:if>
</div>
