<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ext" tagdir="/WEB-INF/tags/ext"%>
<%@ attribute name="placeId" type="jetbrains.buildServer.web.openapi.PlaceId" required="true" %>
<%@ variable name-given="extension" scope="NESTED" variable-class="jetbrains.buildServer.web.openapi.CustomTab" %>
<ext:forEachExtension placeId="${placeId}"><jsp:doBody/></ext:forEachExtension>