<%--suppress XmlPathReference --%>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="bs" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/include-internal.jsp"%>
<%--@elvariable id="healthStatusItem" type="jetbrains.buildServer.serverSide.healthStatus.BuildTypeSuggestedItem"--%>
<%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
<%--@elvariable id="suggestedTrackers" type="java.util.Map<java.lang.String, java.util.Map<java.lang.String, java.lang.Object>>"--%>
<c:set var="suggestedTrackers" value="${healthStatusItem.additionalData['suggestedTrackers']}"/>
<c:set var="numSuggestedTrackers" value="${fn:length(suggestedTrackers.keySet())}"/>
<jsp:useBean id="cons" class="jetbrains.buildServer.issueTracker.tfs.TfsIssueConstants"/>

<div class="suggestionItem">
  There <bs:are_is val="${numSuggestedTrackers}"/>
  <c:choose>
    <c:when test="${numSuggestedTrackers == 1}"> a </c:when>
    <c:otherwise> ${numSuggestedTrackers} </c:otherwise>
  </c:choose>
  VCS root<bs:s val="${numSuggestedTrackers}"/> in the project <admin:editProjectLink projectId="${project.externalId}"><c:out value="${project.fullName}"/></admin:editProjectLink>
  that point<c:if test="${numSuggestedTrackers == 1}">s</c:if> to TFS. Do you want to use ${cons.longName} issue tracker<bs:s val="${numSuggestedTrackers}"/> as well?
  <c:forEach var="itemEntry" items="${suggestedTrackers}">
    <c:set var="item" value="${itemEntry.value}"/>
    <div class="suggestionAction">
      <c:url var="url" value="/admin/editProject.html?init=1&projectId=${project.externalId}&tab=issueTrackers&#addTracker=${item['type']}&serverUrl=${util:urlEscape(item['serverUrl'])}&name=${util:urlEscape(item['name'])}"/>
      <forms:addLink href="${url}">Use ${cons.longName} issue tracker for ${item['name']}</forms:addLink>
    </div>
  </c:forEach>
</div>