<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="idPrefix" required="true" type="java.lang.String" %><%@
    attribute name="divClass" required="false" type="java.lang.String" %><%@
    attribute name="entry" required="true" type="jetbrains.buildServer.controllers.quickNav.QuickNavigationEntryBean"

%><div id="${idPrefix}-${entry.id}" class="entry ${not empty divClass ? divClass : ''}">
  <c:set var="val"><span class="val"><c:out value="${entry.name}"/></span></c:set>
  <c:if test="${entry.type == 'bt'}">
    <bs:buildTypeLink buildType="${entry.buildType}" classes="nav">${val}</bs:buildTypeLink>
  </c:if>
  <c:if test="${entry.type == 'project'}">
    <bs:projectLink project="${entry.project}" classes="nav">${val}</bs:projectLink>
  </c:if>

  <c:set var="parents" value="${entry.parents}"/>
  <c:if test="${not empty parents}">
    <span class="path">
      (<c:forEach var="elem" items="${parents}" varStatus="status"
        ><bs:projectLink project="${elem}"
                        additionalUrlParams="&from=allProjects"
        /><c:if test="${not status.last}"> <span style="font-size: 80%">&gt;</span> </c:if
      ></c:forEach>)
    </span>
  </c:if>
</div>