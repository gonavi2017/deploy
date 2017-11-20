<%@include file="/include-internal.jsp"%>
<%@ taglib prefix="admin" tagdir="/WEB-INF/tags/admin" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.diagnostic.web.DiagnosticPropertiesExtension.PropertiesBean"/>

<table class="runnerFormTable" id="internalProperties">
  <tr class="groupingTitle">
    <td>File properties (from <code>${propertiesBean.fullPathToPropertiesFile}</code>)</td>
  </tr>
  <tr>
    <td class="values">
      <admin:_propertiesList properties="${propertiesBean.internalProperties}"/>
      <c:url var="url" value="/admin/admin.html?item=diagnostics&tab=dataDir&file=config/internal.properties#edit!:config"/>
      <div style="margin-top: 0.5em">
        <a <c:if test="${not propertiesBean.internalPropertiesAvailable}">class="doCreateFile"</c:if> href="${url}"><i class="icon-pencil"></i> Edit internal properties &raquo;</a>
      </div>
    </td>
  </tr>
  <tr class="groupingTitle">
    <td>Java system properties</td>
  </tr>
  <tr>
    <td class="noBorder values">
      <admin:_propertiesList properties="${propertiesBean.relatedSystemProperties}"/>
      <div><a href="#" id="otherPropToggle">Show all properties</a></div>
      <admin:_propertiesList properties="${propertiesBean.otherSystemProperties}"
                             style="display: none"
                             id="otherProperties"/>
    </td>
  </tr>
</table>

<script type="text/javascript">
  $j(function() {
    var $doCreateFile = $j(".doCreateFile");
    if ($doCreateFile.length > 0) {
      var url = $doCreateFile.attr("href");
      $doCreateFile.attr("href", "#").on("click", function() {
        BS.ajaxRequest(window['base_uri'] + '/admin/ajax/internalProperties.html', {
          onComplete: function (transport) {
            if (transport.responseXML && transport.responseXML.firstChild) {
              var response = transport.responseXML.firstChild;
              var error = response.getElementsByTagName("error")[0];
              if (error) {
                alert("Cannot create internal.properties: " + error.firstChild.data);
              } else {
                window.location = url;
              }
            }
            return false;
          }
        });
      });
    }

    $j("#otherPropToggle").click(function() {
      $j("#otherProperties").toggle();
      $j(this).hide();
      return false;
    });
  });
</script>
