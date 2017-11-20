<%@ tag import="jetbrains.buildServer.serverSide.impl.remoteDebug.RemoteDebugServerHelper"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@attribute name="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion" required="true"
  %><c:set var="myBuild" value="${buildPromotion.personal and currentUser == buildPromotion.owner}"
  /><c:set var="debugSession" value="<%=buildPromotion.isPersonal() && RemoteDebugServerHelper.isRemoteDebugBuild(buildPromotion)%>"
  /><c:choose
  ><c:when test="${buildPromotion.personal and not debugSession and myBuild}">Your personal build</c:when
  ><c:when test="${buildPromotion.personal and not debugSession and not myBuild and not empty buildPromotion.owner}">Personal build by <c:out value="${buildPromotion.owner.descriptiveName}"/></c:when
  ><c:when test="${buildPromotion.personal and not debugSession and not myBuild and empty buildPromotion.owner}">Personal build by unknown user</c:when
  ><c:when test="${buildPromotion.personal and debugSession and myBuild}">Your debug session</c:when
  ><c:when test="${buildPromotion.personal and debugSession and not myBuild and not empty buildPromotion.owner}">Debug session by <c:out value="${buildPromotion.owner.descriptiveName}"/></c:when
  ><c:when test="${buildPromotion.personal and debugSession and not myBuild and empty buildPromotion.owner}">Debug session by unknown user</c:when
  ></c:choose>