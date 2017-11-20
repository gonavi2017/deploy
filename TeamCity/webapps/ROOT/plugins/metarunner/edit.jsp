<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="runner" scope="request" type="jetbrains.buildServer.runners.metaRunner.runner.MetaRunnerSpecBean"/>

<c:forEach var="p" items="${runner.parameterSpecs}">
  <p:parameter parameter="${p}"/>
</c:forEach>

<tr>
  <th class="noBorder"></th>
  <td class="noBorder">
    <span id="error_meta_runner_runners_not_found" class="error"></span>
    <span id="error_meta_runner_step_errors" class="error"></span>
  </td>
</tr>
