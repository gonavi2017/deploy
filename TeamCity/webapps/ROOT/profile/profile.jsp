<%@ page import="jetbrains.buildServer.controllers.emailVerification.EmailVerificationController" %>
<%@ page import="jetbrains.buildServer.controllers.interceptors.FirstLoginInterceptor" %>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="currentUser" type="jetbrains.buildServer.users.User" scope="request"/>
<jsp:useBean id="profileForm" type="jetbrains.buildServer.controllers.profile.EditPersonalProfileForm" scope="request"/>
<jsp:useBean id="profileBean" type="jetbrains.buildServer.controllers.admin.GroupedExtensionsBean" scope="request"/>
<c:set var="pageTitle" value="My Settings & Tools" scope="request"/>

<%--<l:defineCurrentTab defaultTab="userGeneralSettings"/>--%>
<bs:page>
<jsp:attribute name="head_include">
  <bs:linkCSS>
    /css/visibleProjects.css
    /css/settingsTable.css
    /css/userRoles.css
    /css/notificationRules.css
    /css/profilePage.css
    /css/settingsBlock.css
    /css/tags.css
    /css/admin/adminMain.css
  </bs:linkCSS>
  <bs:linkScript>
    /js/bs/updateUser.js
    /js/bs/profile.js
    /js/bs/queueLikeSorter.js
    /js/bs/notificationRules.js
  </bs:linkScript>

  <script type="text/javascript">
    BS.Navigation.items = [
      {title: "<c:out value="${pageTitle}"/>", selected: true}
    ];
  </script>
</jsp:attribute>

  <jsp:attribute name="body_include">
  <script type="application/javascript">BS.Navigation.selectMySettingsTab();</script>
  <table id="admin-container">
    <tr>
      <td class="user-profile admin-sidebar compact">
         <ext:showSidebar extensions="${profileBean.extensions}"
                          selectedExtension="${profileBean.selectedExtension}"
                          urlPrefix="/profile.html"/>
      </td>
      <td class="admin-content" style="width: 100%;">
        <bs:messages key="<%=FirstLoginInterceptor.PROFILE_PAGE_WELCOME_MESSAGE_KEY%>" permanent="${true}"/>
        <bs:messages key="<%=EmailVerificationController.MESSAGE_KEY%>" permanent="${true}"/>
        <div id="tabsContainer4" class="simpleTabs clearfix"></div>
        <ext:includeExtension extension="${profileBean.selectedExtension}"/>
      </td>
      <td style="vertical-align: top;">
        <c:if test="${profileBean.selectedExtension.tabId == 'userGeneralSettings'}">
        <div id="sidebar">
          <div class="tools-wrapper">
            <h3>TeamCity Tools</h3>

            <ext:includeExtensions placeId="<%=PlaceId.MY_TOOLS_SECTION%>">
            <jsp:attribute name="separator"><div class="divider"></div></jsp:attribute>
            </ext:includeExtensions>

          </div>
        </div>
        </c:if>
      </td>
    </tr>
  </table>
  <c:if test="${notificationCounter>0}">
    <script type="text/javascript">
      var items = $j('.item a');
      items.each(function(){
        var link = $j(this);
        if (link.html() == 'Notification Rules'){
          link.append('<span class="tabCounter">${notificationCounter}</span>');
        }
      });
    </script>
  </c:if>

</jsp:attribute>

</bs:page>

