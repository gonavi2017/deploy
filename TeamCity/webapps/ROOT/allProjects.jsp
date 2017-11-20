<%@ include file="include-internal.jsp"
%><jsp:useBean id="allProjects" type="java.util.List" scope="request"
/><jsp:useBean id="allProjectsVisible" type="java.lang.Boolean" scope="request"
/><jsp:useBean id="sameLevelBuildTypes" type="java.util.List" scope="request"
/><jsp:useBean id="markedId" type="java.lang.String" scope="request"
/><jsp:useBean id="archivedProjects" type="java.util.List" scope="request"
/><jsp:useBean id="buildTypesMap" type="java.util.Map" scope="request"
/><jsp:useBean id="buildTypesVisibility" type="java.util.Map" scope="request"

/><c:set var="linkTitleText" value="Click to open the build configuration page"
/>
<bs:trimWhitespace>
<div class="projectsContainer">
  <c:if test="${empty allProjects and empty sameLevelBuildTypes}">
    There are no projects or build configurations.
  </c:if>

  <%--@elvariable id="projectUrlFormat" type="java.lang.String"--%>
  <%--@elvariable id="buildTypeUrlFormat" type="java.lang.String"--%>
  <c:if test="${not empty allProjects or not empty sameLevelBuildTypes}">
    <bs:inplaceFilter containerId="allProjectsPopupTable"
                      className="inplaceFilterProjects"
                      activate="true" initManually="${true}"
                      afterApplyFunc="function(filterField) {BS.AllProjectsPopup.searchBuildTypes(filterField); BS.AllProjectsPopup.globalInstance.updatePopup()}"
                      filterText="&lt;filter projects and build configurations>"/>
    <l:tableWithHighlighting highlightImmediately="true" id="allProjectsPopupTable" className="projectsPopupTable">
      <tbody>
        <c:forEach items="${sameLevelBuildTypes}" var="bt">
          <%--@elvariable id="bt" type="jetbrains.buildServer.serverSide.SBuildType"--%>
          <c:set var="btId" value="${bt.externalId}"/>
          <c:set var="trClass">inplaceFiltered inplaceFiltered_${btId} ${markedId == btId ? 'marked' : ''}</c:set>
          <tr class="${trClass}" data-filter-data="${btId}" data-title="<c:out value='${bt.name}'/>">
            <td class="projectName highlight" title="<c:out value='${bt.description}'/>">
              <c:url var="btUrl" value="/viewType.html?buildTypeId=${bt.externalId}"/>
              <c:if test="${not empty buildTypeUrlFormat}">
                <c:set var="btUrl" value="${fn:replace(buildTypeUrlFormat, '{id}', bt.externalId)}"/>
              </c:if>
              <a href="${btUrl}" class="tc-icon_before icon16 projectLink buildType-icon"><c:out value="${bt.name}"/></a>
            </td>
            <td class="highlight pin"></td>
            <td class="highlight bt"></td>
          </tr>
        </c:forEach>
        <c:forEach items="${allProjects}" var="bean">
          <c:set var="project" value="${bean.project}"/>
          <%--@elvariable id="project" type="jetbrains.buildServer.serverSide.SProject"--%>
          <c:set var="projectId" value="${project.projectId}"/>
          <c:set var="externalId" value="${project.externalId}"/>
          <c:set var="trClass">inplaceFiltered inplaceFiltered_${projectId}</c:set>
          <c:set var="trClass">${trClass} ${bean.visible && !allProjectsVisible && empty markedId ? 'visibleProject' : ''}</c:set>
          <c:set var="trClass">${trClass} ${markedId == externalId ? 'marked' : ''}</c:set>
          <tr class="${trClass}" data-filter-data="${projectId}" data-title="<c:out value='${project.fullName}'/>" data-depth="${bean.depth}"  id="inplaceFiltered_${projectId}">
            <td class="projectName highlight depth-${bean.depth <= 10 ? bean.depth : 10}" title="<c:out value='${project.description}'/>">
              <c:set var="projectUrl"><bs:projectUrl projectId="${externalId}"/></c:set>
              <c:if test="${not empty projectUrlFormat}">
                <c:set var="projectUrl" value="${fn:replace(projectUrlFormat, '{id}', externalId)}"/>
              </c:if>
              <a href="${projectUrl}" class="tc-icon_before icon16 projectLink projectIcon project-icon" title="Open project page" showdiscardchangesmessage="false">
                <c:out value="${project.name}"/>
              </a>
              <c:if test="${project.archived}"><i style="color: #888">archived</i></c:if>   <%-- It is possible in rare cases: TW-26095 --%>
            </td>
            <td class="highlight pin">
              <c:if test="${!isSpecialUser && empty markedId && !project.archived}">
                <authz:authorize allPermissions="CHANGE_OWN_PROFILE">
                  <a class="${bean.visible ? '' : 'pinLink'}" href="#"
                     onclick="return BS.TogglePopup.toggleOverview(this, '${projectId}');">
                    <i class="icon icon16 icon16_watched  ${bean.visible ? '' : 'icon16_watched_no'}"
                       title="${bean.visible ? 'Project is shown on the overview page. Click to hide'
                          : 'Click to show project on the overview page'}"></i>
                  </a>
                </authz:authorize>
              </c:if>
            </td>
            <td class="highlight bt">
              <c:set var="buildTypes" value="${project.ownBuildTypes}"/>
              <c:if test="${not empty buildTypes}">
                <bs:popupControl showPopupCommand="" hidePopupCommand="" stopHidingPopupCommand=""
                                 controlId="buildTypesPopup${projectId}"
                                 type="right"><span class="btCount">${fn:length(buildTypes)}</span></bs:popupControl>
              </c:if>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </l:tableWithHighlighting>

    <c:if test="${not empty buildTypeUrlFormat}"><span id="buildTypeUrlFormat" url="${buildTypeUrlFormat}"></span></c:if>

    <script type="text/javascript">
        (function() {
          var init = BS.InPlaceFilter.getStoredInitFunction('allProjectsPopupTable'),
            tmp;
          init && init();


          <c:forEach items="${buildTypesMap}" var="entry">
            <c:set var="project" value="${entry.key}"/>
            <c:set var="buildTypes" value="${entry.value}"/>
            BS.projectMap['${project.projectId}'] = [];
            tmp = BS.projectMap['${project.projectId}'];
            tmp.parentProjectId = '${project.parentProject.projectId}';
            <c:forEach items="${buildTypes}" var="buildType">
              tmp.push({
                id: '${buildType.buildTypeId}',
                extId: '${buildType.externalId}',
                projectName: '<bs:escapeForJs text="${project.name}" forHTMLAttribute="true"/>',
                name: '<bs:escapeForJs text="${buildType.name}" forHTMLAttribute="true"/>',
                description: '<bs:escapeForJs text="${buildType.description}" forHTMLAttribute="true"/>',
                visible: ${buildTypesVisibility[buildType] ? 1 : 0}
              });
            </c:forEach>
          </c:forEach>

          BS.AllProjectsPopup.Navigation.init();
        })();
    </script>
  </c:if>

  <c:if test="${not empty archivedProjects}">
    <bs:archivedProjectsPopup archivedProjects="${archivedProjects}"/>
  </c:if>

  <bs:webComponentsSettings/>
</div>
</bs:trimWhitespace>




