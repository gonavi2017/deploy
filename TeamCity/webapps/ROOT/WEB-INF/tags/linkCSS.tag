<%@ tag import="jetbrains.buildServer.web.util.PageResourceCompressor" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="dynamic" type="java.lang.Boolean" required="false"

%><c:set var="list"><jsp:doBody/></c:set
><% PageResourceCompressor compressor = (PageResourceCompressor)request.getAttribute("pageResourceCompressor");
  jspContext.setAttribute("list", compressor.link(request, (String)jspContext.getAttribute("list"), "css"));
%><c:if test="${not empty list and fn:length(list) gt 0}"
    ><c:choose
    ><c:when test="${not empty dynamic and dynamic}"
      ><script type="text/javascript">
<c:forEach var="item" items="${list}">  BS.LoadStyleSheetDynamically("<c:url value='${item}'/>");
</c:forEach></script></c:when
      ><c:otherwise
      ><style type="text/css">
<c:forEach items='${list}' var="item">  @import "<c:url value='${item}'/>";
</c:forEach></style></c:otherwise>
</c:choose></c:if>