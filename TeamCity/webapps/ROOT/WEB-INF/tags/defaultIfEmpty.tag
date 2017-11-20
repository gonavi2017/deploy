<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ attribute name="defaultValue" fragment="false" required="false"%>
<c:if test="${defaultValue == null}"><c:set var="defaultValue" value="<empty>"/></c:if>
<c:set var="bodyValue"><jsp:doBody/></c:set>
<c:choose><c:when test="${!empty bodyValue}">${bodyValue}</c:when><c:otherwise><c:out value="${defaultValue}"/></c:otherwise></c:choose>