<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags" %>

<%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"%>
<%@ attribute name="beforeTags" fragment="true" %>
<%@ attribute name="afterTags" fragment="true" %>
<%@ attribute name="onNoTags" fragment="true" %>
<%@ attribute name="hidePrivateTags" required="true" type="java.lang.Boolean" %>

<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.SUser" scope="request"/>
<c:set var="publicTags" value="${buildPromotion.tags}"/>
<c:set var="privateTags" value="<%=buildPromotion.getPrivateTags(currentUser)%>"/>
<c:choose>
  <c:when test="${fn:length(publicTags) == 0 and (fn:length(privateTags) == 0 || hidePrivateTags)}"><c:if test="${not empty onNoTags}"><jsp:invoke fragment="onNoTags"/></c:if></c:when>
  <c:otherwise>
    <div class="tags">
      <c:if test="${not empty beforeTags}"><jsp:invoke fragment="beforeTags"/></c:if>
      <t:showPublicAndPrivateTags buildTypeId="${buildPromotion.buildType.externalId}"
                                  publicTags="${publicTags}"
                                  privateTags="${privateTags}"
                                  doNotCollapse="${true}"
                                  hidePrivateTags="${hidePrivateTags}"/>
      <c:if test="${not empty afterTags}"><jsp:invoke fragment="afterTags"/></c:if>
    </div>
  </c:otherwise>
</c:choose>
