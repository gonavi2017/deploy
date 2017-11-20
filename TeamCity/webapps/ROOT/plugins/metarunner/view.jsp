<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="runner" scope="request" type="jetbrains.buildServer.runners.metaRunner.runner.MetaRunnerSpecBean"/>

<c:forEach var="p" items="${runner.parameterSpecs}">
  <p:parameter parameter="${p}" preview="${true}"/>
</c:forEach>
