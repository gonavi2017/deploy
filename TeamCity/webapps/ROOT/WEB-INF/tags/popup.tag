<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ attribute name="type" type="java.lang.String" required="true"
%><%@ attribute name="id" type="java.lang.String" required="true"
%><%@ attribute name="additionalClasses" type="java.lang.String" required="false"
%><%@ attribute name="showOptions" type="java.lang.String" required="false"
%><%@ attribute name="topRightButton" required="false"
%><c:set var="className">pc ${not empty additionalClasses ? additionalClasses : ''}${not empty topRightButton ? ' pc_topRightButton' : ''}</c:set
><c:set var="jsOptions"><c:if test="${not empty showOptions}">, {show:[${showOptions}]}</c:if></c:set
><span class="${className}" id="${id}" onmouseover="if(!window.event) window.event = event;BS.bindPopup(this, '${type}'${jsOptions});"
><span class="pc__label"><jsp:doBody/></span><span class="pc__toggle-wrapper">&nbsp;<span class="icon icon16 toggle"></span></span></span>
