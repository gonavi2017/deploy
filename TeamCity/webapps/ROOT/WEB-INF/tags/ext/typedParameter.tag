<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"

%><%@attribute name="context" required="true"  type="jetbrains.buildServer.controllers.parameters.ParameterRenderContext"
%><%@attribute name="js" required="false" type="java.lang.String"
%><jsp:useBean id="parameterConstants" class="jetbrains.buildServer.controllers.parameters.ParameterConstants" />

<c:catch var="ex">
  <bs:changeRequest key="${parameterConstants.renderContext}" value="${context}">
    <bs:changeRequest key="${parameterConstants.jsRegisterFunction}" value="${js}">
      <jsp:include page="${parameterConstants.controllerPath}"/>
    </bs:changeRequest>
  </bs:changeRequest>
</c:catch>
<c:if test="${ex != null}">
  <span class="errorMessage">There is an error in this parameter</span>
  <forms:textField expandable="true" style="width: 100%;" name="${context.id}" id="${context.id}" value="${context.parameter.value}" className="buildTypeParams"/>
</c:if>
