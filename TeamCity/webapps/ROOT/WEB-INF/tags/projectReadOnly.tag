<%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject"
%><c:if test="${project.readOnly}">
  <div class="headerNote">
    Editing of the project settings is disabled, reason: <c:out value="${project.readOnlyReason}"/>.
  </div>
</c:if>