<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="branches" required="true" type="java.util.List"

%>[<c:forEach items="${branches}" var="branch" varStatus="pos"
  >"<bs:escapeForJs text="${branch}"/>"<c:if test="${not pos.last}">,</c:if
></c:forEach>]