<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ attribute name="count" fragment="false" required="true"
%><c:if test="${0 == count}">no new</c:if><c:if test="${0 != count}"><strong>${count} new</strong></c:if>