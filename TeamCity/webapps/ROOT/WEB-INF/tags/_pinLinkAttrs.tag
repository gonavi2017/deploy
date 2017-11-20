<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
 %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
 %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
 %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
 %><%@attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild"
 %><%@attribute name="unpinAndNotOnBuildPage" required="true" type="java.lang.Boolean"
 %><c:set var="buildId" value="${build.buildId}"
 /><c:set var="pinComment"><c:choose
  ><c:when test="${build.pinComment != null}"
  ><bs:pinCommentToolTipText build="${build}"
  /></c:when
  ><c:otherwise>Pinned builds won't be removed from the history upon automatic history cleanup</c:otherwise
  ></c:choose></c:set
  ><c:if test="${unpinAndNotOnBuildPage}"> style="display:none;" class="unpinLink" </c:if
  ><bs:tooltipAttrs text="${pinComment}" deltaX="-120"/>