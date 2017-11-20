<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="t" tagdir="/WEB-INF/tags/tags"
%><%@ attribute name="buildPromotion" required="true" type="jetbrains.buildServer.serverSide.BuildPromotion"
%><%@ attribute name="tags" required="true" type="java.util.List<java.lang.String>"
%><%@ attribute name="compactView" required="false" type="java.lang.Boolean"
%><c:set var="linkTextCss" value="${fn:length(tags) == 0 ? 'commentText' : ''}" scope="request"
/><c:set var="linkText" scope="request"><c:choose>
  <c:when test="${fn:length(tags) == 1}"><t:tagLink selected="${false}" buildTypeId="${buildPromotion.buildType.externalId}" tag="${tags[0]}" markAsPrivate="false"/></c:when>
  <c:when test="${fn:length(tags) > 1}">Tags (${fn:length(tags)})</c:when>
  <c:otherwise>${not empty compactView && compactView ? 'No tags' : 'None'}</c:otherwise>
</c:choose></c:set
><c:choose>
  <c:when test="${fn:length(tags) == 0}"
      ><t:editTagsLink buildPromotion="${buildPromotion}" className="none" doNotAddAvailableTags="${true}">${linkText}</t:editTagsLink></c:when>
  <c:otherwise
      ><t:tagsLinkPopup buildPromotion="${buildPromotion}"><span class="${linkTextCss}">${linkText}</span></t:tagsLinkPopup>
  </c:otherwise>
</c:choose>