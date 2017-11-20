<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="id" type="java.lang.String" required="false" %><%@
    attribute name="style" type="java.lang.String" required="false" %><%@
    attribute name="properties" type="java.util.List" required="true"

%><div class="mono" <c:if test="${not empty id}">id="${id}"</c:if> style="font-size: 12px; ${style}">
  <c:forEach items="${properties}" var="property">
    <%--@elvariable id="property" type="jetbrains.buildServer.controllers.admin.ServerConfigGeneralController.PropertyEntry"--%>
    <div <c:if test="${property.overwritten}">class="crossed" title="This property is overwritten"</c:if>>
      <span class="key">${property.key}</span>=<span class="value"><bs:trimWithTooltip maxlength="150">${property.value}</bs:trimWithTooltip></span>
    </div>
  </c:forEach>
</div>