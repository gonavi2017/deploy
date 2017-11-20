<%@ tag import="jetbrains.buildServer.web.util.WebUtil"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="buildData" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SBuild"
  %><%@ attribute name="withLink" rtexprvalue="true" type="java.lang.Boolean"
  %><%@ attribute name="maxLength" rtexprvalue="true" type="java.lang.Integer"
  %><c:set var="text"><c:if test="${buildData.buildNumber != 'N/A'}">#</c:if><bs:trimWithTooltip maxlength="${not empty maxLength ? maxLength : 25}" trimCenter="true">${buildData.buildNumber}</bs:trimWithTooltip></c:set><c:choose
    ><c:when test="${withLink}"><bs:resultsLink build="${buildData}" noPopup="true">${text}</bs:resultsLink></c:when
    ><c:otherwise>${text}</c:otherwise></c:choose>