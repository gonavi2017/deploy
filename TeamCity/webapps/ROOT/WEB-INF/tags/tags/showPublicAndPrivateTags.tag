<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ attribute name="buildTypeId" required="true" %>
<%@ attribute name="publicTags" type="java.util.List" %>
<%@ attribute name="selectedPublicTag" %>
<%@ attribute name="privateTags" type="java.util.List" %>
<%@ attribute name="selectedPrivateTag" %>
<%@ attribute name="hidePrivateTags" type="java.lang.Boolean" required="true" %>
<%@ attribute name="label" %>
<%@ attribute name="doNotCollapse" required="false" type="java.lang.Boolean" %>
<c:if test="${not empty publicTags or not empty privateTags or not empty selectedPublicTag or not empty selectedPrivateTag}">
  <c:if test="${not empty label}"><label class="first">${label}&nbsp;</label></c:if>
  <c:if test="${!hidePrivateTags}">
  <t:showTags tags="${privateTags}"
              buildTypeId="${buildTypeId}"
              selectedTag="${selectedPrivateTag}"
              markAsPrivate="${true}"
              doNotCollapse="${doNotCollapse}"
              onclick="return BS.HistoryTable.setTagAndSearch($j(this).find('.privateTagText').text(), 'privateTag');"/>
  </c:if>
  <t:showTags tags="${publicTags}"
              buildTypeId="${buildTypeId}"
              selectedTag="${selectedPublicTag}"
              doNotCollapse="${doNotCollapse}"
              onclick="return BS.HistoryTable.setTagAndSearch($j(this).find('.tagText').text(), 'tag');"/>
  <c:if test="${not empty selectedPrivateTag or not empty selectedPublicTag}">
    <forms:resetFilter resetHandler="return BS.HistoryTable.resetTagAndSearch();"/>
  </c:if>
</c:if>
