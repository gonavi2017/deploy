<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@
    attribute name="requirementType" type="jetbrains.buildServer.requirements.RequirementType" required="true" %><%@
    attribute name="parameterValue" type="java.lang.String" required="true" %><%@
    attribute name="doNotHighlight" type="java.lang.Boolean" required="false"
%><c:out value="${requirementType.displayName}"/>
<c:choose>
  <c:when test="${empty parameterValue && requirementType.parameterCanBeEmpty && requirementType.parameterRequired}"><strong>''</strong></c:when>
  <c:otherwise><span class="mono requirement-value <c:if test="${empty doNotHighlight or not doNotHighlight}">red-text</c:if>"><c:out value="${parameterValue}"/></span></c:otherwise>
</c:choose>
