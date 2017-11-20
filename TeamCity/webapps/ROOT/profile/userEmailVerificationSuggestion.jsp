<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%>
<%--@elvariable id="currentUser" type="jetbrains.buildServer.users.SUser"--%>
<%--@elvariable id="profilePage" type="java.lang.Boolean"--%>
<c:url var="profileUrl" value="/profile.html#focus=email"/>

<c:choose>
  <c:when test="${empty currentUser.email}">
    <div class="icon_before icon16 attentionComment">
      <c:choose>
        <c:when test="${not profilePage}">
          You do not have <a href="${profileUrl}">an email address</a> specified.
        </c:when>
        <c:otherwise>
          You do not have an email address specified.
        </c:otherwise>
      </c:choose>
      ${intprop:getProperty('teamcity.user.email.suggestion.noEmail.text', 'You will not receive email notifications from the server.')}
    </div>
  </c:when>
  <c:when test="${empty currentUser.verifiedEmail}">
    <div class="icon_before icon16 attentionComment">
      <c:choose>
        <c:when test="${not profilePage}">
          Your <a href="${profileUrl}">email address</a> is not yet verified.
        </c:when>
        <c:otherwise>
          Your email address is not yet verified.
        </c:otherwise>
      </c:choose>
      ${intprop:getProperty('teamcity.user.email.suggestion.notVerifiedEmail.text', '')}
    </div>
  </c:when>
</c:choose>
