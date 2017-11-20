<%@ include file="/include-internal.jsp"%>
<%@ page import="jetbrains.buildServer.web.openapi.PlaceId" %>
<%@ page import="jetbrains.buildServer.web.util.WebUtil" %>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<c:set var="cameFromUrl" value='<%=WebUtil.encode(request.getParameter("cameFromUrl"))%>'/>
<c:set var="title" value="${showMode == 'createProjectMenu' ? 'Create Project' : 'Create Build Configuration'}"/>

<bs:page disableScrollingRestore="true">
  <jsp:attribute name="page_title">${title}</jsp:attribute>
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/admin/adminMain.css
    </bs:linkCSS>
    <script type="text/javascript">
      <bs:trimWhitespace>
        <admin:projectPathJS startProject="${project}" startAdministration="${true}"/>

        BS.Navigation.items.push({
          title: '${title}',
          url: '${pageUrl}',
          selected: true
        });

      function toggleContainer(eventEl, url, staticContainerId) {
        var container = $j('.createFormContainer');

        if (url && url == container.data('url')) {
          return; // do not reload already opened option
        }

        if (url == null && staticContainerId != null) {
          url = '#' + staticContainerId;
        }

        if (url == null) {
          url = '';
        }


        $j('.createOption').removeClass('expanded');
        $j('.createOption').addClass('collapsed');

        if (url != '') {
          $j(eventEl).removeClass('collapsed');
          $j(eventEl).addClass('expanded');
        }
        container.data('url', url);

        if (url != '' && !url.startsWith('#')) {
          container.html('<span><i class="icon-refresh icon-spin progressRing progressRingDefault" style="float:none"></i> Loading...</span>');
          BS.ajaxUpdater(container[0], url, {method: 'get', evalScripts: true});
        } else {
          if (staticContainerId) {
            container.html($j('#' + staticContainerId).html());
          } else {
            container.html('');
          }
        }

        container.show(100);
      }

      function refreshCurrentContainer() {
        var container = $j('.createFormContainer');
        var url = container.data('url');

        $j(container).html('<span><i class="icon-refresh icon-spin progressRing progressRingDefault" style="float:none"></i> Loading...</span>');
        BS.ajaxUpdater($j(container)[0], url, {method: 'get', evalScripts: true});
      }

      $j(document).ready(function() {
        $j(".createOption").click(function() {
          var url = $j(this).data('url');
          var containerId = $j(this).data('content');

          if ($j(this).prevAll('a').length > 0 && url) {
            var extensionName = $j(this).prevAll('a')[0].name;
          }
          toggleContainer(this, url, containerId);

          if (extensionName) {
            BS.User.setProperty("lastSelectedCreateObjectOption", extensionName);
            document.location.hash = extensionName;
          }
        });


        var autoExpand = '<c:out value="${param['autoExpand']}"/>';
        if (!autoExpand) {
          autoExpand = "${ufn:getPropertyValue(currentUser, 'lastSelectedCreateObjectOption')}";
        }
        if (autoExpand
            && $j("a[name='" + autoExpand + "']").nextAll('.createOption')[0]
            && $j("a[name='" + autoExpand + "']").nextAll('.createOption').first().hasClass('readyToUseOption')) {
          $j("a[name='" + autoExpand + "']").nextAll('.createOption')[0].click();
        } else {
          if ($j(".createOption.preferableOption").length > 0) {
            $j(".createOption.preferableOption")[0].click();
          } else {
            $j("a[name='createManually']").nextAll('.createOption')[0].click();
          }
        }
      });
      </bs:trimWhitespace>
    </script>
    <style type="text/css">
      div.menuList {
        margin-left: -5px;
        width: 100%;
      }

      div.createOption {
        padding: 1em;
        vertical-align: top;

        border: 1px solid #ddd;

        display: inline-block;
        background-color: white;
        width: 21%;

        margin: .5em;
        cursor: pointer;
      }

      div.menuList h3 {
        font-size: 120%;
        color: #151515;
        padding: 5px 5px 5px 0;
        font-weight: normal;
        background-color: transparent;
        margin: 0;
        border-bottom: none;
      }

      .menuList.menuList_create {
        display: flex;
        flex-wrap: wrap;
        margin: 5px;
      }

      .menuList_create .createOption {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        flex-shrink: 0;

        text-align: center;
      }

      .ua-ie10-below .menuList_create .createOption {
        height: 4.5em;
      }

      div.menuList i.tc-icon {
        margin-right: 5px;
      }

      div.menuList .createOption:hover {
        background-color: #EBEDEF;
      }

      div.menuList .createOption.expanded {
        background-color: #EBEDEF;
        cursor: auto;
      }

      .createOption__second-line {
        padding: 5px 0;
      }

      .createFormContainer {
        margin-top: 2em;
      }

      .createFormContainer > div {
        border-top: 1px solid #ccc;
        padding-top: 1em;
      }
    </style>
  </jsp:attribute>
  <jsp:attribute name="body_include">
    <div class="menuList menuList_create">
      <c:choose>
        <c:when test="${showMode == 'createProjectMenu'}">
          <c:url value='/admin/createProject.html?init=1&parentId=${project.externalId}&embedded=true&cameFromUrl=${cameFromUrl}' var="createProjectUrl"/>
          <a name="createManually"></a>
          <div class="createOption readyToUseOption" data-url="${createProjectUrl}">
            <h3><i class="tc-icon icon-wrench"></i> Manually</h3>
          </div>

          <c:url value='/admin/createObjectFromUrl.html?init=1&objectType=PROJECT&parentId=${project.externalId}&embedded=true' var="createFromUrl"/>
          <a name="createFromUrl"></a>
          <div class="createOption readyToUseOption" data-url="${createFromUrl}">
            <h3>From a repository URL</h3>
          </div>
        </c:when>
        <c:otherwise>
          <c:set var="templateId" value=""/>
          <c:if test="${not empty param['templateId']}"><c:set var="templateId">&templateId=<c:out value="${param['templateId']}"/></c:set></c:if>
          <c:url value="/admin/createBuildType.html?projectId=${project.externalId}${templateId}&init=1&cameFromUrl=${cameFromUrl}" var="createUrl"/>
          <a name="createManually"></a>
          <div class="createOption readyToUseOption" data-url="${createUrl}">
            <h3><i class="tc-icon icon-wrench"></i> Manually</h3>
          </div>

          <c:url value='/admin/createObjectFromUrl.html?init=1&objectType=BUILD_TYPE&parentId=${project.externalId}&embedded=true' var="createFromUrl"/>
          <a name="createFromUrl"></a>
          <div class="createOption readyToUseOption" data-url="${createFromUrl}">
            <h3>From a repository URL</h3>
          </div>
        </c:otherwise>
      </c:choose>

      <ext:forEachExtension placeId="<%=PlaceId.ADMIN_LIST_REPOSITORIES%>">
        <a name="${extension.pluginName}"></a>
        <ext:includeExtension extension="${extension}"/>
      </ext:forEachExtension>
    </div>
    <div class="createFormContainer"></div>
  </jsp:attribute>
</bs:page>
