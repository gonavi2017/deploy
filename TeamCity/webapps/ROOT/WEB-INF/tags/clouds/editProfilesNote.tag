<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="authz" tagdir="/WEB-INF/tags/authz"%>
<authz:authorize allPermissions="MANAGE_AGENT_CLOUDS">  
  Cloud profile settings can be specified on the <a href="<c:url value="/admin/editProject.html?projectId=_Root&tab=clouds"/>">configuration page</a>.
</authz:authorize>