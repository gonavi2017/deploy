<%@include file="/include-internal.jsp"%>
<jsp:useBean id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.HealthStatusItem" scope="request"/>
<c:set var="project" value="${healthStatusItem.additionalData['project']}"/>
<div>Could not decrypt some of the secure values (passwords, API tokens, etc) while loading settings of the project <admin:editProjectLinkFull project="${project}"/>:</div>
<ul>
<c:forEach items="${healthStatusItem.additionalData['brokenTokens']}" var="tinfo">
  <li><c:out value="${tinfo.value}"/></li>
</c:forEach>
</ul>
