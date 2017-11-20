<%@ tag import="jetbrains.buildServer.util.StringUtil" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"%><%@
    attribute name="style" required="false"
%><c:if test="${project.archived}">
  <div class="headerNote" <c:if test="${style != null}">style="${style}"</c:if>>
    <c:set var="archivingUser" value="${project.archivingUser}"/>
    <span class="icon build-status-icon build-status-icon_paused"></span>
    <span>Project was archived <c:if test="${not empty archivingUser}">by <c:out value="${archivingUser.descriptiveName}"/></c:if> <%=StringUtil.elapsedTimeToString(project.getArchivingTime())%></span>
  </div>
</c:if>