<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile"
  %><%@ attribute name="adminMode" required="true"
  %><%@ attribute name="profileForm" rtexprvalue="true" type="jetbrains.buildServer.controllers.profile.ProfileForm" required="true" %>

<style type="text/css">
  td.vcsName {
    width: 70%;
    vertical-align: top;
  }
</style>

<c:set var="title">Version Control Username Settings<c:choose>
  <c:when test="${adminMode}">
    <a class="editNotifierSettingsLink" href="<c:url value='/admin/vcsSettings.html?init=1&userId=${profileForm.editee.id}'/>"><i class="tc-icon icon16 tc-icon_edit_gray"></i></a>
  </c:when>
  <c:otherwise>
    <a class="editNotifierSettingsLink" href="<c:url value='/vcsSettings.html?init=1'/>"><i class="tc-icon icon16 tc-icon_edit_gray"></i></a>
  </c:otherwise>
</c:choose></c:set>
<l:settingsBlock title="${title}">
  <c:if test="${fn:length(profileForm.vcsUsernames) == 0}">
    <div>There are no VCS usernames configured.</div>
  </c:if>
  <c:if test="${fn:length(profileForm.vcsUsernames) > 0}">
  <table width="99%">
    <c:forEach items="${profileForm.vcsUsernames}" var="vcsUsername">
      <tr>
        <td class="vcsName"><profile:vcsDisplayName vcsUsername="${vcsUsername}"/>:</td>
        <td>
          <c:forEach var="name" items="${vcsUsername.usernames}">
            <div><c:out value="${name}"/></div>
          </c:forEach>
        </td>
      </tr>
    </c:forEach>
  </table>
  </c:if>
  <div class="clr"></div>
</l:settingsBlock>
