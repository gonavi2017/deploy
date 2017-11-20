<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %>

<jsp:useBean id="pageUrl" type="java.lang.String" scope="request"
/><jsp:useBean id="customizeLink" scope="request" type="java.lang.String"
/><jsp:useBean id="feed_noAuth" scope="request" type="java.lang.Boolean"
/><jsp:useBean id="feed_guestAuth" scope="request" type="java.lang.Boolean"
/><jsp:useBean id="feed_userAuth" scope="request" type="java.lang.Boolean"

/><c:set var="feed_encodedCameFrom" value="${util:urlEscape(pageUrl)}"/>

<style type="text/css">
  .feed-links {
    margin-bottom: 0.3em;
    padding-top: 1em;
    padding-left: 0.35em;
  }

  .feed-links .icon-rss-sign {
    color: #DF6722;
  }
</style>

<div class="feed-links">
  <c:url value="/admin/editBuild.html?init=1&id=buildType:${feed_buildType.buildTypeId}&cameFromUrl=${feed_encodedCameFrom}"
         var="feed_buildTypeEditPage"/>
  <c:if test="${feed_guestAuth}">
    <c:set var="feed_adminNote">
      This feed is available only to the guest user and users that are logged in.<br/>
      Set "Enable status widget" in the <a href='${feed_buildTypeEditPage}'>build configuration settings</a> to make the feed publicly available.
    </c:set>
  </c:if>
  <c:if test="${feed_userAuth}">
    <c:set var="feed_adminNote">
      Users must be logged in to view this feed.<br/>
      Set "Enable status widget" in the <a href='${feed_buildTypeEditPage}'>build configuration settings</a> to make the feed publicly available.
    </c:set>
  </c:if>
 <a style="text-decoration: none" href="${util:escapeUrlForQuotes(feedUrl)}" <c:if test="${feed_userAuth}">onclick="return window.confirm('Feed requres HTTP basic authentication. You will be prompted for username/password. Continue?');" </c:if>>
   <i class="icon-rss-sign" <authz:authorize projectId="${feed_buildType.projectId}" allPermissions="EDIT_PROJECT">
    <jsp:attribute name="ifAccessGranted"><bs:tooltipAttrs text="${feed_adminNote}"/></jsp:attribute>
  </authz:authorize>></i></a>
 <a href="${util:escapeUrlForQuotes(feedUrl)}" <c:if test="${feed_userAuth}">onclick="return window.confirm('Feed requres HTTP basic authentication. You will be prompted for username/password. Continue?');" </c:if>>Subscribe</a>

  to ${feedDescription}
  <authz:authorize allPermissions="CHANGE_OWN_PROFILE">
  or <a href="${customizeLink}?cameFromUrl=${feed_encodedCameFrom}">customize</a> a feed
  </authz:authorize>
</div>
