<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz" %><%@

    attribute name="buildType" required="true" type="jetbrains.buildServer.serverSide.SBuildType" %><%@
    attribute name="ifAccessGranted" required="false" fragment="true"%><%@
    attribute name="ifAccessDenied" required="false" fragment="true"

%><c:choose
  ><c:when test="${afn:permissionGrantedForProject(buildType.project, 'EDIT_PROJECT') and
                   buildType.templateBased == buildType.templateAccessible}"
    ><c:choose
      ><c:when test="${not empty ifAccessGranted}"><jsp:invoke fragment="ifAccessGranted"/></c:when
      ><c:otherwise><jsp:doBody/></c:otherwise
    ></c:choose
  ></c:when
  ><c:when test="${not empty ifAccessDenied}"
    ><jsp:invoke fragment="ifAccessDenied"
  /></c:when
></c:choose>