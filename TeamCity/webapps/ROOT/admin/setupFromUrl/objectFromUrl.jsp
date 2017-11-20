<%@ page import="jetbrains.buildServer.serverSide.crypt.RSACipher" %>
<%@include file="/include-internal.jsp"%>
<jsp:useBean id="createFromUrlBean" type="jetbrains.buildServer.controllers.admin.projects.setupFromUrl.CreateFromUrlBean" scope="request"/>
<c:set var="parentProject" value="${createFromUrlBean.parentProject}"/>
<c:set var="title" value="${createFromUrlBean.objectType == 'PROJECT' ? 'Create Project From URL' : 'Create Build Configuration From URL'}"/>
<c:set var="formContent">
  <script type="text/javascript">
    BS.CreateFromUrlForm = OO.extend(BS.AbstractPasswordForm, {
      formElement: function() {
        return $('createFromUrlForm');
      },

      submit: function() {
        var that = this;
        $('password').enable();
        BS.PasswordFormSaver.save(this, this.formElement().action, OO.extend(BS.ErrorsAwareListener, {
          parentId: function(elem) {
            $j('#error_parentId').text(elem.firstChild.nodeValue);
            that.highlightErrorField($("parentId"));
          },

          url: function(elem) {
            $j('#error_url').text(elem.firstChild.nodeValue);
            that.highlightErrorField($("url"));
          },

          onSuccessfulSave : function(responseXML) {
            BS.XMLResponse.processRedirect(responseXML);
          }
        }));

        return false;
      }
    });
  </script>
  <bs:linkCSS>
    /css/admin/adminMain.css
  </bs:linkCSS>
  <style type="text/css">
    span.error {
      white-space: pre-wrap;
    }
  </style>
  <div id="container" class="clearfix" style="width:70%;">
    <form id="createFromUrlForm" action="<c:url value='/admin/createObjectFromUrl.html'/>" method="post" onsubmit="return BS.CreateFromUrlForm.submit()">
      <table class="runnerFormTable">
        <tr>
          <th><label for="parentId">Parent project: <l:star/></label></th>
          <td>
            <bs:projectsFilter name="parentId" id="parentId" className="longField"
                               projectBeans="${createFromUrlBean.availableParents}"
                               selectedProjectExternalId="${createFromUrlBean.parentId}"
                               disableRoot="${createFromUrlBean.objectType == 'BUILD_TYPE'}"/>
            <span class="error" id="error_parentId"></span>
          </td>
        </tr>
        <tr>
          <th>
            <label for="url"><strong>Repository URL: <l:star/></strong></label>
          </th>
          <td>
            <forms:textField name="url" maxlength="256" className="longField" style="width: 40em;" value="${createFromUrlBean.url}"/>
            <jsp:include page="/admin/repositoryControls.html?projectId=${parentProject.externalId}"/>
          <span class="smallNote">A VCS repository URL. Supported formats: <strong>http(s)://, svn://, git://</strong>, etc. as well as URLs in Maven format.
            <bs:help file="Guess+Settings+from+Repository+URL"/></span>
            <span class="error" id="error_url"></span>
          </td>
        </tr>
        <tr>
          <th>
            <label for="username"><strong>Username: </strong></label>
          </th>
          <td>
            <forms:textField name="username" maxlength="80" style="width: 20em;" value="${createFromUrlBean.username}"/>
            <span class="error" id="error_username"></span>
            <span class="smallNote">Provide username if access to repository requires authentication.</span>
          </td>
        </tr>
        <tr>
          <th>
            <label for="password"><strong>Password: </strong></label>
          </th>
          <td>
            <forms:passwordField name="password" maxlength="80" style="width: 20em;"/>
            <span class="error" id="error_password"></span>
            <span class="smallNote">Provide password if access to repository requires authentication.</span>
          </td>
        </tr>
      </table>

      <div class="saveButtonsBlock">
        <forms:submit name="createProjectFromUrl" label="Proceed"/>
        <c:if test="${not embedded}"><forms:cancel cameFromSupport="${createFromUrlBean.cameFromSupport}"/></c:if>
        <forms:saving/>

        <input type="hidden" name="objectType" value="${createFromUrlBean.objectType}"/>
        <input type="hidden" name="oauthProviderId" id="oauthProviderId" value=""/>
        <input type="hidden" name="publicKey" id="publicKey" value="<c:out value='<%=RSACipher.getHexEncodedPublicKey()%>'/>"/>
        <input type="hidden" name="cameFromUrl" value=""/>
      </div>
    </form>
  </div>
  <script type="text/javascript">
    if (BS.Repositories != null) {
      BS.Repositories.installControls($('url'), function(repoInfo, cre) {
        $('url').value = repoInfo.repositoryUrl;
        var prefillPassword = cre != null && cre.permanentToken;

        if (cre != null) {
          $('username').value = cre.oauthLogin;
          $('oauthProviderId').value = cre.oauthProviderId;
        }

        if (prefillPassword) {
          $('password').value = '**********';
        }
      });
    }

    <c:forEach items="${createFromUrlBean.lastErrors.errors}" var="error">
    $j('#error_${error.id}').text('<bs:escapeForJs text="${error.message}"/>');
    </c:forEach>

    $('url').focus();
    $('createFromUrlForm').cameFromUrl.value = document.location.href.replace(/cameFromUrl=.*/, '');
  </script>
</c:set>

<c:choose>
  <c:when test="${not embedded}">
    <bs:page disableScrollingRestore="true">
      <jsp:attribute name="page_title">${title}</jsp:attribute>
      <jsp:attribute name="head_include">
        <script type="text/javascript">
          <admin:projectPathJS startProject="${parentProject}" startAdministration="${true}"/>

          BS.Navigation.items.push({
            title: '${title}',
            url: '${pageUrl}',
            selected: true
          });
        </script>
      </jsp:attribute>
      <jsp:attribute name="body_include">
        ${formContent}
      </jsp:attribute>
    </bs:page>
  </c:when>
  <c:otherwise>
    ${formContent}
  </c:otherwise>
</c:choose>
