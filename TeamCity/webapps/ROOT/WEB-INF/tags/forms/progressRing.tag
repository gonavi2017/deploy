<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><%@
    attribute name="id" required="false" %><%@
    attribute name="style" required="false" %><%@
    attribute name="className" required="false" %><%@
    attribute name="progressTitle" required="false"

%><c:set var="id" value="${empty id ? 'inProgress' : id}"
/><c:set var="title" value="${empty progressTitle ? 'Please wait...' : progressTitle}"
/><c:set var="className">
  <c:choose>
    <c:when test="${empty className}"><c:out value="progressRing progressRingDefault"/></c:when>
    <c:otherwise><c:out value="progressRing ${className}"/></c:otherwise>
  </c:choose>
  </c:set
><c:choose
><c:when test="${intprop:getBoolean('teamcity.ui.ringLoader')}"
  ><div id="${id}" style="${style}"class="ring-loader-inline ${className}" title="${title}"><!--[if (gt IE 9)|(!IE)]> -->
  <div class="ring-loader-inline__ball"></div>
  <div class="ring-loader-inline__ball ring-loader-inline__ball_second"></div>
  <div class="ring-loader-inline__ball ring-loader-inline__ball_third"></div><!-- <![endif]-->
</div></c:when
  ><c:otherwise><i id="${id}" style="${style}" class="icon-refresh icon-spin ${className}" title="${title}"></i></c:otherwise></c:choose>