<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>

<%@ attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType"%>

<c:set var="tags" value="${buildType.tags}"/>
<c:set var="tagsCount" value="${fn:length(tags)}"/>
<c:set var="checkboxId" value="checkbox_buildTypeTags_${buildType.externalId}"/>
<c:if test="${tagsCount gt 0}">
  <c:set var="tagsLimit" value="${intprop:getInteger('teamcity.ui.collapseTagList.length', 30)}"/>
  <c:set var="isCollapseNeeded" value="${tagsCount > tagsLimit}"/>
  <c:set var="allTags"><%= request.getParameter("allTags") %></c:set>
  <div class="tagsContainer hidden" id="buildTypeTags_${buildType.externalId}">
    <c:set var="moreTags">
      <c:if test="${isCollapseNeeded}">
        <input type="checkbox" class="all-tags-switch" data-id="${checkboxId}" <c:if test="${allTags eq 'true'}">checked</c:if>><label for="${checkboxId}" class="more-tags-separator unselectedTag">and ${tagsCount - tagsLimit} more tag<bs:s val="${tags.size() - tagsLimit}"/></label>
      </c:if>
    </c:set>

    <c:forEach var="tagName" items="${tags}" varStatus="itemStatus">
      <c:set var="escapedTag"><bs:escapeForJs text="${tagName}" forHTMLAttribute="true"/></c:set>
      <t:printTag tag="${tagName}" selected="${false}" markAsPrivate="${false}" onclick="BS.Tags.triggerAppendTags('${escapedTag}'); return false"/>
      <c:if test="${itemStatus.count  == tagsLimit}">${moreTags}</c:if>
    </c:forEach>

    <c:if test="${isCollapseNeeded}">
      <label for="${checkboxId}" class="less-tags-separator unselectedTag">hide ${tagsCount - tagsLimit} tag<bs:s val="${tagsCount - tagsLimit}"/></label>
    </c:if>
  </div>
</c:if>