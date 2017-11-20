<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="map" required="true" rtexprvalue="true" type="java.util.Map"
  %><%@ attribute name="quote" required="false" type="java.lang.Boolean"
  %><c:forEach items="${map}" var="item" varStatus="pos"
       ><c:out value="${item.key}"/>:[<bs:listToArray
               list="${item.value}"
               quote="${quote}"/>]<c:if test="${not pos.last}">, </c:if></c:forEach>