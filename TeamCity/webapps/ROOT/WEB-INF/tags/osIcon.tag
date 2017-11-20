<%@ tag import="jetbrains.buildServer.web.util.WebUtil"%><%@
  tag import="jetbrains.buildServer.controllers.agent.OSKind"%><%@
  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
  taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
  attribute name="osName" required="true" type="java.lang.String"%><%@
  attribute name="small" required="false" type="java.lang.Boolean" description="Deprecated. Please don't use. Not supported any more"
  %><c:set var="osKind" value="<%=OSKind.guessByName(osName)%>"
  /><c:if test="${not empty osKind}"><span class="tc-icon icon16 os-icon os-icon_${osKind.code}" title="<c:out value='${osName}'/>"></span></c:if>