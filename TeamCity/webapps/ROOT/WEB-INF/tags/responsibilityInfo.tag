<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="tt" tagdir="/WEB-INF/tags/tests" %><%@
    taglib prefix="resp" tagdir="/WEB-INF/tags/responsible" %><%@
    taglib prefix="responsible" uri="/WEB-INF/functions/resp" %><%@
    taglib prefix="authz" tagdir="/WEB-INF/tags/authz" %><%@
    attribute name="responsibility" type="jetbrains.buildServer.responsibility.ResponsibilityEntry" required="true" %><%@
    attribute name="respProject" type="jetbrains.buildServer.serverSide.SProject" required="false"

%><c:set var="state" value="${responsibility.state}"
/><div class="name-value"><table>
  <c:if test="${not empty respProject}">
    <tr>
      <th>Investigated in:</th>
      <td><bs:projectLinkFull project="${respProject}"/></td>
    </tr>
  </c:if>
  <c:if test="${state.active}">
    <tr>
      <th>Investigator:</th>
      <td><c:out value="${responsibility.responsibleUser.descriptiveName}"/></td>
    </tr>
  </c:if>
  <c:if test="${state.fixed}">
    <tr>
      <th>Fixed by:</th>
      <td><c:out value="${responsibility.responsibleUser.descriptiveName}"/></td>
    </tr>
  </c:if>
  <c:if test="${(state.active or state.fixed) and
                responsibility.reporterUser != null and
                responsibility.responsibleUser.id != responsibility.reporterUser.id}">
    <tr>
      <th>${state.active ? 'Assigned' : 'Done'} by:</th>
      <td><c:out value="${responsibility.reporterUser.descriptiveName}"/></td>
    </tr>
  </c:if>
  <tr>
    <th>Since:</th>
    <td><bs:date value="${responsibility.timestamp}"/></td>
  </tr>
  <c:if test="${state.active}">
    <tr>
      <th>Resolve:</th>
      <td>${responsibility.removeMethod.whenFixed ? 'automatically when fixed' : 'manually'}</td>
    </tr>
  </c:if>
  <c:if test="${not empty responsibility.comment}">
    <tr>
      <th>Comment:</th>
      <td class="resp-comment"><bs:out value="${responsibility.comment}"/></td>
    </tr>
  </c:if>
</table></div>