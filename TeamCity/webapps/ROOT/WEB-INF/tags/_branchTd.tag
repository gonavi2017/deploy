<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    attribute name="branch" type="jetbrains.buildServer.serverSide.Branch" required="true" %><%@
    attribute name="afterBranch" fragment="true" required="false"

%><td class="branch ${not empty branch ? 'hasBranch' : ''} ${not empty branch and branch.defaultBranch ? 'default' : ''}">
  <c:if test="${not empty branch}"
    ><span class="branchName"><bs:trimBranch branch="${branch}"/></span>
    <jsp:invoke fragment="afterBranch"
  /></c:if
></td>