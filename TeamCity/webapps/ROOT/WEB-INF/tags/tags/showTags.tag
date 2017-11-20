<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>
<%@ taglib prefix="intprop" uri="/WEB-INF/functions/intprop"%>
<%@ attribute name="tags" required="true" type="java.util.List"%>
<%@ attribute name="markAsPrivate" type="java.lang.Boolean"%>
<%@ attribute name="selectedTag" required="false"%>
<%@ attribute name="onclick" %>
<%@ attribute name="buildTypeId" required="true" type="java.lang.String"%>
<%@ attribute name="doNotCollapse" required="false" type="java.lang.Boolean" %>
<c:if test="${not empty tags}">
  <c:set var="tagsLimit" value="${intprop:getInteger('teamcity.ui.collapseTagList.length', 30)}"/>
  <c:set var="tagsCount" value="${fn:length(tags)}"/>
  <c:set var="checkboxId" value="all-tags-switch"/>
  <c:set var="isCollapseNeeded" value="${not doNotCollapse and tagsCount > tagsLimit}"/>
  <%-- it is assumed that that there's only one (or at most less than `teamcity.ui.collapseTagList.length`) private tag present
  and thus only one checkbox is generated --%>
  <c:set var="moreTags"><c:if test="${isCollapseNeeded}"
      ><input type="checkbox" class="all-tags-switch" id="${checkboxId}" <c:if test="${param.get('allTags') eq 'true'}">checked</c:if>><label for="${checkboxId}" class="more-tags-separator unselectedTag">and ${tagsCount - tagsLimit} more tag<bs:s val="${tagsCount - tagsLimit}"/></label></c:if
  ></c:set>
  <c:if test="${not empty selectedTag}"><t:tagLink buildTypeId="${buildTypeId}" tag="${selectedTag}" selected="${true}" markAsPrivate="${markAsPrivate}" onclick="${onclick}"/></c:if>
  <c:forEach var="tag" items="${tags}" varStatus="itemStatus"
      ><c:if test="${!(tag eq selectedTag)}"> <t:tagLink buildTypeId="${buildTypeId}" tag="${tag}" selected="${false}" markAsPrivate="${markAsPrivate}" onclick="${onclick}"
      /></c:if
      ><c:if test="${itemStatus.count + (empty selectedTag ? 0 : 1) == tagsLimit}">${moreTags}</c:if>
  </c:forEach>
  <c:if test="${isCollapseNeeded}"><label for="${checkboxId}" class="less-tags-separator unselectedTag">hide ${tagsCount - tagsLimit} tag<bs:s val="${tagsCount - tagsLimit}"/></label></c:if>
</c:if>