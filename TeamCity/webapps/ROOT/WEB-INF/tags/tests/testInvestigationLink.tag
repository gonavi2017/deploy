<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="onclick" required="true" %><%@
    attribute name="projectId" required="true" %><%@
    attribute name="hideMuteLink" type="java.lang.Boolean" required="false"
%><c:set var="investigateLink"
><a class="bulk-operation-link" href="#" title="Assign a user to investigate problems" onclick="${onclick}">Investigate...</a></c:set
><c:choose
  ><c:when test="${true eq hideMuteLink}">${investigateLink}</c:when
  ><c:otherwise
    ><authz:authorize projectId="${projectId}" allPermissions="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS">
      <jsp:attribute name="ifAccessGranted">
        <a class="bulk-operation-link" href="#" title="Assign a user to investigate problems or mute them"
           onclick="${onclick}">Investigate / Mute...</a>
      </jsp:attribute>
      <jsp:attribute name="ifAccessDenied">
        <authz:authorize projectId="${projectId}" allPermissions="MANAGE_BUILD_PROBLEMS">
          <jsp:attribute name="ifAccessGranted">
            <a class="bulk-operation-link" href="#" title="Mute problems" onclick="${onclick}">Mute...</a>
          </jsp:attribute>
          <jsp:attribute name="ifAccessDenied">${investigateLink}</jsp:attribute>
        </authz:authorize>
      </jsp:attribute>
    </authz:authorize
></c:otherwise></c:choose>