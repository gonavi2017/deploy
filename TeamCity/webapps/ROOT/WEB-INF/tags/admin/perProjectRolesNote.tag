<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz"
%><authz:authorize allPermissions="CHANGE_SERVER_SETTINGS">
  <div class="grayNote" style="margin-bottom: 0.5em;">
    Navigate to <a href="<c:url value='/admin/admin.html?item=auth'/>">Authentication page</a> to enable per-project permissions.
  </div>
</authz:authorize>