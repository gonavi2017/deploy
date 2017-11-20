<%@include file="/include-internal.jsp"%>
<jsp:useBean id="usagesBean" type="jetbrains.buildServer.controllers.admin.projects.TemplateUsagesBean" scope="request"/>

<div>This template is used in <strong>${usagesBean.dependenciesNumber}</strong> build configuration<bs:s val="${usagesBean.dependenciesNumber}"/>.
  <c:if test="${fn:length(usagesBean.dependingBuildTypes) < usagesBean.dependenciesNumber}">You do not have enough permissions to view all of them.</c:if></div>

<c:if test="${not empty usagesBean.dependingBuildTypes}">
<ul class="menuList menuListWrappable">
<c:forEach items="${usagesBean.dependingBuildTypes}" var="bt">
  <authz:authorize allPermissions="EDIT_PROJECT" projectId="${bt.projectId}">
    <jsp:attribute name="ifAccessGranted">
      <c:set var="editLink"><admin:editBuildTypeLink buildTypeId="${bt.externalId}" step="${param['selectedStep']}" withoutLink="true"/></c:set>
      <l:li title="Edit build configuration"><a href="${editLink}" title="Edit build configuration"><c:out value="${bt.fullName}"/></a></l:li>
    </jsp:attribute>
    <jsp:attribute name="ifAccessDenied">
      <li><c:out value="${bt.fullName}"/></li>
    </jsp:attribute>
  </authz:authorize>
</c:forEach>
</ul>
</c:if>