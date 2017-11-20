<%@ include file="/include-internal.jsp" %>
<jsp:useBean id="toolVersion" type="jetbrains.buildServer.tools.ToolVersion" scope="request" />
<jsp:useBean id="affectedConfigurationsCount" type="java.lang.Integer" scope="request" />
<jsp:useBean id="explicitUsages" type="java.util.Collection<jetbrains.buildServer.tools.usage.BuildTypeExplicitUsage>" scope="request"/>
<jsp:useBean id="defaultUsages" type="java.util.Collection<jetbrains.buildServer.tools.usage.DefaultToolVersionInProjectUsage>" scope="request"/>

<c:choose>
  <c:when test="${affectedConfigurationsCount == 0}">
    No affected build configurations found. Tool version can be safely removed.
  </c:when>
  <c:otherwise>
    Removing of this tool will affect <strong>${affectedConfigurationsCount}</strong> <bs:plural txt="build configuration" val="${affectedConfigurationsCount}" />.
    <c:if test="${not empty explicitUsages}">
      <c:set var="explicitUsagesCount" value="${fn:length(explicitUsages)}"/>
      <div class="btUsages">
        <div>
          Tools is used as a <b>concrete</b> version in <b>${explicitUsagesCount}</b> build configuration<bs:s val="${explicitUsagesCount}"/>:
        </div>
        <ul class="btUsages__list">
          <c:forEach items="${explicitUsages}" var="btUsage" varStatus="pos">
            <c:set var="btSettings" value="${btUsage.buildType}"/>
            <li>
              <span class="buildConfigurationLink">
                <c:set var="canEdit" value="${afn:permissionGrantedForBuildType(btSettings, 'EDIT_PROJECT') and (not btSettings.templateBased or btSettings.templateAccessible)}"/>
                <c:choose>
                  <c:when test="${canEdit}">
                    <admin:editBuildTypeLinkFull buildType="${btSettings}"/>
                  </c:when>
                  <c:otherwise><c:out value="${btSettings.fullName}"/></c:otherwise>
                </c:choose>
              </span>
            </li>
          </c:forEach>
        </ul>
      </div>
    </c:if>
    <c:if test="${not empty defaultUsages}">
      <c:set var="defaultUsagesCount" value="${fn:length(defaultUsages)}"/>
      <div class="btUsages">
        <div>
          Tools is used as a <b>default</b> version in <b>${defaultUsagesCount}</b> build configuration<bs:s val="${defaultUsagesCount}"/>:
        </div>
        <ul class="btUsages__list">
          <c:forEach items="${defaultUsages}" var="btUsage" varStatus="pos">
            <c:set var="btSettings" value="${btUsage.buildType}"/>
            <li>
              <span class="buildConfigurationLink">
                <c:set var="canEdit" value="${afn:permissionGrantedForBuildType(btSettings, 'EDIT_PROJECT') and (not btSettings.templateBased or btSettings.templateAccessible)}"/>
                <c:choose>
                  <c:when test="${canEdit}">
                    <admin:editBuildTypeLinkFull buildType="${btSettings}"/>
                  </c:when>
                  <c:otherwise><c:out value="${btSettings.fullName}"/></c:otherwise>
                </c:choose>
              </span>
            </li>
          </c:forEach>
        </ul>
      </div>
    </c:if>
  </c:otherwise>
</c:choose>