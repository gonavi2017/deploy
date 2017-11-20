<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@attribute name="valueColumnTitle" required="true" type="java.lang.String" %>
<%@attribute name="parameters" required="true" type="java.util.List" %>
<%@attribute name="overriddenParameters" required="false" type="java.util.Map" %>
<c:if test="${fn:length(parameters) == 0}">None defined</c:if>
<c:if test="${fn:length(parameters) > 0}">
<table class="runnerFormTable" style="width:100%;">
<tr>
  <th class="paramName" style="width: 30%;">Name</th>
  <th class="paramValue"><c:out value="${valueColumnTitle}"/></th>
</tr>
<c:forEach items="${parameters}" var="prop">
<c:set var="readOnly" value="${prop.readOnly}"/>
<c:set var="val" value="${empty prop.value ? '<empty>' : prop.value}"/>
<c:set var="initialVal" value="${empty overriddenParameters[prop.nameWithPrefix] ? '<empty>' : overriddenParameters[prop.nameWithPrefix]}"/>
<c:set var="actualVal" value="${readOnly and not empty overriddenParameters[prop.nameWithPrefix] ? initialVal : val}"/>
<c:set var="valueClass" value="${empty prop.value ? 'emptyValue' : ''}"/>
<tr>
  <c:choose>
    <c:when test="${not empty overriddenParameters and overriddenParameters[prop.nameWithPrefix] != null}">
      <c:choose>
        <c:when test="${readOnly}">
          <c:set var="tooltipText"><i>The parameter is defined as read-only. User defined value '<bs:out value="${val}"/>' was ignored</i></c:set>
        </c:when>
        <c:otherwise>
          <c:set var="tooltipText"><i><c:choose
          ><c:when test="${overriddenParameters[prop.nameWithPrefix] == '<new parameter>'}">&lt;new parameter></c:when
          ><c:otherwise>changed, original value: <bs:out value="${overriddenParameters[prop.nameWithPrefix]}"/></c:otherwise
          ></c:choose></i></c:set>
        </c:otherwise>
      </c:choose>

      <td class="at_top"><strong><c:out value="${prop.nameWithPrefix}"/></strong></td>
      <td><strong class="${valueClass}"><bs:out value="${actualVal}" multilineOnly="true"/></strong>&nbsp;
        <c:if test="${readOnly}"><i class="icon-lock undefinedParam" <%--title='The parameter is defined as read-only in <c:out value="${parameter.inheritanceOrigin}"/>. The value "<bs:out value="${parameter.ownValue}" multilineOnly="true"/>" defined here is ignored.'--%>></i>&nbsp;</c:if>
        <bs:commentIcon text="${tooltipText}"/></td>
    </c:when>
    <c:otherwise>
      <td class="at_top"><c:out value="${prop.nameWithPrefix}"/></td>
      <td class="${valueClass}"><bs:out value="${actualVal}" multilineOnly="true"/></td>
    </c:otherwise>
  </c:choose>
</tr>
</c:forEach>
</table>
</c:if>

