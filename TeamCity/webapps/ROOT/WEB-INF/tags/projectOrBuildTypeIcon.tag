<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
    %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
    %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
    %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
    %><%@attribute name="type" required="false" type="java.lang.String"
    %><%@attribute name="className" required="false" type="java.lang.String"
    %><%@attribute name="title" type="java.lang.String" required="false"
    %><c:if test="${empty type}"><c:set var="type" value="project"
    /></c:if><c:if test="${empty title}"><c:set var="title"
    ><c:choose><c:when test="${type == 'project'}"
    >Project</c:when><c:when test="${type == 'buildType'}"
    >Build configuration</c:when></c:choose
    ></c:set></c:if><span class="icon_before icon16 ${type}-icon<c:if test="${not empty className}"> ${className}</c:if>" title="${title}"><jsp:doBody/></span>
