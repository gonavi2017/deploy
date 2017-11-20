<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="maxlength" required="false" type="java.lang.Integer"
%><c:set var="maxlength" value="${empty maxlength ? 50 : maxlength}"
  /><c:set var="text"><jsp:doBody/><c:out value="${text}"/></c:set><c:set var="text" value="${fn:trim(text)}"/><c:choose
    ><c:when test="${fn:length(text) > maxlength + 1}"><c:out value="${fn:substring(text, 0, maxlength)}"/>&hellip;</c:when
  ><c:otherwise><c:out value="${text}"/></c:otherwise></c:choose>