<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="text"><bs:out value="${buildType.responsibilityInfo.comment}"/></c:set><bs:commentIcon text="${text}" style="margin: 0 0 5px"/>