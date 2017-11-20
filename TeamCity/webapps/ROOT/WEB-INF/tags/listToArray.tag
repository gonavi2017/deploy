<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="list" required="true" rtexprvalue="true" type="java.util.List"
  %><%@ attribute name="quote" required="false" type="java.lang.Boolean"
  %><c:forEach items="${list}" var="item" varStatus="pos"
    ><c:choose
      ><c:when test="${empty quote or quote}">'<bs:escapeForJs text="${item}"/>'</c:when
      ><c:otherwise><c:out value="${item}"/></c:otherwise
   ></c:choose
  ><c:if test="${not pos.last}">, </c:if></c:forEach>