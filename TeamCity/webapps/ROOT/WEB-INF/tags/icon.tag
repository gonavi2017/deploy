<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="icon" fragment="false"
  %><%@ attribute name="alt" fragment="false"
  %><%@ attribute name="imgId" fragment="false"
  %><%@ attribute name="addClass" fragment="false"
  %><%@attribute name="noRetina" required="false" type="java.lang.Boolean"
  %><c:url var="iconUrl" value="/img/buildStates/${icon}"
  /><c:set var="noRetinaAttribute" value="${noRetina ?  'data-no-retina' : ''}" />
  <c:if test="${not empty imgId}" ><c:set var="idAttr" value="id='${imgId}'"/></c:if><img
  src="${serverPath}${iconUrl}" class="icon ${addClass}" <c:if test="${not empty alt}">alt="${alt}" title="${alt}" </c:if>${idAttr} ${noRetinaAttribute}/>