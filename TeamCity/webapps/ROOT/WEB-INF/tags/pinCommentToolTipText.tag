<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild"
%><c:set var="pinComment" value="${build.pinComment}"
/><c:if test="${pinComment != null}"
   ><div class="pinComment"><bs:_pinInfo build="${build}"
  /> <bs:_commentInfo comment="${pinComment}"
  /><bs:_commentText comment="${pinComment}" forTooltip="true"
/></div></c:if>