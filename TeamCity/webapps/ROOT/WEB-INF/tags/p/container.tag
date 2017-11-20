<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
      contextId must me JQuery and JavaScript valid identifier
--%>
<%@attribute name="contextId" required="true" type="java.lang.String" %>
<%--
      Global JS object that would represent created form, BS.TypedParameters is prototype
--%>
<%@attribute name="JSObject" required="true"  type="java.lang.String" %>
<%@attribute name="context" required="false"  fragment="true" %>
<%@attribute name="content" required="false"  fragment="true" %>
<jsp:useBean id="parameterConstants" class="jetbrains.buildServer.controllers.parameters.ParameterConstants" />

<script type="text/javascript">
  ${JSObject} = BS.TypedParameters.create();
  ${JSObject}.containerId = '<bs:forJs>${contextId}</bs:forJs>';
  ${JSObject}.submitUrl = '<bs:forJs><c:url value="${parameterConstants.parametersSubmitControllerPath}"/></bs:forJs>';
</script>

<bs:changeRequest key="${parameterConstants.parametersContainer}" value="${contextId}">
<bs:changeRequest key="${parameterConstants.parametersFormJs}" value="${JSObject}">
  <%-- cleanup parameters session to remove unused controls info --%>
  <jsp:include page="${parameterConstants.parametersFormControllerPath}">
    <jsp:param name="init" value="1"/>
  </jsp:include>

  <!-- create additional paremters for container -->
  <jsp:invoke fragment="context"/>

  <!-- render parameters context -->
  <jsp:invoke fragment="content"/>

</bs:changeRequest>
</bs:changeRequest>

