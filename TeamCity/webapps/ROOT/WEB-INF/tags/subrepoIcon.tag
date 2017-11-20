<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="changefn" uri="/WEB-INF/functions/change" %>
<%@ attribute name="modification" type="jetbrains.buildServer.vcs.SVcsModification" required="true" %>
<c:if test="${modification != null && changefn:isSubrepoChange(modification)}">
  <i class="tc-icon icon16 tc-icon_subrepo" title="Change from ${modification.vcsRoot.name}"></i>
</c:if>
