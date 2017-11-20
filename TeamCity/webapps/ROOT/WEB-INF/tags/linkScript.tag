<%@ tag import="jetbrains.buildServer.web.util.PageResourceCompressor" %>
<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><c:set var="list"><jsp:doBody/></c:set
><% PageResourceCompressor compressor = (PageResourceCompressor)request.getAttribute("pageResourceCompressor");
  jspContext.setAttribute("list", compressor.link(request, (String)jspContext.getAttribute("list"), "js"));
%><c:forEach items='${list}' var="item"><script type="text/javascript" src="<c:url value='${item}'/>"></script>
</c:forEach>