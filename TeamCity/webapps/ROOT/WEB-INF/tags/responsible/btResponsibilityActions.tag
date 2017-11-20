<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="responsibility" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="true" %><%@
    attribute name="buildTypeRef" type="jetbrains.buildServer.serverSide.SBuildType" required="false" %><%@
    attribute name="noActions" type="java.lang.Boolean" required="false"

%><c:set var="state" value="${responsibility.state}"
/><c:if test="${not empty buildTypeRef and not noActions}"
  ><authz:authorize projectId="${buildTypeRef.projectId}" anyPermission="ASSIGN_INVESTIGATION">
    <jsp:attribute name="ifAccessGranted">
      <div class="actions">
        <c:set var="btId" value="${buildTypeRef.externalId}"/>
        <c:set var="name"><bs:escapeForJs text="${buildTypeRef.name}" forHTMLAttribute="true"/></c:set>
        <c:if test="${state.active and responsibility.responsibleUser == currentUser}">
          <a onclick="return BS.ResponsibilityDialog.showDialog('${btId}', '${name}', true);" href="#">Fix...</a>
          <span class="separator">|</span>
        </c:if>
        <a onclick="return BS.ResponsibilityDialog.showDialog('${btId}', '${name}');" href="#">Investigate...</a>
      </div>
    </jsp:attribute>
  </authz:authorize
></c:if>