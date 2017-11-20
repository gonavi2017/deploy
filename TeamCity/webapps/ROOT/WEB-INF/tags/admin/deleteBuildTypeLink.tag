<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="buildTypeId" required="true" %>
<c:set var="cameFromUrl" value="${pageUrl}"/>
<a href="#" title="Delete build configuration" onclick="BS.AdminActions.deleteBuildType('${buildTypeId}', false, '${cameFromUrl}'); return false"><jsp:doBody/></a>
