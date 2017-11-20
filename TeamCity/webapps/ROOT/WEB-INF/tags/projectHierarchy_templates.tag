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
%><%@ attribute name="templateHTML"               required="true"  fragment="true"
%><%@ attribute name="afterTemplateNameHTML"      required="true"  fragment="true"
%><%@ attribute name="linksToAdminPage"           required="false" type="java.lang.Boolean"
%><%@ attribute name="tableBuildTypeClass"        required="false" type="java.lang.String"
%><%@ attribute name="depth"                      required="true"  type="java.lang.Integer"
%><%@ attribute name="projectBean"                required="true"  type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"
%>
<%@ variable name-given="template" variable-class="jetbrains.buildServer.serverSide.BuildTypeTemplate"%>
<c:if test="${not empty projectBean.templates}">
  <c:forEach var="template" items="${projectBean.templates}">
    <tr class="template ${tableBuildTypeClass}  tr-depth-${depth}">
      <td class="template_name depth-${depth}">
        <c:choose>
          <c:when test="${linksToAdminPage && auth:permissionGrantedForProject(template.project, 'EDIT_PROJECT')}">
            <admin:editTemplateLink classes="icon_before icon16 template_link" templateId="${template.externalId}"><c:out value="${template.name}"/></admin:editTemplateLink>
          </c:when>
          <c:otherwise>
            <span class="icon_before icon16 template_link"><c:out value="${template.name}"/></span>
          </c:otherwise>
        </c:choose>
        <jsp:invoke fragment="afterTemplateNameHTML"/>
      </td>
      <jsp:invoke fragment="templateHTML"/>
    </tr>
  </c:forEach>
</c:if>

