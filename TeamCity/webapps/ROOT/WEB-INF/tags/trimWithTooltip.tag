<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="maxlength" required="false" type="java.lang.Integer"
%><%@ attribute name="trimCenter" required="false" type="java.lang.Boolean"
%><%@ attribute name="trimLeft" required="false" type="java.lang.Boolean"
%><c:set var="maxlength" value="${empty maxlength ? 50 : maxlength}"
  /><c:set var="text"><jsp:doBody/></c:set
  ><c:set var="escaped"><c:out value="${text}"/></c:set
  ><c:choose
    ><c:when test="${fn:length(text) > maxlength}"
    ><span onmouseover="BS.Tooltip.showMessageAtCursor(event, {shift:{x:5,y:10}}, '<bs:escapeForJs forHTMLAttribute="true" text="${escaped}"/>');"
           onmouseout="BS.Tooltip.hidePopup();"><c:choose
    ><c:when test="${trimCenter}"
      ><c:set var="length" value="${fn:length(text)}"
     /><c:set var="lim" value="${(maxlength - 1) / 2}"
     /><c:out value="${fn:substring(text, 0, lim)}"/>&hellip;<c:out value="${fn:substring(text, length - lim, length)}"/></c:when
    ><c:when test="${trimLeft}"
      ><c:set var="length" value="${fn:length(text)}"
     />&hellip;<c:out value="${fn:substring(text, length-maxlength, length)}"/></c:when
    ><c:otherwise
      ><c:out value="${fn:substring(text, 0, maxlength-1)}"/>&hellip;</c:otherwise
    ></c:choose></span></c:when
  ><c:otherwise>${escaped}</c:otherwise></c:choose>