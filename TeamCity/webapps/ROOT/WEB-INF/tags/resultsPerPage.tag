<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="pager" required="true" type="jetbrains.buildServer.util.Pager" %>
<%@ attribute name="onchange" required="true" type="java.lang.String" %>
<%@ attribute name="minItemsNumber" required="false" type="java.lang.Integer" %>

<label for="recordsPerPage">Results per page:</label>&nbsp;
<select name="recordsPerPage" id="recordsPerPage" style="width: 5em;" onchange="${onchange}">
  <c:if test="${minItemsNumber != null and minItemsNumber != 20}">
    <forms:option value="${minItemsNumber}" selected="${pager.recordsPerPage == minItemsNumber}">${minItemsNumber}</forms:option>
  </c:if>
  <forms:option value="20" selected="${pager.recordsPerPage == 20}">20</forms:option>
  <forms:option value="50" selected="${pager.recordsPerPage == 50}">50</forms:option>
  <forms:option value="100" selected="${pager.recordsPerPage == 100}">100</forms:option>
  <forms:option value="500" selected="${pager.recordsPerPage == 500}">500</forms:option>
</select>