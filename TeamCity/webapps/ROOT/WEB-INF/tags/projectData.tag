<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@attribute name="type" required="true" %>
<%@attribute name="sourceFieldId" required="true" %>
<%@attribute name="targetFieldId" required="true" %>
<%@attribute name="popupTitle" required="true" %>
<%@attribute name="selectionMode" required="false" %> <!-- multiple|single -->
<c:if test="${empty selectionMode}">
  <c:set var="selectionMode" value="multiple"/>
</c:if>
<jsp:include page="/projectData.html?type=${type}&projectFilePath=&sourceFieldId=${sourceFieldId}&targetFieldId=${targetFieldId}&popupTitle=${popupTitle}&id=${param['id']}&selectionMode=${selectionMode}"/>