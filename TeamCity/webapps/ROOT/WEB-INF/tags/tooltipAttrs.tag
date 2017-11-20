<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="text" required="false"
  %><%@attribute name="withOnClick" required="false" type="java.lang.Boolean"
  %><%@ attribute name="useHtmlTitle" type="java.lang.Boolean"
  %><%@ attribute name="deltaX" type="java.lang.Integer" required="false"
  %><%@ attribute name="deltaY" type="java.lang.Integer" required="false"
  %><%@ attribute name="hideDelay" type="java.lang.Integer" required="false"
  %><%@ attribute name="width" type="java.lang.String" required="false"
  %><%@ attribute name="className" type="java.lang.String" required="false"
  %><%@ attribute name="containerId" type="java.lang.String" required="false"
  %><%@ attribute name="evalScripts" type="java.lang.Boolean" required="false"
  %><c:set var="evalScripts" value="${evalScripts == true}"
  /><c:set var="dx"><c:choose><c:when test="${empty deltaX}">10</c:when><c:otherwise>${deltaX}</c:otherwise></c:choose></c:set
  ><c:set var="dy"><c:choose><c:when test="${empty deltaY}">18</c:when><c:otherwise>${deltaY}</c:otherwise></c:choose></c:set
  ><c:choose
  ><c:when test="${useHtmlTitle}"
  >title='<c:out value="${text}"/>' alt='<c:out value="${text}"/>'</c:when
  ><c:when test="${not empty text or not empty containerId}"
  ><c:set var="showCommand"
  ><c:choose
  ><c:when test="${not empty containerId}">BS.Tooltip.showMessageFromContainer(this, {shift:{x:${dx}, y:${dy}}, hideDelay: ${empty hideDelay ? 300 : hideDelay}}, "${containerId}", ${evalScripts});</c:when
  ><c:otherwise>BS.Tooltip.showMessage(this, {shift:{x:${dx}, y:${dy}}<c:if test="${not empty width}">, width:"${width}"</c:if><c:if test="${not empty className}">, className:"${className}"</c:if>, hideDelay: ${empty hideDelay ? 300 : hideDelay}}, "<bs:escapeForJs text="${text}" removeLineFeeds="true" forHTMLAttribute="true"/>", ${evalScripts});</c:otherwise
  ></c:choose
  ></c:set>onmouseover='${showCommand}' onmouseout='BS.Tooltip.hidePopup()' <c:if test="${withOnClick}">onclick='${showCommand}'</c:if></c:when></c:choose>