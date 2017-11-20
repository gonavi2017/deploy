<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild"
  %><c:set var="buildId" value="${build.buildId}"
  /><c:set var="pinComment"><c:choose
    ><c:when test="${build.pinComment != null}"
    ><bs:pinCommentToolTipText build="${build}"
    /></c:when
    ><c:otherwise>Pinned builds won't be removed from the history upon automatic history cleanup</c:otherwise
  ></c:choose></c:set
  ><span id="pinImg${buildId}" class='pinImg icon icon16 icon16_pinned_yes' <bs:tooltipAttrs text="${pinComment}" deltaX="-120"/>></span>