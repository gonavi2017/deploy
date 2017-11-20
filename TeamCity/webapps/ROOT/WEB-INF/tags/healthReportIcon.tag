<%@ tag import="jetbrains.buildServer.serverSide.healthStatus.ItemSeverity"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@attribute name="items" required="true" type="java.util.Collection"
%><%@attribute name="currentEntity" required="true" type="jetbrains.buildServer.serverSide.SPersistentEntity"
%><%@attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"
%><c:set var="errNum" value="0"/>
<c:set var="warnsNum" value="0"/>
<c:set var="infosNum" value="0"/>
<c:set var="maxSeverity" value="<%=ItemSeverity.INFO%>"/>
<c:forEach items="${items}" var="item">
  <c:if test="${item.severity.error}"><c:set var="errNum" value="${errNum + 1}"/></c:if>
  <c:if test="${item.severity.warning}"><c:set var="warnsNum" value="${warnsNum + 1}"/></c:if>
  <c:if test="${item.severity.info}"><c:set var="infosNum" value="${infosNum + 1}"/></c:if>
</c:forEach>
<c:choose>
  <c:when test="${errNum gt 0}"><c:set var="maxSeverity" value="<%=ItemSeverity.ERROR%>"/></c:when>
  <c:when test="${warnsNum gt 0}"><c:set var="maxSeverity" value="<%=ItemSeverity.WARN%>"/></c:when>
  <c:when test="${infosNum gt 0}"><c:set var="maxSeverity" value="<%=ItemSeverity.INFO%>"/></c:when>
</c:choose>
<c:set var="pageUrl" scope="request" value="${param.originUrl}"/>
<bs:healthReportsPopup controlId="hi_${currentEntity.externalId}" items="${items}" project="${project}" title="Server Health Items">
  <div class="healthItemIndicator ${errNum gt 0 ? 'hasErrors' : ''}" title="View server health items">
    <bs:itemSeverity severity="${maxSeverity}"/>
    <c:if test="${errNum gt 0}"><span class="error">${errNum} error<bs:s val="${errNum}"/></span></c:if>
    <c:if test="${warnsNum gt 0}"><span class="warning">${warnsNum} warning<bs:s val="${warnsNum}"/></span></c:if>
    <c:if test="${infosNum gt 0}"><span class="info">${infosNum} info item<bs:s val="${infosNum}"/></span></c:if>
  </div>
</bs:healthReportsPopup>
