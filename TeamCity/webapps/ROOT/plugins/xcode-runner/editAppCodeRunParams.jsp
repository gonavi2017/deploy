<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="buildForm" type="jetbrains.buildServer.controllers.admin.projects.BuildTypeForm" scope="request"/>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="appleData" scope="request" type="jetbrains.buildServer.runner.appCode.data.AppleData"/>
<jsp:useBean id="hasProjectData" scope="request" type="java.lang.Boolean"/>
<jsp:useBean id="hasError" scope="request" type="java.lang.Boolean"/>

<c:if test="${hasProjectData}">
  <jsp:useBean id="projectData" scope="request" type="jetbrains.buildServer.runner.appCode.data.ProjectData"/>
</c:if>

<script type="text/javascript">
  BS.AppCodeRunParams = {
    _sdks: [],
    _archs: [],
    _selectedPlatformIndex: -1,
    _selectedSdkByPlatformIndex: {},
    _selectedArchByPlatformIndex: {},
    _configs: [],
    _selectedTargetIndex: -1,
    _selectedConfigByTargetIndex: {},
    _optionTemplate: '<option value="ID">NAME</option>',

    changeXcode: function() {
      var xcode3 = $("xcode").selectedIndex == 0;
      $j(".xcode3").each(function() {
        (xcode3 ? BS.Util.show : BS.Util.hide)(this);
      });
      $j(".xcode4").each(function() {
        (xcode3 ? BS.Util.hide : BS.Util.show)(this);
      });
      BS.VisibilityHandlers.updateVisibility($('mainContent'));
      $j('select#' + (xcode3 ? 'target' : 'scheme')).focus(); // hidden input throw errors in IE 8- when focusing on 'em
    },

    _updateBoldValues: function(gray) {
      $j(".boldValue").each(function() {
        $j(this)[gray ? "addClass" : "removeClass"]("gray");
      });
    },

    onPlatformChanged: function() {
      var oldPlatformIndex = this._selectedPlatformIndex;
      var newPlatformIndex = $("platform").selectedIndex;
      this._selectedPlatformIndex = newPlatformIndex;
      if (oldPlatformIndex != 0) {
        this._selectedSdkByPlatformIndex[oldPlatformIndex] = $("sdk").selectedIndex;
        this._selectedArchByPlatformIndex[oldPlatformIndex] = $("arch").selectedIndex;
      }
      $("sdk").innerHTML = $("arch").innerHTML = "";
      this._appendOptions($j("#sdk"), this._sdks[newPlatformIndex]);
      this._appendOptions($j("#arch"), this._archs[newPlatformIndex]);
      $("sdk").selectedIndex = this._selectedSdkByPlatformIndex[newPlatformIndex] || 0;
      $("arch").selectedIndex = this._selectedArchByPlatformIndex[newPlatformIndex] || 0;
      $("sdk").disabled = $("arch").disabled = newPlatformIndex == 0;
    },

    onTargetChanged: function() {
      var oldTargetIndex = this._selectedTargetIndex;
      var newTargetIndex = $("target").selectedIndex;
      this._selectedTargetIndex = newTargetIndex;
      if (oldTargetIndex != 0) {
        this._selectedConfigByTargetIndex[oldTargetIndex] = $("configuration").selectedIndex;
      }
      $("configuration").innerHTML = "";
      this._appendOptions($j("#configuration"), this._configs[newTargetIndex]);
      $("configuration").selectedIndex = this._selectedConfigByTargetIndex[newTargetIndex] || 0;
      $("configuration").disabled = newTargetIndex == 0;
    },

    onUseCustomBuildOutputDirChecked: function() {
      var useCustomBuildOutputDir = $("useCustomBuildOutputDir").checked;
      $("customBuildOutputDir").disabled = !useCustomBuildOutputDir;
      BS.VisibilityHandlers.updateVisibility($('mainContent'));
      if (useCustomBuildOutputDir) {
        $("customBuildOutputDir").focus();
      }
    },

    reparseProject: function() {
      var form = BS.EditBuildRunnerForm.formElement() ? BS.EditBuildRunnerForm : BS.CreateBuildTypeForm;

      BS.Util.show("reparseProjectProgress");
      if (form) {
        form.disable();
        BS.AppCodeRunParams._updateBoldValues(true);
      }

      var count = 0;
      var progressHider = function() {
        if (++count == 3) {
          if (form) {
            BS.AppCodeRunParams._updateBoldValues(false);
            var configurationChooserMustBeDisabled = $("target").selectedIndex == 0;
            $("configuration")._wasDisabled = configurationChooserMustBeDisabled; // minor hack to avoid blinking
            form.enable();
            $("configuration").disabled = configurationChooserMustBeDisabled; // if hack didn't work
          }
          BS.Util.hide("reparseProjectProgress");
        }
      };

      $("errorMessageContainer").refresh(null, "parseProject=true&projectOrWorkspacePath=" + encodeURIComponent($("project").value), function() {
        $("targetSelectorContainer").refresh(null, "", progressHider);
        $("configurationSelectorContainer").refresh(null, "", progressHider);
        $("schemeSelectorContainer").refresh(null, "", progressHider);
      });
    },

    _appendOptions: function(select, objects) {
      for (var i = 0; i < objects.length; i++) {
        var _object = objects[i];
        select.append(this._makeOptionHtml(_object.id, _object.name));
      }
    },

    _makeOptionHtml: function(id, name) {
      return this._optionTemplate.replace(/ID/g, id).replace(/NAME/g, name.escapeHTML());
    }
  };
</script>

<style type="text/css">
  .boldValue.gray {
    color: gray;
  }
</style>

<l:settingsGroup title="Project Settings">
  <tr>
    <c:set var="anchor" value="pathToTheProjectOrWorkspace" scope="request"/>
    <th><label for="project">Path to the project or workspace:</label><span class="mandatoryAsterix" title="Mandatory field"> *</span> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <div class="completionIconWrapper">
        <props:textProperty name="project" className="longField"/>
        <bs:vcsTree fieldId="project" treeId="teamcity-build-xcode-project-or-workspace"/>
      </div>
      <span class="smallNote">The specified path should be relative to the checkout directory. Should reference the project file (.xcodeproj) or workspace file (.xcworkspace).</span>
      <span class="error" id="error_project"></span>
    </td>
  </tr>
  <forms:workingDirectory />
</l:settingsGroup>

<c:set var="isXcode3" value="${propertiesBean.properties['xcode'] eq '3'}"/>
<c:set var="xcode3setting">class="xcode3"<c:if test="${!isXcode3}"> style="display: none;"</c:if></c:set>
<c:set var="xcode4setting">class="xcode4"<c:if test="${isXcode3}"> style="display: none;"</c:if></c:set>
<c:set var="isDefaultPlatform" value="${propertiesBean.properties['platform'] eq 'default'}"/>
<c:set var="isDefaultTarget" value="${propertiesBean.properties['target'] eq '###default###'}"/>
<c:set var="isDefaultConfiguration" value="${propertiesBean.properties['configuration'] eq '###default###'}"/>
<c:set var="isSdkAndArchDisabledStr"><c:out value="${isDefaultPlatform}"/></c:set>
<c:set var="isConfigurationDisabledStr"><c:out value="${isDefaultTarget}"/></c:set>
<c:set var="isCustomBuildOutputDirDisabledStr"><c:out value="${!(propertiesBean.properties['useCustomBuildOutputDir'] eq 'true')}"/></c:set>

<l:settingsGroup title="Build Settings">
  <tr class="advancedSetting">
    <c:set var="anchor" value="xcodePath" scope="request"/>
    <th><label for="xcodePath">Path to Xcode:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <props:textProperty name="xcodePath" className="longField"/>
      <span class="smallNote">Leave blank to detect Xcode automatically. The specified path should be either absolute or relative to the checkout directory.</span>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <input type="button" value="Check/Reparse Project" class="btn btn_mini" onclick="BS.AppCodeRunParams.reparseProject();"/>
      <forms:progressRing id="reparseProjectProgress" style="display: none;"/>
      <bs:refreshable containerId="errorMessageContainer" pageUrl="${pageUrl}">
        <c:if test="${hasError}">
          <jsp:useBean id="errorMessage" scope="request" type="java.lang.String"/>
          <span class="error"><c:out value="${errorMessage}"/></span>
        </c:if>
      </bs:refreshable>
    </td>
  </tr>
  <tr>
    <c:set var="anchor" value="build" scope="request"/>
    <th><label for="xcode">Build:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <props:selectProperty name="xcode" onchange="BS.AppCodeRunParams.changeXcode();">
        <props:option value="3">Target-based</props:option>
        <props:option value="4">Scheme-based</props:option>
      </props:selectProperty>
      <span class="error" id="error_xcode"></span>
    </td>
  </tr>
  <tr ${xcode4setting}>
    <c:set var="anchor" value="scheme" scope="request"/>
    <th><label for="scheme">Scheme:</label> <span class="mandatoryAsterix" title="Mandatory field">*</span> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <bs:refreshable containerId="schemeSelectorContainer" pageUrl="${pageUrl}">
        <c:choose>
          <c:when test="${hasProjectData && (not empty projectData.schemes)}">
            <props:selectProperty name="scheme">
              <c:forEach items="${projectData.schemes}" var="scheme">
                <props:option value="${scheme}"><c:out value="${scheme}"/></props:option>
              </c:forEach>
            </props:selectProperty>
            <span class="error" id="error_scheme"></span>
          </c:when>
          <c:otherwise>
            <strong class="boldValue"><props:displayValue name="scheme" emptyValue="Not specified"/></strong>
            <span class="smallNote">
              <c:choose>
                <c:when test="${hasProjectData && empty projectData.schemes}">No schemes were found in specified <c:choose><c:when test="${projectData.workspace}">workspace</c:when><c:otherwise>project</c:otherwise></c:choose>. Please make sure your schemes are shared (scheme files must be located under "xcshareddata" folder, not under "xcuserdata" one, and "xcshareddata" folder must be committed to your VCS; see <bs:helpLink file="Xcode+Project" anchor="${anchor}">help</bs:helpLink> for more information) and then press "Check/Reparse Project".</c:when>
                <c:otherwise>Press "Check/Reparse Project" to change the scheme.</c:otherwise>
              </c:choose>
            </span>
            <span class="error" id="error_scheme"></span>
            <props:hiddenProperty name="scheme"/>
          </c:otherwise>
        </c:choose>
      </bs:refreshable>
    </td>
  </tr>
  <tr class="advancedSetting">
    <c:set var="anchor" value="customBuildOutputDir" scope="request"/>
    <th ${xcode4setting}><label for="customBuildOutputDir">Build output directory:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td ${xcode4setting}>
      <props:checkboxProperty name="useCustomBuildOutputDir" onclick="BS.AppCodeRunParams.onUseCustomBuildOutputDirChecked();"/>
      <label for="useCustomBuildOutputDir">Use custom: </label>
      <props:textProperty name="customBuildOutputDir" className="longField" disabled="${isCustomBuildOutputDirDisabledStr}"/>
      <span class="smallNote">The specified path should be either absolute or relative to the checkout directory.</span>
    </td>
  </tr>
  <tr ${xcode3setting}>
    <c:set var="anchor" value="target" scope="request"/>
    <th>Target: <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <bs:refreshable containerId="targetSelectorContainer" pageUrl="${pageUrl}">
        <c:choose>
          <c:when test="${hasProjectData && !projectData.workspace}">
            <props:selectProperty name="target" onchange="BS.AppCodeRunParams.onTargetChanged();">
              <props:option value="###default###">&lt;Default&gt;</props:option>
              <c:forEach items="${projectData.targets}" var="target">
                <props:option value="${target.name}"><c:out value="${target.name}"/></props:option>
              </c:forEach>
            </props:selectProperty>
            <script type="text/javascript">
              BS.AppCodeRunParams._selectedTargetIndex = $("target").selectedIndex;
            </script>
          </c:when>
          <c:otherwise>
            <strong class="boldValue">
              <c:choose>
                <c:when test="${isDefaultTarget}">Default</c:when>
                <c:otherwise><props:displayValue name="target" emptyValue="Not specified"/></c:otherwise>
              </c:choose>
            </strong>
            <span class="smallNote">
              <c:choose>
                <c:when test="${hasProjectData && projectData.workspace}">Targets list is not available for workspace. To change the target please specify the path to the project and then press "Check/Reparse Project".</c:when>
                <c:otherwise>Press "Check/Reparse Project" to change the target.</c:otherwise>
              </c:choose>
            </span>
            <props:hiddenProperty name="target"/>
          </c:otherwise>
        </c:choose>
      </bs:refreshable>
    </td>
  </tr>
  <tr ${xcode3setting}>
    <c:set var="anchor" value="configuration" scope="request"/>
    <th>Configuration: <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <bs:refreshable containerId="configurationSelectorContainer" pageUrl="${pageUrl}">
        <c:choose>
          <c:when test="${hasProjectData && !projectData.workspace}">
            <script type="text/javascript">
              BS.AppCodeRunParams._configs[0] = [{id: "###default###", name: "<Select target>"}];
            </script>
            <props:selectProperty name="configuration" disabled="${isConfigurationDisabledStr}">
              <props:option value="###default###">&lt;${isDefaultTarget ? "Select target" : "Default"}&gt;</props:option>
              <c:forEach items="${projectData.targets}" var="target" varStatus="status">
                <script type="text/javascript">
                  BS.AppCodeRunParams._configs[${status.index + 1}] = [{id: "###default###", name: "<Default>"}];
                </script>
                <c:set var="isSelectedTarget" value="${propertiesBean.properties['target'] eq target.name}"/>
                <c:forEach items='${target.buildConfigurations}' var="configuration">
                  <script type="text/javascript">
                    BS.AppCodeRunParams._configs[${status.index + 1}].push({id: "${configuration.name}", name: "${configuration.name}"});
                  </script>
                  <c:if test="${isSelectedTarget}">
                    <props:option value="${configuration.name}"><c:out value="${configuration.name}"/></props:option>
                  </c:if>
                </c:forEach>
              </c:forEach>
            </props:selectProperty>
          </c:when>
          <c:otherwise>
            <strong class="boldValue">
              <c:choose>
                <c:when test="${isDefaultConfiguration}">Default</c:when>
                <c:otherwise><props:displayValue name="configuration" emptyValue="Not specified"/></c:otherwise>
              </c:choose>
            </strong>
            <span class="smallNote">
              <c:choose>
                <c:when test="${hasProjectData && projectData.workspace}">Configurations list is not available for workspace. To change the configuration please specify the path to the project and then press "Check/Reparse Project".</c:when>
                <c:otherwise>Press "Check/Reparse Project" to change the configuration.</c:otherwise>
              </c:choose>
            </span>
            <props:hiddenProperty name="configuration"/>
          </c:otherwise>
        </c:choose>
      </bs:refreshable>
    </td>
  </tr>
  <tr ${xcode3setting}>
    <c:set var="anchor" value="platform" scope="request"/>
    <th><label for="platform">Platform:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <props:selectProperty name="platform" onchange="BS.AppCodeRunParams.onPlatformChanged();">
        <props:option value="default">&lt;Default&gt;</props:option>
        <c:forEach items="${appleData.platforms}" var="platform">
          <props:option value="${platform.id}"><c:out value="${platform.name}"/></props:option>
        </c:forEach>
      </props:selectProperty>
      <script type="text/javascript">
        BS.AppCodeRunParams._selectedPlatformIndex = $("platform").selectedIndex;
      </script>
    </td>
  </tr>
  <c:forEach items='<%=new String[] { "sdk", "arch" }%>' var="propName">
    <tr ${xcode3setting}>
      <c:set var="anchor" value="${propName}" scope="request"/>
      <th><label for="${propName}">${propName eq "sdk" ? "SDK" : "Architecture"}:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
      <td>
        <script type="text/javascript">
          BS.AppCodeRunParams._${propName}s[0] = [{id: "default", name: "<Select platform>"}];
        </script>
        <props:selectProperty name="${propName}" disabled="${isSdkAndArchDisabledStr}">
          <props:option value="default">&lt;${isDefaultPlatform ? "Select platform" : "Default"}&gt;</props:option>
          <c:forEach items="${appleData.platforms}" var="platform" varStatus="status">
            <script type="text/javascript">
              BS.AppCodeRunParams._${propName}s[${status.index + 1}] = [{id: "default", name: "<Default>"}];
            </script>
            <c:set var="isSelectedPlatform" value="${propertiesBean.properties['platform'] eq platform.id}"/>
            <c:forEach items='${propName eq "sdk" ? platform.sdks : platform.archs}' var="item">
              <script type="text/javascript">
                BS.AppCodeRunParams._${propName}s[${status.index + 1}].push({id: "${item.id}", name: "<bs:escapeForJs text="${item.name}"/><c:if test='${propName eq "arch"}'> (<bs:escapeForJs text="${item.id}"/>)</c:if>"});
              </script>
              <c:if test="${isSelectedPlatform}">
                <props:option value="${item.id}"><c:out value="${item.name}"/><c:if test='${propName eq "arch"}'> (<c:out value="${item.id}"/>)</c:if></props:option>
              </c:if>
            </c:forEach>
          </c:forEach>
        </props:selectProperty>
      </td>
    </tr>
  </c:forEach>
  <tr class="advancedSetting">
    <c:set var="anchor" value="buildActions" scope="request"/>
    <th><label for="buildActions">Build action(s):</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <props:textProperty name="buildActions" className="longField"/>
      <span class="smallNote">Specify a space separated list of build actions. Available build actions are: clean, build, test, archive, installsrc, install.</span>
    </td>
  </tr>
  <tr>
    <th>&nbsp;</th>
    <td>
      <props:checkboxProperty name="runTests"/>
      <label for="runTests">Run tests</label>
    </td>
  </tr>
  <tr class="advancedSetting">
    <c:set var="anchor" value="additionalCommandLineParameters" scope="request"/>
    <th><label for="additionalCommandLineParameters">Additional command line parameters:</label> <jsp:include page="appCodeRunnerHelp.jsp"/></th>
    <td>
      <c:set var="note">Additional parameters for "xcodebuild".</c:set>
      <props:multilineProperty name="additionalCommandLineParameters" linkTitle="Additional Command Line Parameters" cols="48" rows="6" className="longField" note="${note}"/>
    </td>
  </tr>
</l:settingsGroup>
<script>
    (function () {
        var testRE = /\.xcworkspace\s*$/,
        $build = $j('#xcode'),
        disableTargetBasedBuild = function (value) {
            var schemeOnly = testRE.test(value);
            $build.find('option[value="3"]').attr('disabled', schemeOnly);
            schemeOnly && $build.find('option[value="4"]').prop('selected', true);
            $build.trigger('change');
        };

        disableTargetBasedBuild($j('#project').val());

        $j('#project').on('input change', function () {
            disableTargetBasedBuild(this.value);
        });
    })();
</script>
