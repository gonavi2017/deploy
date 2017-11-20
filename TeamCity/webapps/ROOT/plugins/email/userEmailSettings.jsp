<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="forms" tagdir="/WEB-INF/tags/forms"

%><jsp:useBean id="showEmailNotConfiguredWarning" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="showEmailPausedWarning" type="java.lang.Boolean" scope="request"

/><c:choose
  ><c:when test="${showEmailPausedWarning}"
    ><forms:attentionComment additionalClasses="attentionCommentNotifier">Notification rules will not work because e-mail notifier is disabled.</forms:attentionComment>
  </c:when
  ><c:when test="${showEmailNotConfiguredWarning}"
    ><forms:attentionComment additionalClasses="attentionCommentNotifier">Notification rules will not work until you specify your <a href="#" onclick="if ($('input_teamcityEmail')) { $('input_teamcityEmail').focus(); $('input_teamcityEmail').highlight(); } return false">email address</a>.</forms:attentionComment
  ></c:when
></c:choose>