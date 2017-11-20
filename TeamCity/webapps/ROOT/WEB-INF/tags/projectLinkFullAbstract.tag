<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util"%><%@
    attribute name="project" rtexprvalue="true" type="jetbrains.buildServer.serverSide.SProject" required="true" %><%@
    attribute name="withSeparatorInTheEnd" required="false" %><%@
    attribute name="contextProject" required="false" type="jetbrains.buildServer.serverSide.SProject" %><%@
    attribute name="skipContextProject" required="false" type="java.lang.Boolean" %><%@
    attribute name="projectHtml" required="true" fragment="true" %><%@ variable name-given="proj"
%><c:set var="contextProjectInfo" value="${util:contextProjectInfo(project, (!skipContextProject ? contextProject : null) )}"/><c:choose
    ><c:when test="${project.rootProject}"><c:set var="proj" value="${project}"/><jsp:invoke fragment="projectHtml"/></c:when
    ><c:otherwise
    ><c:choose><c:when test="${!withSeparatorInTheEnd && contextProjectInfo.fullyCollapsed}"
    ><c:set var="proj" value="${contextProjectInfo.lastCollapsed}"/><jsp:invoke fragment="projectHtml"/></c:when><c:otherwise
    ><c:if test="${contextProjectInfo.collapsed}"
    ><div class="contextProjectWrapper"><span class="contextProjectDescription hidden"
    ><c:forEach items="${contextProjectInfo.collapsedPath}" var="p" varStatus="status"
        ><c:if test="${!status.first}"><c:set var="proj" value="${p}"/><jsp:invoke fragment="projectHtml"/><c:if test="${!status.last}"> :: </c:if></c:if
    ></c:forEach
    ></span><div class="contextProjectIcon" onmouseover="BS.Tooltip.showMessageFromContainer(this, {shift:{x:10,y:-30}}, this.parentNode.getElementsByTagName('span')[0]);" onmouseout="BS.Tooltip.hidePopup();">&hellip; </div></div>
</c:if
    ><c:forEach items="${contextProjectInfo.visiblePath}" var="p" varStatus="status"
       ><c:if test="${not p.rootProject}"><c:set var="proj" value="${p}"/><jsp:invoke fragment="projectHtml"/><c:if test="${withSeparatorInTheEnd or not status.last}"> :: </c:if
       ></c:if
       ></c:forEach
       ></c:otherwise
    ></c:choose
    ></c:otherwise
    ></c:choose>