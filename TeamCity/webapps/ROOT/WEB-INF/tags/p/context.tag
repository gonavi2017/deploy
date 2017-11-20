<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@attribute name="key" required="true" type="java.lang.String" %>
<%@attribute name="value" required="true"  type="java.lang.Object" %>
<jsp:useBean id="parameterConstants" class="jetbrains.buildServer.controllers.parameters.ParameterConstants" />

<bs:changeRequest key="${parameterConstants.parametersFormControllerKey}" value="${key}">
<bs:changeRequest key="${parameterConstants.parametersFormControllerValue}" value="${value}">
  <jsp:include page="${parameterConstants.parametersFormControllerPath}" />
</bs:changeRequest>
</bs:changeRequest>
