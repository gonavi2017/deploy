<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="currentDefaultVersion" type="jetbrains.buildServer.tools.ToolVersion" scope="request" />
<jsp:useBean id="newDefaultVersion" type="jetbrains.buildServer.tools.ToolVersion" scope="request" />
<jsp:useBean id="affectedConfigurationsCount" type="java.lang.Integer" scope="request" />
<jsp:useBean id="currentDefaultUsages" type="java.util.Collection<jetbrains.buildServer.tools.usage.DefaultToolVersionInProjectUsage>" scope="request"/>

<c:choose>
  <c:when test="${affectedConfigurationsCount == 0}">
    No affected build configurations found.
    <br/>Default version can be changed safely.
  </c:when>
  <c:otherwise>
    <c:if test="${not empty currentDefaultUsages}">
      <c:set var="defaultUsagesCount" value="${fn:length(currentDefaultUsages)}"/>
      <div class="btUsages">
        <div>
          Changing default version will affect <strong>${affectedConfigurationsCount}</strong> <bs:plural txt="build configuration" val="${affectedConfigurationsCount}" />.
        </div>
        <ul class="btUsages__list">
          <c:forEach items="${currentDefaultUsages}" var="btUsage" varStatus="pos">
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