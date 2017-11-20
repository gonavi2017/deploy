<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ tag import="jetbrains.buildServer.serverSide.SRunningBuild"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ attribute name="currentStatuses" rtexprvalue="true" type="java.util.Collection"
  %><%@ attribute name="alt" required="false"
  %><%
  boolean hasFailed = false;
  boolean hasSuccessful = false;
  for (Object status : currentStatuses) {
    if (((SRunningBuild) status).getStatusDescriptor().isSuccessful()) {
      hasSuccessful = true;
    } else {
      hasFailed = true;
    }
    if (hasFailed && hasSuccessful) break;
  }

  jspContext.setAttribute("hasFailed", Boolean.valueOf(hasFailed));
  jspContext.setAttribute("hasSuccessful", Boolean.valueOf(hasSuccessful));
%><c:choose><c:when test="${hasFailed and hasSuccessful}"
  ><span class="build-status-icon build-status-icon_running-red-transparent" title="${alt}"></span></c:when><c:when test="${hasFailed and !hasSuccessful}"
  ><span class="build-status-icon build-status-icon_running-red-transparent" title="${alt}"></span></c:when><c:when test="${!hasFailed and hasSuccessful}"
  ><span class="build-status-icon build-status-icon_running-green-transparent" title="${alt}"></span></c:when></c:choose>