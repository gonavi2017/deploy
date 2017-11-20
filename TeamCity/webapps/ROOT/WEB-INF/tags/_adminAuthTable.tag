<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="l" tagdir="/WEB-INF/tags/layout"%><%@
    taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %><%@
    attribute name="authModules" type="java.util.List" required="true" %><%@
    attribute name="advancedView" type="java.lang.Boolean" required="true" %><%@
    attribute name="canRemove" type="java.lang.Boolean" required="true" %>
<l:tableWithHighlighting highlightImmediately="true" className="parametersTable">
  <tr>
    <th style="width: 30%;">Type</th>
    <th colspan="${advancedView ? 3 : 2}">Description</th>
  </tr>
  <c:forEach var="module" items="${authModules}">
    <%--@elvariable id="module" type="jetbrains.buildServer.serverSide.auth.AuthModule"--%>
    <c:set var="editable" value="${not empty module.type.editPropertiesJspFilePath}"/>
    <c:set var="onclick"><c:if test="${editable}">onclick="return BS.AdminAuthEditDialog.showEdit(${module.id});"</c:if></c:set>
    <c:set var="highlight"><c:if test="${editable}">highlight</c:if></c:set>
    <tr>
      <td class="${highlight}" ${onclick}>
        <c:out value="${module.type.displayName}"/>
      </td>
      <td class="${highlight}" ${onclick}>
        <span class="grayNote"><c:out value="${module.type.description}"/></span>
        <br>
        <admin:authModulePropertiesDescription authModule="${module}"/>
      </td>
      <td class="${highlight} edit" ${onclick}>
        <c:if test="${editable}"><a href="#" ${onclick}>Edit</a></c:if>
        <c:if test="${!editable}"><span class="inheritedParam">no options</span></c:if>
      </td>
      <c:if test="${advancedView}">
        <td class="edit">
          <c:choose>
            <c:when test="${canRemove}"><a href="#" onclick="return BS.AdminAuth.remove(${module.id});">Delete</a></c:when>
            <c:otherwise><span title="Last login module cannot be deleted">Delete</span></c:otherwise>
          </c:choose>
        </td>
      </c:if>
    </tr>
  </c:forEach>
</l:tableWithHighlighting>