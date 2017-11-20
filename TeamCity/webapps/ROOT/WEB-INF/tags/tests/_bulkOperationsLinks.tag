<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="groupId" required="true" type="java.lang.String" %><%@
    attribute name="noFix" required="true" type="java.lang.Boolean" %><%@
    attribute name="projectId" required="true" type="java.lang.String"
%>
<c:if test="${not noFix}">
  <authz:authorize projectId="${projectId}" anyPermission="ASSIGN_INVESTIGATION">
    <jsp:attribute name="ifAccessGranted">
      <a class="bulk-operation-link" href="#" title="Fix and unmute selected tests"
         onclick="return BS.TestGroup.investigateSelected('#${groupId}', true);">Fix...</a>
    </jsp:attribute>
  </authz:authorize>
</c:if>
<tt:testInvestigationLink onclick="return BS.TestGroup.investigateSelected('#${groupId}');" projectId="${projectId}"/>
<a class="bulk-operation-link bulk-operation-cancel" href="#" onclick="jQuery('#${groupId}-actions-docked').hide(); return false;">Cancel</a>