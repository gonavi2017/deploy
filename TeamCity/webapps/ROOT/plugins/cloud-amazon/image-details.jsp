<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<jsp:useBean id="data" type="jetbrains.buildServer.clouds.amazon.data.ImageInfo" scope="request"/>

<dl>
  <c:if test="${not empty data.architecture}">
    <dt>Architecture:</dt>
    <dd><c:out value="${data.architecture}"/></dd>
  </c:if>

  <c:if test="${not empty data.kernelId}">
    <dt>Kernel ID:</dt>
    <dd><c:out value="${data.kernelId}"/></dd>
  </c:if>

  <c:if test="${not empty data.ramdiskId}">
    <dt>RAM Disk ID:</dt>
    <dd><c:out value="${data.ramdiskId}"/></dd>
  </c:if>

  <c:if test="${not empty data.productCodes}">
    <dt>Product Codes:</dt>
    <dd>
      <c:forEach var="code" items="${data.productCodes}" varStatus="x">
        <c:if test="${not x.first}">,</c:if>
        <c:out value="${code}"/>
      </c:forEach>
    </dd>
  </c:if>

  <c:if test="${not empty data.warnings}">
    <c:forEach var="code" items="${data.warnings}">
      <dt><span class="icon icon16 yellowTriangle agentVersion"></span><c:out value="${code}"/></dt>
    </c:forEach>
  </c:if>
</dl>
