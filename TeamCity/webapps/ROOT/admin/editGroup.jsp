<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="editGroupBean" type="jetbrains.buildServer.controllers.admin.groups.EditGroupBean" scope="request"/>
<%--@elvariable id="profileBean" type="jetbrains.buildServer.controllers.admin.GroupedExtensionsBean"--%>
<c:set var="currentTab" value="${profileBean.selectedExtension.pluginName}"/>
<c:choose>
  <c:when test="${currentTab == 'groupGeneralSettings'}"><c:set var="pageTitle" scope="request" value="Edit Group ${editGroupBean.group.name}"/></c:when>
  <c:when test="${currentTab == 'groupUsers'}"><c:set var="pageTitle" scope="request" value="Edit Users of Group ${editGroupBean.group.name}"/></c:when>
  <c:when test="${currentTab == 'groupNotifications'}"><c:set var="pageTitle" scope="request" value="Edit Notification Rules of Group ${editGroupBean.group.name}"/></c:when>
  <c:otherwise><c:set var="pageTitle" scope="request" value="Edit Roles of ${editGroupBean.group.name}"/></c:otherwise>
</c:choose>
<bs:page>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/admin/userListFilter.css
      /css/admin/userGroups.css
      /css/userRoles.css
      /css/admin/adminMain.css
      /css/notificationRules.css
      /css/profilePage.css
      /css/settingsBlock.css
    </bs:linkCSS>
    <bs:linkScript>
      /js/bs/profile.js
      /js/bs/userGroups.js
      /js/bs/queueLikeSorter.js
      /js/bs/notificationRules.js
    </bs:linkScript>
    <script type="text/javascript">
      BS.Navigation.items = [
        {title: "Administration", url: '<c:url value="/admin/admin.html"/>'},
        <forms:cameBackNav cameFromSupport="${editGroupBean.cameFromSupport}"/>,
        {title: '<bs:escapeForJs text="${editGroupBean.group.name}" forHTMLAttribute="true"/>', selected: true}
      ];
    </script>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <table id="admin-container">
      <tr>
        <c:url var="baseUrl" value='/admin/editGroup.html?init=1&groupCode=${editGroupBean.group.key}'/>
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
          <jsp:include page="${profileBean.selectedExtension.includeUrl}"/>
        </td>
      </tr>
    </table>

  </jsp:attribute>
</bs:page>
