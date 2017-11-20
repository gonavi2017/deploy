<%@ tag import="jetbrains.buildServer.controllers.ActionMessages" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>

<c:set var="actionMessages" value="<%=ActionMessages.getMessages(request)%>"/>

<c:forEach var="msg" items="${actionMessages.messages}">
<div class="successMessage ${msg.isWarning ? 'icon_before icon16 attentionComment' :''}" id="unprocessed_${msg.key}" style="display: none;">${msg.message}</div>
</c:forEach>
<!-- wait for page load to avoid displaying duplicates of messages, which are displayed inline somewhere in the page by bs:messages tag -->
<script type="text/javascript">
  $j(function() {
    BS._shownMessages = BS._shownMessages || {};
    <c:forEach var="msg" items="${actionMessages.messages}">
    if (!BS._shownMessages['message_${msg.key}']) {
      $('unprocessed_${msg.key}').show();
      BS._shownMessages['message_${msg.key}'] = "${msg.isWarning ? 'warn' : 'info'}";
    }
    </c:forEach>

    BS.MultilineProperties.updateVisible();
  });
</script>
