<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="hideIcon" type="java.lang.Boolean" required="false"
  %><%@ attribute name="icon" required="true"
%><c:if test="${not hideIcon}">class="tc-icon_before icon16 tc-icon_${icon}"</c:if>