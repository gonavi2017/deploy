<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%><%@
    taglib prefix="afn" uri="/WEB-INF/functions/authz"%><%@
    taglib prefix="bs" tagdir="/WEB-INF/tags"%><%@
    taglib prefix="forms" tagdir="/WEB-INF/tags/forms"%><%@
    taglib prefix="agent" tagdir="/WEB-INF/tags/agent"%><%@
    taglib prefix="util" uri="/WEB-INF/functions/util" %><%@
    taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@
    attribute name="project" required="true" type="jetbrains.buildServer.serverSide.SProject" %><%@
    attribute name="compatibilities" required="true" type="java.util.List" %><%@
    attribute name="selectedConfigurationsPolicy" required="true" type="java.lang.Boolean" %><%@
    attribute name="compatible" required="true" type="java.lang.Boolean"
    %><c:set var="id" value="expander_${project.projectId}_${compatible}"
/>${util:blockHiddenJs(pageContext.request, id, true)}
<div class="project-handle" id="header-${id}" data-blockId="${id}" data-collapsedByDefault="true">
<c:if test="${selectedConfigurationsPolicy}">
  <forms:checkbox
      custom="${true}"
      name="project-${compatible ? 'compatible' : 'incompatible'}"
      onclick="BS.AgentRunPolicy.selectProject(this.checked, '${project.projectId}')"
      disabled="${not afn:permissionGrantedGlobally('CHANGE_AGENT_RUN_CONFIGURATION_POLICY')
      and not afn:permissionGrantedForProject(project, 'CHANGE_AGENT_RUN_CONFIGURATION_POLICY_FOR_PROJECT')}"
      value=""/>
</c:if>
  <span class="buildTypeNameWithHandle">
    <bs:handle/>
    <bs:projectLinkFull project="${project}"><c:out value="${project.name}"/> (${fn:length(compatibilities)})</bs:projectLinkFull>
  </span>
</div>
<div class="content" id="content-${project.projectId}">
  <c:forEach items="${compatibilities}" var="compatibility">
    <%--@elvariable id="compatibility" type="jetbrains.buildServer.serverSide.AgentCompatibility"--%>
    <c:set var="buildType" value="${compatibility.buildType}"/>
    <div class="buildTypeCompatibility<c:if test="${not compatibility.active}"> inactive</c:if>" id="buildType:${buildType.buildTypeId}">
      <c:if test="${selectedConfigurationsPolicy}">
        <c:set var="name" value="canRun${compatible ? 'Compatible' : 'Incompatible'}${not compatibility.active ? 'Inactive' : ''}"/>
        <forms:checkbox
            custom="${true}"
            name="${name}"
            title="Turns on/off ability to run this build configuration"
            onclick="BS.AgentRunPolicy.selectBuildType(false, ${compatibility.active})"
            disabled="${not afn:permissionGrantedGlobally('CHANGE_AGENT_RUN_CONFIGURATION_POLICY')
            and not afn:permissionGrantedForProject(project, 'CHANGE_AGENT_RUN_CONFIGURATION_POLICY_FOR_PROJECT')}"
            value="${buildType.buildTypeId}"/>
      </c:if>
      <bs:buildTypeLink buildType="${buildType}"/>
      <c:if test="${not compatible}">
        <br/>
        <bs:agentCompatibility compatibility="${compatibility}"/>
      </c:if>
    </div>
  </c:forEach>
</div>
<script type="text/javascript">
  $j("#header-${id}").make_collapsable({registerForExpandAll: "all"});
</script>