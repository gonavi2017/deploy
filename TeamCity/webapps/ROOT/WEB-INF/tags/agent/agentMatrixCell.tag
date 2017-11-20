<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ attribute name="value" required="true" type="jetbrains.buildServer.controllers.agent.statistics.table.AgentConfigurationCell" %>
<%@ attribute name="collapsed" required="true" type="java.lang.Boolean" %>
<%@ attribute name="row" required="true" type="jetbrains.buildServer.controllers.agent.statistics.table.rows.TableRow" %>
<%@ attribute name="clazz" type="java.lang.String" %>

<c:set var="dataParamsCommon"><bs:forJs>${row.row.id}</bs:forJs>:<bs:forJs>${value.fullColId}</bs:forJs></c:set>

<td <c:if test="${collapsed}">style="display: none;"</c:if>
    <c:choose>
      <c:when test="${value.hasBuilds}">
        class="astS ${clazz}"
        data-params="${dataParamsCommon}:<bs:forJs>${value.value.buildsCount}</bs:forJs>"
      </c:when>
      <c:when test="${value.compatible}">
        class="astC ${clazz}"
        data-params="${dataParamsCommon}"
      </c:when>
      <c:otherwise>
        class="astO ${clazz}"
        data-params="${dataParamsCommon}"
      </c:otherwise>
    </c:choose>
    >
  <c:choose>
    <c:when test="${not empty value.value}"><bs:printTime time="${value.value.loadTime / 1000}"/></c:when>
    <c:otherwise>&nbsp;</c:otherwise>
  </c:choose>
</td>
