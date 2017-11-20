<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="iconTitle" required="false"
  %><i class="icon icon16 tc-icon_help_small" <c:if test="${not empty iconTitle}"><bs:tooltipAttrs text="${iconTitle}" /></c:if>></i>