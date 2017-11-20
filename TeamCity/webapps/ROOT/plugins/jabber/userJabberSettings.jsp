<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@taglib prefix="forms" tagdir="/WEB-INF/tags/forms"

%><jsp:useBean id="showJabberNotConfiguredWarning" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="showJabberPausedWarning" type="java.lang.Boolean" scope="request"

/><c:choose
  ><c:when test="${showJabberPausedWarning}"
    ><forms:attentionComment additionalClasses="attentionCommentNotifier">Notification rules will not work because Jabber notifier is disabled.</forms:attentionComment
  ></c:when
  ><c:when test="${showJabberNotConfiguredWarning}"
    ><forms:attentionComment additionalClasses="attentionCommentNotifier">Notification rules will not work until you set up your Jabber account.</forms:attentionComment
></c:when
></c:choose>