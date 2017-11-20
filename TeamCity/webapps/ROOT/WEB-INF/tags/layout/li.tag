<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ attribute name="title" required="false"
  %><%@ attribute name="onclick" required="false"
  %><li class="menuItem" title="${title}"<c:if test="${not empty onclick}"> onclick="${onclick}"</c:if>><jsp:doBody/></li>
