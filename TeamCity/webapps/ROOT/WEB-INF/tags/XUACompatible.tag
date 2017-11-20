<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><%@ tag import="jetbrains.buildServer.web.util.WebUtil"
%><c:set var="isIE" value="<%= WebUtil.isIE(request) %>"></c:set><c:choose
><c:when test="${isIE and intprop:getBoolean('teamcity.ui.switchIE10To9')}"><meta http-equiv="X-UA-Compatible" content="IE=9"/></c:when
><c:otherwise><meta http-equiv="X-UA-Compatible" content="IE=edge"/></c:otherwise
></c:choose>
