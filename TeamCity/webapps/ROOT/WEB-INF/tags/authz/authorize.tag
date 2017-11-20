<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ tag import="java.util.*"
  %><%@ tag import="jetbrains.buildServer.serverSide.auth.AuthorityHolder"
  %><%@ tag import="jetbrains.buildServer.serverSide.auth.Permission"
  %><%@ tag import="jetbrains.buildServer.serverSide.auth.Permissions"
  %><%@ tag import="jetbrains.buildServer.util.StringUtil"
  %><%@ tag import="jetbrains.buildServer.web.util.SessionUser"
  %><%@attribute name="projectId" type="java.lang.String" required="false" description="project internal id"
  %><%@attribute name="projectIds" type="java.util.Collection<java.lang.String>" required="false" description="list of project internal ids"
  %><%@attribute name="checkGlobalPermissions" type="java.lang.Boolean" required="false" fragment="false"
  %><%@attribute name="anyPermission" type="java.lang.String" required="false" fragment="false"
  %><%@attribute name="allPermissions" type="java.lang.String" required="false" fragment="false"
  %><%@attribute name="ifAccessGranted" required="false" fragment="true"
  %><%@attribute name="ifAccessDenied" required="false" fragment="true" %><%
  AuthorityHolder _currentUser = SessionUser.getUser(request);
  String permissionNames = anyPermission != null ? anyPermission : allPermissions;
  List<String> names = StringUtil.split(permissionNames, ",");
  List<Permission> perms = new ArrayList<Permission>();
  for (String name: names) {
    Permission p = Permission.lookupPermission(name.trim());
    if (p != null) {
      perms.add(p);
    }
  }
  Permissions required = new Permissions(perms);
  Permissions granted = Permissions.NO_PERMISSIONS;
  if (_currentUser != null) {
    if (projectId != null){
      granted = _currentUser.getPermissionsGrantedForProject(projectId);
    } else if (projectIds != null) {
      granted = _currentUser.getPermissionsGrantedForAllProjects(projectIds);
    } else {
      granted = _currentUser.getGlobalPermissions();
    }

    if (Boolean.TRUE.equals(checkGlobalPermissions) && (projectId != null || projectIds != null)) {
      final Set<Permission> permSet = new HashSet<Permission>(granted.toList());
      permSet.addAll(_currentUser.getGlobalPermissions().toList());
      granted = new Permissions(permSet);
    }
  }
%><c:choose
  ><c:when test="${fn:length(anyPermission) > 0}"><%
      if (granted.containsAny(required)) {
        %><c:choose><c:when test="${not empty ifAccessGranted}"><jsp:invoke fragment="ifAccessGranted"/></c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose><%
      } else {
        %><jsp:invoke fragment="ifAccessDenied"/><%
      }
    %></c:when><c:when test="${fn:length(allPermissions) > 0}"><%
      if (granted.containsAll(required)) {
        %><c:choose><c:when test="${not empty ifAccessGranted}"><jsp:invoke fragment="ifAccessGranted"/></c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose><%
      } else {
        %><jsp:invoke fragment="ifAccessDenied"/><%
      }
    %></c:when></c:choose>