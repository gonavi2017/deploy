<%@ tag import="jetbrains.buildServer.util.StringUtil"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><c:set var="_t" scope="request"><jsp:doBody/></c:set><%= StringUtil.collapseSpaces(request.getAttribute("_t").toString())%>