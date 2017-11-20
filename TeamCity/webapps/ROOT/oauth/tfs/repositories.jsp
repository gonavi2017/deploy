<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/include-internal.jsp"%>
<%--@elvariable id="errorCode" type="java.lang.String"--%>
<%--@elvariable id="errorMessage" type="java.lang.String"--%>
<%--@elvariable id="oauthUsername" type="java.lang.String"--%>
<%--@elvariable id="isPermanentToken" type="java.lang.Boolean"--%>
<%--@elvariable id="serverSummary" type="jetbrains.buildServer.web.openapi.ServerSummary"--%>
<%--@elvariable id="repositories" type="java.util.List"--%>
<jsp:useBean id="oauthProvider" type="jetbrains.buildServer.serverSide.oauth.OAuthConnectionDescriptor" scope="request"/>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request"/>
<jsp:useBean id="showMode" type="java.lang.String" scope="request"/>
<c:set var="styles">
<bs:linkCSS>
  /css/forms.css
</bs:linkCSS>
<style type="text/css">
  #tfsRepositories {
    padding: 8px;
  }

  div.filter, div.reposCount {
    padding: 4px 4px 0px 4px;
  }

  div.inplaceFilterDiv {
    border: none;
  }

  ul.menuList {
    padding: 0px 4px 0 0;
    margin-left: 0;
  }

  ul.menuList li {
    list-style: none;
    padding: 4px;
    border-bottom: none;
  }

  ul.menuList li a {
    display: inline;
  }

  div.authenticated {
    margin: 25%;
    font-size: 120%;
  }

  ul.menuList span.useRepoProgress {
    display: none;
    float: none;
    margin-left: 0.5em;
  }

  .useRepoProgress i {
    float: none;
  }

  .cancelButton {
    margin-top: 2em;
  }
</style>
</c:set>
<c:choose>
  <c:when test="${errorCode == 'newTokenRequired'}">
    ${styles}
    <div>
      To show available repositories TeamCity requires access to your Visual Studio Team Services account.
      <br/>
      <br/>
      <c:set var="onclick">
        var win = BS.Util.popupWindow('${serverSummary.rootURL}/oauth/tfs/repositories.html?projectId=${project.externalId}&connectionId=${oauthProvider.id}&updateToken=true&showMode=${showMode}&userId=${currentUser.id}', 'repositories_${oauthProvider.id}');
        var interval = window.setInterval(function() {
          try {
            if (win == null || win.closed) {
              window.clearInterval(interval);
              window.TfsRepositoriesContentUpdater();
            }
          } catch (e) {
          }
        }, 1000);
      </c:set>
      <form id="signInButtons">
        <forms:button onclick="${onclick}" className="btn_primary submitButton">Sign in to Visual Studio Team Services</forms:button>
        <forms:button onclick="window.TfsRepositoriesContentUpdater()">Refresh</forms:button>
        <forms:progressRing style="display:none; float: none; margin-left: 0.5em;" id="refreshProgress"/>
      </form>
    </div>
    <c:if test="${showMode ne 'popup'}">
      <script type="text/javascript">
        window.TfsRepositoriesContentUpdater = function() {
          $j('#refreshProgress').show();
          $j('#signInButtons a').attr('disabled', true);
          if (refreshCurrentContainer) refreshCurrentContainer();
        }
      </script>
    </c:if>
  </c:when>
  <c:when test="${errorCode == 'requestFailed'}">
    ${styles}
    <span class="errorMessage" style="white-space:pre"><c:out value="${errorMessage}"/></span>
  </c:when>
  <c:when test="${errorCode == 'tokenObtained'}">
    <bs:externalPage>
      <jsp:attribute name="page_title">Visual Studio Team Services Authentication</jsp:attribute>
      <jsp:attribute name="head_include">
        ${styles}
        <script type="text/javascript">
          if (window.opener) {
            if (window.opener.TfsRepositoriesContentUpdater) {
              window.opener.TfsRepositoriesContentUpdater();
            }
            window.close();
          }
        </script>
      </jsp:attribute>
      <jsp:attribute name="body_include">
        <div class="authenticated">
          Authentication successful! Please close this window and click "Refresh" button.
        </div>
      </jsp:attribute>
    </bs:externalPage>
  </c:when>
  <c:otherwise>
    ${styles}
    <script type="text/javascript">
      BS.Tfs = {
        repositories: [],

        useRepository: function(repoId) {
          if ($j('#progress_' + repoId).is(":visible")) return; // double submit

          this.showProgress(repoId);

          var repo = this.repositories[repoId];
          <c:choose>
          <c:when test="${showMode == 'createProjectMenu'}">
          $j('#createFromUrlForm input[name=url]').val(repo.url);
          $j('#createFromUrlForm input[name=objectType]').val("PROJECT");
          return BS.CreateFromUrlForm.submit();
          </c:when>
          <c:when test="${showMode == 'createBuildTypeMenu'}">
          $j('#createFromUrlForm input[name=url]').val(repo.url);
          $j('#createFromUrlForm input[name=objectType]').val("BUILD_TYPE");
          return BS.CreateFromUrlForm.submit();
          </c:when>
          <c:otherwise>
          if (!window.repositoryCallback) {
            alert("function window.repositoryCallback is not defined");
            return;
          }

          if (repo != null) {
            var r = {
              repositoryUrl: repo.url,
              isPrivate: true,
              owner: repo.account,
              name: repo.project
            };
            var cre = {
              oauthLogin: '${oauthUsername}',
              oauthProviderId: '${oauthProvider.id}',
              permanentToken: ${isPermanentToken}
            };
            window.repositoryCallback(r, cre);

            BS.TfsRepositoriesPopup.hidePopup();
          }
          </c:otherwise>
          </c:choose>
        },

        showProgress: function(repoId) {
          $j('#progress_' + repoId).show();
        }
      };

      <c:forEach items="${repositories}" var="repo">
      BS.Tfs.repositories['${repo.id}'] = {
        type: '${repo.type}',
        account: '${repo.account}',
        project: '${repo.project}',
        url: '${repo.cloneUrl}'
      };
      </c:forEach>
    </script>

    <c:set var="reposNum" value="${fn:length(repositories)}"/>
    <c:set var="contId"><bs:id/></c:set>
    <div class="grayNote reposCount">Found <strong>${reposNum}</strong> <bs:plural txt="repository" val="${reposNum}"/></div>
    <c:if test="${reposNum > 10}">
    <div class="filter">
      <bs:inplaceFilter containerId="${contId}" activate="true" filterText="&lt;filter repositories>"/>
    </div>
    </c:if>
    <c:if test="${reposNum eq 0}">
      <div>There are no repositories found.</div>
    </c:if>
    <c:if test="${reposNum gt 0}">
    <ul id="${contId}" class="menuList">
      <c:forEach items="${repositories}" var="repo">
        <li class="inplaceFiltered" onclick="BS.Tfs.useRepository('${repo.id}')" title="Click to use this repository">
          <i class="repoStatus icon-lock ${repo.type}"></i>
          <c:out value="${repo.account}"/>/<c:out value="${repo.project}"/> (<c:out value="${repo.type}"/>)
          <span id="progress_${repo.id}" class="useRepoProgress"><forms:progressRing/> Verifying connection...</span>
        </li>
      </c:forEach>
    </ul>
    </c:if>
    <jsp:include page="/oauth/createObjectFromUrlOfflineForm.jsp"/>
  </c:otherwise>
</c:choose>
