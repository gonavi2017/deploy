<%@ include file="include-internal.jsp"
%><jsp:useBean id="bean" type="jetbrains.buildServer.controllers.quickNav.QuickNavigationBean" scope="request"
/>
<div class="projectsContainer">
  <c:choose>
    <c:when test="${empty bean.projects}">
      There are no projects or build configurations.
    </c:when>
    <c:otherwise>
      <bs:inplaceFilter containerId="quickNavList"
                        activate="true"
                        afterApplyFunc="function(field) {BS.QuickNavigation.applyFilter(field);}"
                        filterText="&lt;Quick navigation to projects and build configurations&gt;"/>
      <div id="no-results">
        No projects or build configurations match the filter
      </div>

      <div class="all-filtered" id="quickNavList">
        <div class="project divider">Projects</div>
        <c:forEach items="${bean.projects}" var="project">
          <bs:_quickNavEntry idPrefix="all-p" entry="${project}"/>
        </c:forEach>

        <div class="build-type divider">Build configurations</div>
        <c:forEach items="${bean.buildTypes}" var="bt">
          <bs:_quickNavEntry idPrefix="all-bt" entry="${bt}"/>
        </c:forEach>
      </div>

      <div id="not-all-results">
        First 15 results are found. <input type="button" class="btn btn_mini" value="Find all"
                                           onclick="BS.QuickNavigation.applyFilter(null, true);"></input>
      </div>

      <script type="text/javascript">
        <bs:trimWhitespace>
            (function() {
              var quickNavigation = BS.QuickNavigation,
                  items = quickNavigation._items = [];

              <c:forEach items="${bean.projects}" var="project">
                items.push({
                  id: 'all-p-${project.id}',
                  type: 'p',
                  name: '<c:out value="${project.name}"/>'
                });
              </c:forEach>
              <c:forEach items="${bean.buildTypes}" var="bt">
                items.push({
                  id: 'all-bt-${bt.id}',
                  type: 'bt',
                  name: '<c:out value="${bt.name}"/>'
                });
              </c:forEach>

              quickNavigation.setUp();
            })();
        </bs:trimWhitespace>
      </script>
    </c:otherwise>
  </c:choose>
</div>
