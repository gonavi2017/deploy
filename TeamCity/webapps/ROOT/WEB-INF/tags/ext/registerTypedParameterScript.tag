<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="context" required="true" type="jetbrains.buildServer.controllers.parameters.ParameterRenderContext" %>
<jsp:useBean id="parameterConstants" class="jetbrains.buildServer.controllers.parameters.ParameterConstants" />

<c:set var="jsObject">${requestScope[parameterConstants.jsRegisterFunction]}</c:set>
<c:if test="${not empty jsObject}">
<script type="text/javascript">
  (function() { var fun = (${jsObject}); var obj = (<jsp:doBody/>); fun(obj); })();
</script>
</c:if>