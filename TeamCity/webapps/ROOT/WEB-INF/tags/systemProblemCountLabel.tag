<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ attribute name="problemsCount" required="true" type="java.lang.Integer" %>
<%@ attribute name="onclick" required="false" type="java.lang.String" %>

<c:if test="${problemsCount != null && problemsCount > 0}">
  <a class="systemProblemsBar" style="cursor: pointer" title="Show errors" <c:if test="${not empty onclick}"> onclick="${onclick}"</c:if>>${problemsCount} error<bs:s val="${problemsCount}"/></a>
</c:if>
