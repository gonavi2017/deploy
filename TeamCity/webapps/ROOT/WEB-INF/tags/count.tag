<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="val" required="true" fragment="false"
  %><%@ attribute name="none" required="false" fragment="false"
  %><c:if test="${empty none}"><c:set var="none" value="0"/></c:if><c:if 
  test="${val > 0}">${val}</c:if><c:if test="${val == 0}">${none}</c:if>