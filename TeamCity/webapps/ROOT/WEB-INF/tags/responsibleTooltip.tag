<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="responsibility" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="false" %><%@
    attribute name="responsibilities" type="java.util.List" required="false" %><%@
    attribute name="test" type="jetbrains.buildServer.serverSide.STest" required="false" %><%@
    attribute name="buildTypeRef" type="jetbrains.buildServer.serverSide.SBuildType" required="false" %><%@
    attribute name="noActions" type="java.lang.Boolean" required="false"

%><c:choose
  ><c:when test="${not empty responsibilities}"
    ><c:forEach items="${responsibilities}" var="resp"
      ><bs:responsibilityInfo responsibility="${resp}" respProject="${not empty test ? resp.project : null}"
    /></c:forEach
    ><c:set var="responsibility" value="${responsibilities[0]}"
  /></c:when
  ><c:otherwise
    ><bs:responsibilityInfo responsibility="${responsibility}" respProject="${not empty test ? responsibility.project : null}"
  /></c:otherwise
></c:choose
><c:if test="${not empty test and not empty responsibility and not noActions}"
  ><authz:authorize projectId="${test.projectId}" anyPermission="ASSIGN_INVESTIGATION,MANAGE_BUILD_PROBLEMS"
    ><jsp:attribute name="ifAccessGranted"
      ><div class="actions"><tt:testInvestigationLinks test="${test}" buildId="" withFix="${responsibility.state.active}"/></div>
    </jsp:attribute
    ><jsp:attribute name="ifAccessDenied"
      ><div class="actions">No permissions to modify investigation</div>
    </jsp:attribute
  ></authz:authorize
></c:if><c:if test="${not empty responsibility and not noActions}"
  ><resp:btResponsibilityActions buildTypeRef="${buildTypeRef}" noActions="${noActions}" responsibility="${responsibility}"/>
</c:if>