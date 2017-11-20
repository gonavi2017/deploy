<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="profile" tagdir="/WEB-INF/tags/userProfile" %>

<jsp:useBean id="adminEditUserForm" type="jetbrains.buildServer.controllers.admin.users.AdminEditUserForm" scope="request"/>
<l:defineCurrentTab defaultTab="${afn:permissionGrantedGlobally('CHANGE_USER') and not adminEditUserForm.guestUser ? 'userGeneralSettings' : 'userGroups'}"/>
<c:choose>
  <c:when test="${currentTab == 'userGeneralSettings'}"><c:set var="pageTitle" scope="request"
                                                               value="Edit General Settings of ${adminEditUserForm.editee.descriptiveName}"/></c:when>
  <c:when test="${currentTab == 'userRoles'}"><c:set var="pageTitle" scope="request" value="Edit Roles of ${adminEditUserForm.editee.descriptiveName}"/></c:when>
  <c:when test="${currentTab == 'userNotifications'}"><c:set var="pageTitle" scope="request"
                                                             value="Edit Notification Rules of ${adminEditUserForm.editee.descriptiveName}"/></c:when>
  <c:otherwise><c:set var="pageTitle" scope="request" value="View Groups of ${adminEditUserForm.editee.descriptiveName}"/></c:otherwise>
</c:choose>
<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/profilePage.css
    /css/settingsBlock.css
    /css/userRoles.css
    /css/admin/adminMain.css
    /css/admin/userGroups.css
    /css/notificationRules.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/updateUser.js
    /js/bs/profile.js
    /js/bs/userGroups.js
    /js/bs/queueLikeSorter.js
    /js/bs/notificationRules.js
  </bs:linkScript>
  <script type="text/javascript">
    BS.Navigation.items = [
      {title: "Administration", url: '<c:url value="/admin/admin.html"/>'},
      {title: "Users", url: '<c:url value="/admin/admin.html?item=users"/>'},
      {title: '<bs:escapeForJs text="${adminEditUserForm.editee.descriptiveName}" forHTMLAttribute="true"/>', selected: true}
    ];
  </script>
</jsp:attribute>

  <jsp:attribute name="body_include">
    <%--@elvariable id="profileBean" type="jetbrains.buildServer.controllers.admin.GroupedExtensionsBean"--%>
    <table id="admin-container">
      <tr>
        <c:url var="baseUrl" value='/admin/editUser.html?init=1&userId=${adminEditUserForm.editee.id}'/>
        <td class="user-profile admin-sidebar compact">
          <c:forEach items="${profileBean.extensions}" var="entry">
            <div class="category">${entry.key}</div>
            <c:forEach items="${entry.value}" var="ext">
              <div class="item${ext == profileBean.selectedExtension ? ' active' : ''}">
                <a href="${baseUrl}&item=${ext.tabId}&init=1">${ext.tabTitle}</a>
              </div>
            </c:forEach>
          </c:forEach>
        </td>
        <td class="admin-content" style="width: 100%;">
         <c:choose>
          <c:when test="${profileBean.selectedExtension.pluginName == 'vcsUsernames'}">
            <jsp:include page="/admin/vcsSettings.html?userId=${adminEditUserForm.editee.id}"/>
          </c:when>
          <c:otherwise>
            <jsp:include page="${profileBean.selectedExtension.includeUrl}"/>
          </c:otherwise>
        </c:choose>
        </td>
      </tr>
    </table>
</jsp:attribute>

</bs:page>

