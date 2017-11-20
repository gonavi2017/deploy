<%@ attribute name="status" type="jetbrains.buildServer.clouds.InstanceStatus" rtexprvalue="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<c:set var="st">${status.name}</c:set><c:set var="icon"
  ><c:choose>
    <c:when test="${st eq 'SCHEDULED_TO_START'}">green</c:when>
    <c:when test="${st eq 'STARTING'}">green</c:when>
    <c:when test="${st eq 'RUNNING'}">green</c:when>
    <c:when test="${st eq 'RESTARTING'}">green</c:when>
    <c:when test="${st eq 'STOPPING'}">red</c:when>
    <c:when test="${st eq 'SCHEDULED_TO_STOP'}">red</c:when>
    <c:when test="${st eq 'STOPPED'}">red</c:when>
    <c:when test="${st eq 'ERROR'}">yellow</c:when>
    <c:when test="${st eq 'ERROR_CANNOT_STOP'}">yellow</c:when>
    <c:when test="${st eq 'UNKNOWN'}"></c:when>
    <c:otherwise></c:otherwise>
  </c:choose
></c:set
><i class="instanceName__icon ${icon}" <bs:tooltipAttrs text="${status.text}" deltaX="20" />></i>