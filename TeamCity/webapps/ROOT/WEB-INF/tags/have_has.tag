<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="val" fragment="false"
  %><c:if test="${val > 1 or val == 0}">have</c:if><c:if test="${val == 1}">has</c:if>