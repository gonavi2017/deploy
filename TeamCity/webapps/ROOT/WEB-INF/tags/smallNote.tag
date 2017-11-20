<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><c:set var="content"><jsp:doBody/></c:set
  ><c:if test="${fn:length(content) > 0}"><div class="grayNote">${content}</div></c:if>