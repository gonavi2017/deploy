<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="versionRunnerParameterName" scope="request" type="java.lang.String"/>

<jsp:useBean id="selectedVersion" scope="request" type="jetbrains.buildServer.tools.ToolVersionReference"/>
<jsp:useBean id="availableVersions" scope="request" type="java.util.Collection<jetbrains.buildServer.tools.ToolVersionReference>"/>

<jsp:useBean id="toolCustomPath" scope="request" type="java.lang.String"/>
<jsp:useBean id="defaultVersionSpecified" scope="request" type="java.lang.Boolean"/>

<jsp:useBean id="clazz" scope="request" type="java.lang.String"/>
<jsp:useBean id="style" scope="request" type="java.lang.String"/>

<jsp:useBean id="toolType" scope="request" type="jetbrains.buildServer.tools.ToolType"/>
<jsp:useBean id="settingsUrl" scope="request" type="java.lang.String"/>

<script type="text/javascript">
  if (!BS) BS = {};

  if (!BS.Tools) BS.Tools = {
    selectors : new Array(),

    getVersionSelector: function(toolType){
      var result = $j.grep(this.selectors, function(e){ return e.toolType == toolType; });

      function VersionSelector(toolType) {
        this.toolType = toolType,

            this.init = function (fieldName, customPath) {
              this.hiddenFieldName = fieldName;
              this.toolCustomPath = customPath;
              this.customPathContainer = $('customPathContainer' + toolType);
              this.toolPathSelector = $('toolPathSelector' + toolType);
              this.customPathTextField = $('toolCustomPath' + toolType);
            },

            this.setValue = function (x) {
              $(this.hiddenFieldName).value = x;
            },

            this.getValue = function () {
              return $(this.hiddenFieldName).value;
            },

            this.selectionChanged = function () {
              var selectedValue = this.toolPathSelector.value;
              if (selectedValue == "custom") {
                this.customPathTextField.value = this.toolCustomPath;
                this.customPathChanged();
                BS.Util.show(this.customPathContainer);
              } else {
                this.setValue(selectedValue);
                BS.Util.hide(this.customPathContainer);
              }
              BS.MultilineProperties.updateVisible();
            },

            this.customPathChanged = function () {
              var versionCustomValue = this.customPathTextField.value;
              this.setValue(versionCustomValue);
              this.toolCustomPath = versionCustomValue;
            }
      }

      if (result.length == 0) {
        var newSelector = new VersionSelector(toolType);
        this.selectors.push(newSelector);
        return newSelector;
      }
      return result[0];
    }
  };
</script>

<props:hiddenProperty name="${versionRunnerParameterName}" value="${selectedVersion.reference}"/>

<forms:select name="toolPathSelector${toolType.type}" className="${clazz}" style="padding:0; margin:0; ${style}" onchange="BS.Tools.getVersionSelector('${toolType.type}').selectionChanged();">
  <c:if test="${!defaultVersionSpecified}">
    <props:option value="" selected="${selectedVersion != null}">-- Select ${toolType.displayName} version to run --</props:option>
  </c:if>
  <c:forEach var="availableVersion" items="${availableVersions}">
    <props:option value="${availableVersion.reference}" selected="${availableVersion eq selectedVersion}"><c:out value="${availableVersion.displayName}"/></props:option>
  </c:forEach>
</forms:select>

<span class="smallNote">Check installed ${toolType.displayName} versions in <a href="<c:url value="${settingsUrl}"/>" target="_blank">${toolType.displayName} Tool Configuration</a></span>

<div id="customPathContainer${toolType.type}">
  <forms:textField name="toolCustomPath${toolType.type}" className="${clazz}" style="${style}" onchange="BS.Tools.getVersionSelector('${toolType.type}').customPathChanged();"/>
  <span class="smallNote">
    Specify a custom path to ${toolType.targetFileDisplayName}. Paths relative to the checkout directory are supported.
  </span>

</div>
<span class="error" id="error_${versionRunnerParameterName}"></span>

<script type="text/javascript">
  var versionSelector = BS.Tools.getVersionSelector('${toolType.type}');
  versionSelector.init('${versionRunnerParameterName}', '<bs:forJs>${toolCustomPath}</bs:forJs>');
  versionSelector.selectionChanged();
</script>
