<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
%><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
%><%@ taglib prefix="util" uri="/WEB-INF/functions/util"
%><%@ taglib prefix="auth" uri="/WEB-INF/functions/authz"
%><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
%><%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ attribute name="vcsRootHTML"                required="true"  fragment="true"
%><%@ attribute name="afterVcsRootNameHTML"       required="true"  fragment="true"
%><%@ attribute name="linksToAdminPage"           required="false" type="java.lang.Boolean"
%><%@ attribute name="tableBuildTypeClass"        required="false" type="java.lang.String"
%><%@ attribute name="depth"                      required="true"  type="java.lang.Integer"
%><%@ attribute name="projectBean"                required="true"  type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"
%>
<%@ variable name-given="vcsRoot" variable-class="jetbrains.buildServer.vcs.SVcsRoot"%>
<c:if test="${not empty projectBean.vcsRoots}">
  <c:forEach var="vcsRoot" items="${projectBean.vcsRoots}">
    <tr class="vcsRoot ${tableBuildTypeClass}  tr-depth-${depth}">
      <td class="vcs_root_name depth-${depth}">
        <c:choose>
          <c:when test="${linksToAdminPage && auth:permissionGrantedForProject(vcsRoot.project, 'EDIT_PROJECT')}">
            <admin:editVcsRootLink classes="icon_before icon16 vcsRoot_link" vcsRoot="${vcsRoot}" cameFromUrl="${pageUrl}" editingScope="none"><c:out value="${vcsRoot.name}"/></admin:editVcsRootLink></c:when>
          <c:otherwise>
            <span class="icon_before icon16 vcsRoot_link"><c:out value="${vcsRoot.name}"/></span>
          </c:otherwise>
        </c:choose>
        <jsp:invoke fragment="afterVcsRootNameHTML"/>
      </td>
      <jsp:invoke fragment="vcsRootHTML"/>
    </tr>
  </c:forEach>
</c:if>

