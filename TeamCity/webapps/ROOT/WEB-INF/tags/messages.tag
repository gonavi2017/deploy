<%@
    tag import="jetbrains.buildServer.controllers.ActionMessages" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@

    attribute name="isWarning" required="false" type="java.lang.String" %><%@
    attribute name="key" required="true" type="java.lang.String" %><%@
    attribute name="style" required="false" type="java.lang.String" %><%@
    attribute name="permanent" required="false" type="java.lang.Boolean" %><%@
    attribute name="className" required="false" type="java.lang.String"

%><c:set var="actualClassName" value="${empty className ? 'successMessage' : className}"
/><c:if test="${empty isWarning}"><c:set var="isWarning" value="false" /></c:if

><%
  ActionMessages messages1 = ActionMessages.getMessages(request);
  String id = "message_" + key;
%><%
  if (messages1 != null) {
    boolean hasMessage = messages1.hasMessage(key);

%><a name="<%=key%>"></a>
<div class="${actualClassName}" style='display: <%=hasMessage ? "block" : "none"%>; ${style}' id="<%=id%>">
<%
    if (hasMessage) {
      // ActionMessage class is responsible for escaping.
      // It should be absolutely safe to simply output them here.
      out.write(messages1.getMessage(key));
    }
%></div>
<%
    if (hasMessage) {
%><c:if test="${not permanent}"><script type="text/javascript">
  BS._shownMessages = BS._shownMessages || {};

  BS._shownMessages['<%=id%>'] = "${isWarning ? 'warn' : 'info'}";
</script></c:if>
<%
    }
  }
%>