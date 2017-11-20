<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="util" uri="/WEB-INF/functions/util" %>
<%@
attribute name="containerId" required="true" type="java.lang.String"%><%@
attribute name="buildTypesHierarchy" required="true" type="java.util.List"%><%@
attribute name="selectedBuildTypesMap" required="true" type="java.util.Map"%><%@
attribute name="selectedProjects" required="false" type="java.util.Set<jetbrains.buildServer.serverSide.SProject>"%><%@
attribute name="projectsOnly" required="false" type="java.lang.Boolean"%><%@
attribute name="disableChildren" required="false" type="java.lang.Boolean"%><%@
attribute name="includeRootProject" required="false" type="java.lang.Boolean"%><%@
attribute name="rootProjectSelected" required="false" type="java.lang.Boolean"%><%@
attribute name="onChange_function_body" required="false"  fragment="true" %><%@
attribute name="additional_body" required="false"  fragment="true"%><%@
attribute name="projectDisplay" required="false" fragment="true"%><%@
attribute name="buildTypeDisplay" required="false" fragment="true"%>
<%@variable name-given="project" variable-class="jetbrains.buildServer.serverSide.SProject" %>
<%@variable name-given="buildType" variable-class="jetbrains.buildServer.serverSide.SBuildType" %>

<c:set var="selectedParentDepth" value="${-1}"/>
<c:set var="addDepth" value="${includeRootProject ? 1 : 0}"/>
<div class="configurationSelector">
  <bs:inplaceFilter containerId="${containerId}" activate="true" filterText="&lt;filter build configurations>"
                    afterApplyFunc="function(filterField) { BS.MultiSelect.update('#${containerId}', filterField); }"/>
  <div id="${containerId}" class="multi-select" style="height: 20em;">
    <c:if test="${includeRootProject}">
      <div <c:if test="${disableChildren}">data-disable-children="true"</c:if> class="inplaceFiltered user-depth-0 disabled group" data-depth="0">
        <label>
          <c:if test="${selectedProjects != null && rootProjectSelected}">
            <c:set var="selectedParentDepth" value="${0}"/>
          </c:if>
          <input type="checkbox" name="projectId" value="_Root" <c:if test="${rootProjectSelected}">checked="checked"</c:if> class="group"><c:out value="<Root project>"/>
        </label>
      </div>
    </c:if>
    <c:forEach items="${buildTypesHierarchy}" var="bean">
      <%--@elvariable id="bean" type="jetbrains.buildServer.web.util.BuildTypesHierarchyBean"--%>
      <c:set var="project" value="${bean.project}"/>
      <c:if test="${bean.limitedDepth + addDepth <= selectedParentDepth}">
        <c:set var="selectedParentDepth" value="${-1}"/>
      </c:if>
      <c:if test="${selectedProjects != null && util:contains(selectedProjects, project) && selectedParentDepth == -1}">
        <c:set var="selectedParentDepth" value="${bean.limitedDepth + addDepth}"/>
      </c:if>
      <div <c:if test="${disableChildren}">data-disable-children="true"</c:if> class="inplaceFiltered user-depth-${bean.limitedDepth + addDepth} disabled group" data-depth="${bean.limitedDepth + addDepth}">
        <label>
          <input type="checkbox" <c:if test="${selectedParentDepth != -1 && selectedParentDepth < bean.limitedDepth + addDepth && disableChildren}">disabled</c:if> name="projectId" value="${project.externalId}" <c:if test="${selectedParentDepth != -1}">checked="checked"</c:if> class="group">
          <c:choose>
            <c:when test="${not empty projectDisplay}">
              <jsp:invoke fragment="projectDisplay"/>
            </c:when>
            <c:otherwise><c:out value="${project.name}"/> <c:if test="${project.archived}">(archived)</c:if></c:otherwise>
          </c:choose>
        </label>
      </div>
      <c:if test="${not projectsOnly}">
        <c:forEach var="buildType" items="${bean.buildTypes}"
            ><div class="inplaceFiltered user-depth-${bean.limitedDepth + addDepth + 1}" data-title="<c:out value='${buildType.fullName}'/>" data-depth="${bean.limitedDepth + addDepth + 1}">
            <label>
              <input type="checkbox" name="buildTypeId" <c:if test="${selectedParentDepth != -1 && disableChildren}">disabled</c:if> value="${buildType.externalId}" <c:if test="${selectedParentDepth != -1 || selectedBuildTypesMap[buildType.externalId]}">checked="checked"</c:if> >
              <c:choose>
                <c:when test="${not empty buildTypeDisplay}">
                  <jsp:invoke fragment="buildTypeDisplay"/>
                </c:when>
                <c:otherwise><c:out value="${buildType.name}"/></c:otherwise>
              </c:choose>
            </label>
        </div>
        </c:forEach>
      </c:if>
    </c:forEach>
  </div>
  <script>
    BS.MultiSelect.init("#${containerId}", function(evt) {
      <jsp:invoke fragment="onChange_function_body"/>
    });
  </script>
  <jsp:invoke fragment="additional_body"/>
</div>