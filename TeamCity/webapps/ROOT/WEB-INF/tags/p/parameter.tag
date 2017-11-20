<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@attribute name="parameter" required="true"  type="jetbrains.buildServer.serverSide.Parameter" %>
<%@attribute name="preview" required="false" type="java.lang.Boolean" %>
<jsp:useBean id="parameterConstants" class="jetbrains.buildServer.controllers.parameters.ParameterConstants" />

<bs:changeRequest key="${parameterConstants.parametersFormPreview}" value="${not empty preview ? preview : false}">
<bs:changeRequest key="${parameterConstants.parameter}" value="${parameter}">
  <jsp:include page="${parameterConstants.parametersViewControllerPath}"/>
</bs:changeRequest>
</bs:changeRequest>
