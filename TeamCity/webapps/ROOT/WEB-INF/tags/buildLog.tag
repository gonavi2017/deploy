<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="ufn" uri="/WEB-INF/functions/user" %>

<%@ attribute name="buildPromotion" fragment="false" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"%>
<%@ attribute name="messagesIterator" required="false" type="java.util.Iterator"%>
<%@ attribute name="messagesList" required="false" type="java.util.List"%>
<%@ attribute name="renderRunningTime" required="false" type="java.lang.Boolean"%>
<%@ attribute name="mergeTestOutput" required="false" type="java.lang.Boolean"%>

<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser"  scope="request"
/><c:set var="consoleMod" value="${ufn:booleanPropertyValue(currentUser, 'buildLogConsoleStyle') ? 'console_mod': ''}"/>
<div class="log ${consoleMod}" id="buildLog">
  <bs:changeRequest key="buildPromotion" value="${buildPromotion}">
    <bs:changeRequest key="messagesIterator" value="${messagesIterator}">
      <bs:changeRequest key="messagesList" value="${messagesList}">
        <jsp:include page="/buildLog/buildLogPrinter.html">
          <jsp:param name="renderRunningTime" value="${renderRunningTime}"/>
          <jsp:param name="mergeTestOutput" value="${mergeTestOutput}"/>
        </jsp:include>
      </bs:changeRequest>
    </bs:changeRequest>
  </bs:changeRequest>
</div>
