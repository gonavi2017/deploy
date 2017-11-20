<%@ include file="/include-internal.jsp" %>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.EditableBuildTypeSettingsForm" scope="request"/>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.admin.projects.EditableUserDefinedParametersBean" scope="request"/>
<admin:editBuildTypePage selectedStep="buildParams">
  <jsp:attribute name="head_include">
    <bs:linkCSS>
      /css/settingsTable.css
      /css/admin/editUserParams.css
    </bs:linkCSS>
  </jsp:attribute>
  <jsp:attribute name="body_include">

    <c:url value="/admin/editBuildParams.html?id=${buildForm.settingsId}" var="actionUrl"/>
    <c:url value="/admin/parameterAutocompletion.html?settingsId=${buildForm.settingsId}" var="autocompletionUrl"/>
    <admin:userDefinedParameters userParametersBean="${propertiesBean}" parametersActionUrl="${actionUrl}" parametersAutocompletionUrl="${autocompletionUrl}" readOnly="${buildForm.readOnly}" externalId="${buildForm.externalId}"/>

    <script type="text/javascript">
      (function($) {
        $(document).ready(function() {
          if (document.location.hash.indexOf('edit_') != -1) {
            var selector = document.location.hash;
            $(selector).triggerHandler("click");
            document.location.hash = "";
          }
        });
      }(jQuery));
    </script>
  </jsp:attribute>
</admin:editBuildTypePage>
