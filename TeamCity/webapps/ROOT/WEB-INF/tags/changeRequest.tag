<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="key" type="java.lang.String" required="true"%>
<%@ attribute name="value" type="java.lang.Object" required="true"%>

<%
  final Object ____old = request.getAttribute(key);
  if (value != null) {
    request.setAttribute(key, value);
  } else {
    request.removeAttribute(key);
  }
%>
<jsp:doBody/>
<%
  if (____old == null) {
    if (value != null) {
      request.removeAttribute(key);
    }
  } else {
    request.setAttribute(key, ____old);
  }
%>
