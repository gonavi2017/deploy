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
%><%@ attribute name="buildTypeHTML"              required="true"  fragment="true"
%><%@ attribute name="buildTypeNameHTML"          required="true"  fragment="true"
%><%@ attribute name="afterBuildTypeNameHTML"     required="true"  fragment="true"
%><%@ attribute name="defaultName"                required="false" type="java.lang.Boolean"
%><%@ attribute name="linksToAdminPage"           required="false" type="java.lang.Boolean"
%><%@ attribute name="showBuildTypeDescriptions"  required="false" type="java.lang.Boolean"
%><%@ attribute name="showResponsibilityInfo"     required="false" type="java.lang.Boolean"
%><%@ attribute name="tableBuildTypeClass"        required="false" type="java.lang.String"
%><%@ attribute name="depth"                      required="true"  type="java.lang.Integer"
%><%@ attribute name="projectBean"                required="true"  type="jetbrains.buildServer.web.util.ProjectHierarchyTreeBean"
%>
<%@ variable name-given="buildType" variable-class="jetbrains.buildServer.serverSide.SBuildType" %>

<c:forEach var="buildType" items="${projectBean.buildTypes}">
  <tr class="build_type ${tableBuildTypeClass}  tr-depth-${depth}">
    <td class="build_type_name depth-${depth}">
      <c:if test="${defaultName}">
        <c:choose>
          <c:when test="${linksToAdminPage && auth:permissionGrantedForBuildType(buildType, 'EDIT_PROJECT')}">
            <admin:editBuildTypeLink classes="icon_before icon16 buildType-icon" buildTypeId="${buildType.externalId}"><c:out value="${buildType.name}"/></admin:editBuildTypeLink>
          </c:when>
          <c:otherwise>
            <c:if test="${showResponsibilityInfo}"><bs:responsibleIcon responsibility="${buildType.responsibilityInfo}" buildTypeRef="${buildType}"/></c:if>
            <bs:buildTypeLink buildType="${buildType}" classes="icon_before icon16 buildType-icon"
          /></c:otherwise>
        </c:choose>
        <c:if test="${showBuildTypeDescriptions}"><span class="build_type_description"><bs:out value="${buildType.description}"/></span></c:if>
        <jsp:invoke fragment="afterBuildTypeNameHTML"/>
      </c:if>
      <c:if test="${not defaultName}">
        <jsp:invoke fragment="buildTypeNameHTML"/>
      </c:if>
      </td>
    <jsp:invoke fragment="buildTypeHTML"/>
  </tr>
</c:forEach>
