<%@ page import="jetbrains.buildServer.controllers.profile.AuthorityRolesBean" %><%@
    page import="jetbrains.buildServer.serverSide.auth.RolesHolder" %><%@
    page import="jetbrains.buildServer.web.util.WebUtil" %><%@
    include file="/include-internal.jsp" %><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin"

%><jsp:useBean id="userListForm" type="jetbrains.buildServer.controllers.admin.users.UserListForm" scope="request"
/><jsp:useBean id="availableRolesBean" type="jetbrains.buildServer.controllers.user.AvailableRolesBean" scope="request"
/><jsp:useBean id="pageUrl" type="java.lang.String" scope="request"
/><c:set var="currentTab" value="users"
/><c:set var="userListPager" value="${userListForm.pager}" scope="request"
/><c:set var="encodedCameFromTitle" value='<%=WebUtil.encode("Users")%>'
/><c:set var="encodedCameFromUrl" value="<%=WebUtil.encode(pageUrl)%>"
/><c:set var="usersCount" value="${userListForm.numOfRegisteredUsers}" scope="request"
/><c:set var="userProfileAccessible" value="${afn:permissionGrantedGlobally('CHANGE_USER') or afn:permissionGrantedGlobally('CHANGE_USER_NOTIFICATIONS') or afn:permissionGrantedGlobally('ASSIGN_USERS_ADD_SUBGROUPS') or afn:permissionGrantedForAnyProject('CHANGE_USER_ROLES_IN_PROJECT')}" scope="request"/>

<div>
  <div id="userList">
    <bs:messages key="userCreated" />
    <bs:messages key="userAccountRemoved" />

    <c:url var="usersUrl" value="/admin/admin.html?item=users"/>
    <form id="filterForm" action="${usersUrl}" onsubmit="return BS.UserListForm.doSearch()">
      <%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
      <bs:refreshable containerId="userTable" pageUrl="${usersUrl}">
        <div class="actionBar">
          <div>
            <span class="actionBarRight">
              <label for="usersToShow">Users to show:</label>&nbsp;
                <forms:select name="usersToShow" id="usersToShow" style="width: 5em;" onchange="BS.UserListForm.doSearch()">
                  <forms:option value="20" selected="${userListForm.usersToShow == 20}">20</forms:option>
                  <forms:option value="50" selected="${userListForm.usersToShow == 50}">50</forms:option>
                  <forms:option value="100" selected="${userListForm.usersToShow == 100}">100</forms:option>
                  <forms:option value="500" selected="${userListForm.usersToShow == 500}">500</forms:option>
                  <forms:option value="-1" selected="${userListForm.usersToShow == -1}">All</forms:option>
                </forms:select>
            </span>

            <span class="nowrap">
              <label for="keyword" class="first">Find users:</label>
              <forms:textField name="keyword" size="20" maxlength="1024" value="${userListForm.keyword}"/>
            </span>
            <forms:filterButton/>

            <span class="resetLink">
              <c:if test="${not empty userListForm.keyword or userListForm.hasAdvancedOptions}">
                <forms:resetFilter resetHandler="BS.UserListForm.resetFilter(); BS.UserListForm.doSearch();"/>
              </c:if>
            </span>

            <c:set var="hasAdvanced" value="${not userListForm.advancedOptionsShown and not userListForm.hasAdvancedOptions}"/>
            <c:if test="${hasAdvanced}">
              <a href="#" class="actionBarAdvancedToggle" onclick="return BS.UserListForm.toggleAdvanced(this);">Advanced search</a>
            </c:if>

            <forms:saving className="progressRingInline"/>

            <input type="hidden" name="tab" value="userList"/>
          </div>
          <div class="actionBarAdvanced<c:if test="${hasAdvanced}"> hidden</c:if>" id="advanced-fields">
            <div>
              <label for="groupCode" class="first">in group:</label>
              <forms:select name="groupCode" id="groupCode" className="longField" enableFilter="true">
                <c:forEach items="${userListForm.groups}" var="group">
                  <forms:option value="${group.key}"
                                selected="${userListForm.groupCode == group.key}"><c:out value="${group.name}"/></forms:option>
                </c:forEach>
              </forms:select>
            </div>
            <c:if test="${serverSummary.perProjectPermissionsEnabled}">
              <div>
                <label for="roleId" class="first">with role:</label>
                <forms:select name="roleId" id="roleId" enableFilter="true">
                  <option value="">-- Choose a role --</option>
                  <c:forEach items="${userListForm.roles}" var="role">
                    <forms:option value="${role.id}" selected="${userListForm.roleId == role.id}"><c:out value="${role.name}"/></forms:option>
                  </c:forEach>
                </forms:select>
              </div>
              <div>
                <label for="projectId" class="first">in project:</label>
                <bs:projectsFilter name="projectId" id="projectId"
                                   defaultOption="true"
                                   selectedProjectExternalId="${userListForm.projectExternalId}"
                                   projectBeans="${userListForm.projects}">
                  <jsp:attribute name="additionalOptions">
                    <forms:option value="__ALL__" selected="${userListForm.projectExternalId == '__ALL__'}">&lt;All projects&gt;</forms:option>
                  </jsp:attribute>
                </bs:projectsFilter>
              </div>
              <div>
                <label class="first">&nbsp;</label>
                <forms:checkbox name="rolesConditionInverted" checked="${userListForm.rolesConditionInverted}"/>
                <label for="rolesConditionInverted">Search for users <em>without</em> selected role</label>
              </div>
            </c:if>
          </div>
        </div>

        <bs:messages key="userRolesUpdated"/>
        <bs:messages key="usersAttached"/>
        <bs:messages key="userAssigned"/>

        <table class="usersActions">
          <tr>
            <td class="buttons">
              <authz:authorize allPermissions="CREATE_USER">
                <c:url var="createUserUrl" value="/admin/createUser.html?init=1"/>
                <forms:addButton href="${createUserUrl}">Create user account</forms:addButton>&nbsp;
              </authz:authorize>
              <c:if test="${userListForm.guestUserAvailable and userProfileAccessible}">
                <bs:editUserLink user="${userListForm.guestUser}" tab="userGroups"
                                 cameFromUrl="${pageUrl}" cameFromTitle="${title}">Guest user settings</bs:editUserLink>
              </c:if>

            </td>
            <td class="pagerDesc">
              <c:choose>
                <c:when test="${userListForm.usersCount > 0}">
                  <c:set var="pagerDesc"><strong>${userListForm.usersCount}</strong> user<bs:s val="${userListForm.usersCount}"/></c:set>
                  <bs:pager place="title" urlPattern="" pager="${userListForm.pager}" pagerDesc="${pagerDesc}"/>
                </c:when>
                <c:otherwise>&nbsp;</c:otherwise>
              </c:choose>
            </td>
          </tr>
        </table>

        <l:tableWithHighlighting className="dark sortable userList borderBottom" highlightImmediately="true">
          <tr>
            <c:set var="firstCellClass" value="firstCell"/>
            <th class="selectAll firstCell">
              <forms:checkbox name="selectAll"
                              onmouseover="BS.Tooltip.showMessage(this, {shift: {x: 10, y: 20}, delay: 600}, 'Click to select / unselect all users')"
                              onmouseout="BS.Tooltip.hidePopup()"
                              onclick="if (this.checked) BS.Util.selectAll($('filterForm'), 'userId'); else BS.Util.unselectAll($('filterForm'), 'userId')"/>
            </th>
            <c:set var="firstCellClass" value=""/>
            <th class="sortable ${firstCellClass}" <c:if test="${not serverSummary.perProjectPermissionsEnabled}">style="padding: 3px 3px 3px 6px;"</c:if>>
              <span id="SORT_BY_USERNAME">Username</span>
            </th>
            <th class="sortable"><span id="SORT_BY_NAME">Name</span></th>
            <authz:authorize anyPermission="VIEW_USER_PROFILE, CHANGE_USER">
            <c:if test="${userListForm.displayEmailVerificationStatus}">
              <th class="sortable emailVerification">
                <span id="SORT_BY_EMAIL_VERIFICATION_STATUS" class="icon-ok">&nbsp;&nbsp;&nbsp;</span>
              </th>
            </c:if>
            <th class="sortable email">
              <bs:allEmails users="${userListForm.shownUsers}"/>
              <span id="SORT_BY_EMAIL">Email</span>
            </th>
            </authz:authorize>
            <th>Groups</th>
            <c:choose>
              <c:when test="${serverSummary.perProjectPermissionsEnabled}">
                <th>Roles</th>
              </c:when>
              <c:otherwise>
                <th class="sortable"><span id="SORT_BY_ADMIN_STATUS">Administrator</span></th>
              </c:otherwise>
            </c:choose>
            <th class="sortable lastCell lastLoginTime"><span id="SORT_BY_LAST_ACCESS_TIME">Last login time</span></th>
          </tr>
          <c:forEach items="${userListForm.shownUsers}" var="user">
            <c:set var="onclick"><c:if test="${userProfileAccessible}">BS.openUrl(event, '<bs:editUserLink user="${user}" cameFromTitle="${title}" cameFromUrl="${pageUrl}" noLink="true"/>');</c:if></c:set>
            <c:set var="highlightClass">highlight</c:set>
            <tr>
              <td class="selectUser ${highlightClass}"><forms:checkbox name="userId" value="${user.id}" disabled="${currentUser.id == user.id}"/></td>
              <td class="username ${highlightClass}" onclick="${onclick}">
                <c:if test="${userProfileAccessible}">
                  <bs:editUserLink user="${user}" cameFromTitle="${title}" cameFromUrl="${pageUrl}"><c:out value="${user.username}"/></bs:editUserLink>
                </c:if>
                <c:if test="${not userProfileAccessible}"><c:out value="${user.username}"/></c:if>
              </td>
              <td class="fullname ${highlightClass}" onclick="${onclick}"><c:if test="${fn:length(user.name) == 0}">N/A</c:if> <c:out value="${user.name}"/></td>
              <authz:authorize anyPermission="VIEW_USER_PROFILE, CHANGE_USER">
              <c:if test="${userListForm.displayEmailVerificationStatus}">
              <td class="${highlightClass} emailVerification" style="padding:0; margin:0; text-align: right;">
                <c:if test="${userListForm.displayEmailVerificationStatus && not empty user.verifiedEmail}"><span class="icon-ok"></span></c:if>
              </td>
              </c:if>
              <td class="email ${highlightClass}" onclick="${onclick}"><c:if test="${fn:length(user.email) == 0}">N/A</c:if> <c:out value="${user.email}"/></td>
              </authz:authorize>
              <td class="groups ${highlightClass}" onclick="${onclick}">
                <c:set var="groupsNum" value="${fn:length(user.userGroups)}"/>
                <c:set var="groupsContent"
                  ><c:choose
                  ><c:when test="${groupsNum > 0}">View groups (${groupsNum})</c:when
                  ><c:otherwise>No groups</c:otherwise
                  ></c:choose
                ></c:set>
                <bs:popupControl showPopupCommand="BS.ParentGroupsPopup.showUserParentGroups(this, ${user.id})"
                                 hidePopupCommand="BS.ParentGroupsPopup.hidePopup()"
                                 stopHidingPopupCommand="BS.ParentGroupsPopup.stopHidingPopup()"
                                 controlId="userGroups:${user.id}"
                  ><c:if test="${userProfileAccessible}"><bs:editUserLink user="${user}" tab="userGroups">${groupsContent}</bs:editUserLink></c:if><c:if test="${not userProfileAccessible}">${groupsContent}</c:if></bs:popupControl>
              </td>
              <c:choose>
                <c:when test="${serverSummary.perProjectPermissionsEnabled}">
                  <td class="${highlightClass} roles">
                    <c:set var="rolesCount" value='${fn:length(user.roles)}'/>
                    <c:set var="inheritedRolesCount" value='<%=AuthorityRolesBean.getNumberOfInheritedRoles((RolesHolder)jspContext.getAttribute("user"))%>'/>
                    <c:set var="rolesContent"
                      ><c:choose
                      ><c:when test="${rolesCount + inheritedRolesCount> 0}"
                      >View roles (<c:if test="${rolesCount > 0}"><strong>${rolesCount}</strong></c:if
                      ><c:if test="${rolesCount == 0}">0</c:if><c:if test="${inheritedRolesCount > 0}">/${inheritedRolesCount}</c:if>)</c:when
                      ><c:otherwise>No roles</c:otherwise
                      ></c:choose
                      ></c:set>
                    <bs:popupControl showPopupCommand="BS.AuthorityRolesPopup.showPopup(this, ${user.id})"
                                     hidePopupCommand="BS.AuthorityRolesPopup.hidePopup()"
                                     stopHidingPopupCommand="BS.AuthorityRolesPopup.stopHidingPopup()"
                                     controlId="userRoles:${user.id}"
                      ><c:if test="${userProfileAccessible}"><bs:editUserLink user="${user}" tab="userRoles">${rolesContent}</bs:editUserLink></c:if><c:if test="${not userProfileAccessible}">${rolesContent}</c:if></bs:popupControl>
                  </td>
                </c:when>
                <c:otherwise>
                  <td class="${highlightClass} roles" onclick="${onclick}"><c:if test="${user.systemAdministratorRoleGranted}">Admin</c:if>&nbsp;</td>
                </c:otherwise>
              </c:choose>
              <td class="date ${highlightClass}" onclick="${onclick}"><bs:date value="${user.lastLoginTimestamp}" pattern="dd MMM yy HH:mm:ss"/></td>
            </tr>
          </c:forEach>
        </l:tableWithHighlighting>

        <c:set var="pagerUrlPattern" value="admin.html?item=users&page=[page]"/>
        <bs:pager place="bottom" urlPattern="${pagerUrlPattern}" pager="${userListPager}"/>

        <script type="text/javascript">
          (function() {
            <c:forEach items="${userListForm.sortOptions}" var="sortOption">
              var sortOption = $('${sortOption}');
              if (sortOption) {
                <c:if test="${userListForm.sortBy == sortOption}">
                  sortOption.className = sortOption.className + ' ${userListForm.sortAsc ? "sortedAsc" : "sortedDesc"}';
                </c:if>
                sortOption.on("click", BS.UserListForm.reSort.bindAsEventListener(BS.UserListForm));
              }
            </c:forEach>
            BS.UserListForm.showOrHideActionsOnSelect();
          })();
        </script>
      </bs:refreshable>

      <input type="hidden" name="sortBy" value="${userListForm.sortBy}"/>
      <input type="hidden" name="sortAsc" value="${userListForm.sortAsc}"/>
      <input type="hidden" name="page" value="${userListPager.currentPage}"/>
    </form>

    <admin:assignRolesDialog availableRolesBean="${availableRolesBean}"/>
    <admin:unassignRolesDialog availableRolesBean="${availableRolesBean}"/>
  </div>
</div>

<jsp:include page="/admin/attachToGroups.html"/>

<forms:modified id="users-actions-docked">
  <jsp:body>
    <div class="bulk-operations-toolbar fixedWidth">
      <span class="users-operations">
        <c:if test="${afn:permissionGrantedGlobally('CHANGE_USER') or afn:permissionGrantedForAnyProject('ASSIGN_USERS_ADD_SUBGROUPS')}">
          <a href="#" class="btn btn_primary submitButton" onclick="return BS.UserListForm.addSelected();">Add to groups</a>
        </c:if>
        <c:if test="${serverSummary.perProjectPermissionsEnabled and
                      (afn:permissionGrantedGlobally('CHANGE_USER') or afn:permissionGrantedForAnyProject('CHANGE_USER_ROLES_IN_PROJECT'))}">
          <a href="#" class="btn btn_primary submitButton" onclick="return BS.UserListForm.toggleSelected(true);">Assign roles</a>
          <a href="#" class="btn btn_primary submitButton" onclick="return BS.UserListForm.toggleSelected(false);">Unassign roles</a>
        </c:if>
        <c:if test="${afn:permissionGrantedGlobally('DELETE_USER')}">
          <a href="#" class="btn btn_primary submitButton" onclick="return BS.UserListForm.removeSelected();">Remove users</a>
        </c:if>
      </span>
    </div>
  </jsp:body>
</forms:modified>
