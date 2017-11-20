<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<jsp:useBean id="feed_noAuth" type="java.lang.Boolean" scope="request"/>
<jsp:useBean id="feed_guestAuth" type="java.lang.Boolean" scope="request"/>
<!-- TODO: pset correct feed type -->
<c:if test="${feed_noAuth or feed_guestAuth}">
  <link rel="alternate" type="application/atom+xml" title="Feed of ${feedDescription}" href="${util:urlEscape(feedUrl)}"/>
</c:if>
