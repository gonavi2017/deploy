<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="value" required="true" rtexprvalue="true"
  %><c:choose><c:when test="${value}">1</c:when><c:otherwise>0</c:otherwise></c:choose>