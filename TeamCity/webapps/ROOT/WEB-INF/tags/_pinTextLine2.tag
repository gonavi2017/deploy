<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ attribute name="build" required="true" type="jetbrains.buildServer.serverSide.SFinishedBuild"
%><c:set var="pinComment" value="${build.pinComment}"
/><c:if test="${pinComment != null}"
   ><c:set var="textOfComment"
     ><bs:_commentText comment="${build.pinComment}" forTooltip="false"
  /></c:set>${textOfComment}</c:if>