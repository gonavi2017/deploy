<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
  taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  attribute name="name" required="true" type="java.lang.String"%><%@
  attribute name="style" required="false" type="java.lang.String"%><%@
  attribute name="emptyValue" required="false" type="java.lang.String"%><%@
  attribute name="showInPopup" required="false" type="java.lang.Boolean"%><%@
  attribute name="popupLinkText" required="false" type="java.lang.String"%><%@
  attribute name="popupTitle" required="false" type="java.lang.String"%><%@
  attribute name="syntax" required="false" type="java.lang.String"%><jsp:useBean
  id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"
  /><c:set var="value" value="${empty propertiesBean.properties[name] ? emptyValue : propertiesBean.properties[name]}"
  /><c:choose
  ><c:when test="${not showInPopup or empty propertiesBean.properties[name]}"><strong><c:out value="${value}"/></strong></c:when
  ><c:otherwise
  ><a href="#" onclick="BS.BuildTypeSettingsPopup.showMultilineValue(this, '<c:out value="${popupTitle}"/>', '<bs:escapeForJs text="${value}" forHTMLAttribute="true"/>'<c:if test="${not empty syntax}">, '${syntax}'</c:if> ); return false"><c:out value="${empty popupLinkText ? 'view' : popupLinkText}"/></a
  ></c:otherwise
  ></c:choose>