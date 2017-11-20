<%@ include file="/include.jsp" %>

<div id="inputIdF" style="display: none;" data-btId="<c:out value="${param['buildTypeId']}"/>">
  <%@ include file="inputField.jspf" %>
</div>

<bs:linkScript>
  ${teamcityPluginResourcesPath}/search.js
</bs:linkScript>
