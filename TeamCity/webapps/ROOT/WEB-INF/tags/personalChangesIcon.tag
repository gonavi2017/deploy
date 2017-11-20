<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="myChanges" required="true" type="java.lang.Boolean"
    %><%@ attribute name="noTitle" required="false" type="java.lang.Boolean"
    %><c:set var="iconTitle"><c:if test="${not noTitle}">Remote Run</c:if></c:set><c:choose
  ><c:when test="${myChanges}"><span class="build-status-icon build-status-icon_my" title="${iconTitle}"></span></c:when
  ><c:otherwise><span class="build-status-icon build-status-icon_personal" title="${iconTitle}"></span></c:otherwise
  ></c:choose>