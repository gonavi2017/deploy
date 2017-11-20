<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ attribute name="showWorkingDir" type="java.lang.Boolean" %>
<%@ attribute name="javaMinVersion" type="java.lang.String" %>
<jsp:useBean id="iprInfo" type="jetbrains.buildServer.controllers.admin.ipr.IprInfo" scope="request"/>
<jsp:useBean id="supportedProjectTypes" type="java.util.Map" scope="request"/>

<script type="text/javascript">
  BS.reparseIpr = function(button) {
    if (button.form.cancel.value != 'true') {

      // Start reparse

      BS.Util.show('iprParseProgress');
      BS.Util.hide('iprWarning');

      BS.ajaxRequest("iprReparse.html", {
        method: 'post',
        parameters: BS.Util.serializeForm(button.form) + "&id=${param['id']}&template=${buildForm.template}&projectId=${buildForm.project.externalId}&runnerId=${buildForm.buildRunnerBean.id}",
        onSuccess: function() {
          BS.refreshReparse();
        }
      });

      button.form.cancel.value = 'true';
      button.form.reparse.value = 'Cancel';
    }
    else {

      // Cancel reparse

      BS.Util.hide('iprParseProgress');
      BS.Util.hide('iprRefreshProgress');

      BS.ajaxRequest("iprReparse.html", {
        method: 'post',
        parameters: BS.Util.serializeForm(button.form) + "&id=${param['id']}&template=${buildForm.template}&projectId=${buildForm.project.externalId}&runnerId=${buildForm.buildRunnerBean.id}"
      });

      button.form.cancel.value = '';
      button.form.reparse.value = 'Check/Reparse Project';
    }

    BS.Util.hide('error_projectReparseRequired');
    BS.MultilineProperties.updateVisible();
  };

  BS.reloadIprRunner = function() {
    try {
      BS.updateRunnerContainer();
    } catch (e) {
      //
    }
  };

  BS.refreshReparse = function() {

    BS.Util.show('iprParseProgress');
    $('iprRefreshProgress').style.display = 'inline';
    BS.MultilineProperties.updateVisible();

    BS.ajaxRequest("iprReparse.html", {
      method: 'get',
      parameters: "id=${param['id']}&projectId=${buildForm.project.externalId}&runnerId=${buildForm.buildRunnerBean.id}",
      onSuccess: function (transport) {
        if (transport.responseXML) {
          var element = transport.responseXML.documentElement;

          // expected mandatory attributes are 'done', 'progressText', 'percent'

          if (element.getAttribute('done') == 'true') {
            BS.reloadIprRunner();
          }
          else {
            // still in progress
            $('iprRefreshProgressText').innerHTML = element.getAttribute('progressText');
            var percent = parseInt(element.getAttribute('percent'));
            $('iprRefreshPercent').innerHTML = percent > 0 ? "(" + percent + "%)" : "";

            BS.refreshReparse.delay(5);
          }
        }
        else {
          BS.reloadIprRunner();
        }
      }
    });
  };
  <c:set var="cancelValue" value=""/>
  <c:set var="reparseButtonText" value="Check/Reparse Project"/>
  <c:if test="${not empty iprInfo.analyzeTask and not iprInfo.analyzeTask.done}">
    BS.refreshReparse.delay(1);
    <c:set var="cancelValue" value="true"/>
    <c:set var="reparseButtonText" value="Cancel"/>
  </c:if>
</script>
<l:settingsGroup title="Project Settings">

<c:if test="${fn:length(supportedProjectTypes) > 1}">

  <c:if test="${'maven' == iprInfo.projectType}">
    <c:set var="hideCheckReparse" value="style='display: none'"/>
  </c:if>
<tr>
  <th><label for="iprInfo.ipr">Project file type:</label></th>
  <td>
    <forms:radioButton name="iprInfo.projectType" id="projectTypeIpr" value="ipr" checked="${'ipr' == iprInfo.projectType}" onclick="iprSelectProjectType();" title=""/>
    <label for="projectTypeIpr">IntelliJ IDEA</label>

    <span style="padding-left: 5em">
      <forms:radioButton name="iprInfo.projectType" id="projectTypeMaven" value="maven" checked="${'maven' == iprInfo.projectType}" onclick="iprSelectProjectType();" title=""/>
      <label for="projectTypeMaven">Maven</label>
    </span>

    <span style="padding-left: 5em">
      <forms:radioButton name="iprInfo.projectType" id="projectTypeGradle" value="gradle" checked="${'gradle' == iprInfo.projectType}" onclick="iprSelectProjectType();" title=""/>
      <label for="projectTypeGradle">Gradle</label>
    </span>

  </td>
</tr>
</c:if>
<tr>
  <th><label for="iprInfo.ipr">Path to the project: </label><bs:help file="IntelliJ+IDEA+Project" anchor="projectPath"/></th>
  <td>
    <input type="text" name="iprInfo.ipr" id="iprInfo.ipr" value="${iprInfo.ipr}"
            class="textProperty longField"/><bs:vcsTree fieldId="iprInfo.ipr"/>
    <span class="error" id="error_iprInfo.ipr"></span>
    <c:if test="${not empty iprInfo.iprWarning}">
      <div class="icon_before icon16 attentionComment" id="iprWarning">${iprInfo.iprWarning}</div>
    </c:if>

    <span class="smallNote projectType ipr_project">Should reference path to project file (<strong>.ipr</strong>) or project directory for directory-based (<strong>.idea</strong>) projects. The specified path should be relative to the checkout directory. Leave empty if <strong>.idea</strong> directory is right under the checkout directory.</span>
    <span class="smallNote projectType maven_project">Should reference path to Maven <strong>pom.xml</strong> file. The specified path should be relative to the checkout directory.</span>
    <span class="smallNote projectType gradle_project">Should reference path to Gradle <strong>.gradle</strong> file. The specified path should be relative to the checkout directory.</span>

    <div id="checkReparseSection" class="projectType ipr_project">
      <input type="hidden" name="_iprInfo.parseAllProjectFiles" value=""/>

      <div class="advancedSetting">
      <forms:checkbox name="iprInfo.parseAllProjectFiles" id="parseAllProjectFiles" checked="${iprInfo.parseAllProjectFiles}"/>
      <label for="parseAllProjectFiles">Detect global libraries and module-based JDK in the *.iml files</label>
      <span class="smallNote">This process can take time, because it involves loading and parsing all project module (*.iml) files.</span>
      <forms:checkbox name="iprInfo.parseRunConfigurations" id="parseRunConfigurations" checked="${iprInfo.parseRunConfigurations}"/>
      <label for="parseRunConfigurations">Check for path variables and jre usages in run configurations</label>
      <span class="smallNote">This process can take time, because it involves loading and parsing all project run configurations config files.</span>
      <forms:checkbox name="iprInfo.parseArtifacts" id="parseArtifacts" checked="${iprInfo.parseArtifacts}"/>
      <label for="parseArtifacts">Check for path variables in artifacts</label>
      <span class="smallNote">This process can take time, because it involves loading and parsing all project artifacts config files.</span>
      </div>

      <div style="margin-top: 1em;" id="reparseBlock">
        <input type="button" name="reparse" value="${reparseButtonText}" onclick="BS.reparseIpr(this);" class="btn btn_mini"/>
        <input type="hidden" name="cancel" value="${cancelValue}"/>
        <forms:saving id="iprParseProgress" savingTitle="Loading and analyzing project files..." className="progressRingInline" />
        <span id="iprRefreshProgress" style="display: none;">
          <span id="iprRefreshProgressText"></span>
          <span id="iprRefreshPercent"></span>
        </span>

      </div>

      <span class="error" id="error_projectReparseRequired"></span>
    </div>

  </td>
</tr>

</l:settingsGroup>

<tr class="projectType ipr_project">
  <td colspan="2" style="margin:0; padding: 0;" class="noBorder">
  <table id="projectSdksAndLibs" ${hideCheckReparse} style="margin: 0; padding: 0" width="100%" class="runnerFormTable">

  <c:if test="${not empty iprInfo.unresolvedModules or not empty iprInfo.pathVariables}">
  <l:settingsGroup title="Unresolved Project Modules and Path Variables">

  <c:if test="${not empty iprInfo.unresolvedModules}">
    <tr>
      <td colspan="2" class="unresolvedModules">
        <bs:icon icon="../attentionComment.png"/> Unresolved Project Modules:
        <c:forEach items="${iprInfo.unresolvedModules}" var="module">
          <div><c:out value="${module}"/></div>
        </c:forEach>

      </td>
    </tr>
  </c:if>

  <c:if test="${not empty iprInfo.pathVariables}">
    <c:forEach var="pathVar" items="${iprInfo.pathVariables}">
      <%--@elvariable id="pathVar" type="java.util.Map.Entry<java.lang.String, jetbrains.buildServer.ideaSettings.PathVariableInfo>"--%>
      <tr>
        <td class="pathVariableName">${pathVar.key}</td>
        <td class="pathVariableValue">
          <c:set var="var" value="${pathVar.value}"/>
          <label for="${pathVar.key}_pathvar_value">
            Set value to:
          </label>
          <input type="text" name="iprInfo.pathVariables[${pathVar.key}].value"
                 id="${pathVar.key}_pathvar_value" value="${var.value}" class="textProperty longField"/>

          <c:if test="${not empty var.usages}">
            <br/>
            <label>Used in:</label>
            <div class="posRel">
              <c:forEach var="usage" items="${var.usages}">
                <span>${usage}</span><br/>
              </c:forEach>
            </div>
          </c:if>
        </td>
      </tr>
    </c:forEach>
  </c:if>
  </l:settingsGroup>
  </c:if>

  <l:settingsGroup title="Project SDKs">
    <c:if test="${empty iprInfo.sdks}">
      <tr>
        <td colspan="2"><div class="icon_before icon16 attentionComment">Project SDKs are not configured, please click "Check/Reparse Project" button.</div></td>
      </tr>
    </c:if>
    <c:forEach var="jdk" items="${iprInfo.sdks}">
      <c:set var="varJdk" value="${jdk.value}"/>
      <jsp:useBean id="varJdk" type="jetbrains.buildServer.ideaSettings.Sdk"/>
      <tr>
        <th class="libraryName">${varJdk.name}</th>
        <td class="libraryValue">
          <c:choose>
            <c:when test="${varJdk.sdkType == 'JavaSDK'}">
              <props:jdk jdk="${varJdk}"/>
            </c:when>
            <c:when test="${varJdk.sdkType == 'Android SDK'}">
              <label for="iprInfo.sdks[${jdk.key}].apiLevel" style="width: 11em;">API level: <a href="http://developer.android.com/guide/topics/manifest/uses-sdk-element.html#ApiLevels" target="_blank"><bs:helpIcon iconTitle="API levels"/></a></label>
              <input type="text" name="iprInfo.sdks[${jdk.key}].apiLevel" id="iprInfo.sdks[${jdk.key}].apiLevel" value="${varJdk.apiLevel}" class="textProperty libraryPath"/>
              <br/>
              <props:jdk jdk="${varJdk}" pathTitle="${varJdk.sdkType} Home" patternTitle="SDK Files Patterns"/>
              <br/>
              <props:library libraryKey="${jdk.key}_jdk_1" pathName="iprInfo.sdks[${jdk.key}].javaSdk.pathToJdk"
                             pathTitle="JDK Home" pathValue="${varJdk.javaSdk.pathToJdk}"
                             patternName="iprInfo.sdks[${jdk.key}].javaSdk.patternsText"
                             patternValue="${varJdk.javaSdk.patternsText}" patternTitle="JDK Jar Files Patterns"
                             helpAnchor="projectJdk"
                  />
            </c:when>
            <c:when test="${varJdk.sdkType == 'IDEA JDK'}">
              <c:set var="varIdeaJdk" value="${jdk.value}"/>
              <props:library libraryKey="${jdk.key}_jdk" pathName="iprInfo.sdks[${jdk.key}].pathToIdea"
                             pathTitle="IDEA Home" pathValue="${varJdk.pathToIdea}"
                             patternName="iprInfo.sdks[${jdk.key}].ideaPatternsText"
                             helpAnchor="projectJdk"
                             patternValue="${varJdk.ideaPatternsText}" patternTitle="IDEA Jar Files Patterns"/>
              <props:jdk jdk="${varJdk}" libraryKey="${jdk.key}_jdk_1"/>
            </c:when>
            <c:otherwise>
              <props:jdk jdk="${varJdk}" pathTitle="${varJdk.sdkType} Home" patternTitle="SDK Files Patterns"/>
            </c:otherwise>
          </c:choose>
          <props:iprRemoveJdk key="jdk_${jdk.key}" typeName="${varJdk.sdkType}" shouldShow="${not varJdk.used}"/>
        </td>
      </tr>
    </c:forEach>

  </l:settingsGroup>

  <c:if test="${not empty iprInfo.libraries}">
    <l:settingsGroup title="Project Global Libraries">
      <c:forEach var="lib" items="${iprInfo.libraries}">
        <c:set var="varLib" value="${lib.value}"/>
        <jsp:useBean id="varLib" type="jetbrains.buildServer.ideaSettings.Library"/>
        <tr>
          <th class="libraryName">${varLib.name}</th>
          <td class="libraryValue">
            <props:library libraryKey="${lib.key}_lib" pathName="iprInfo.libraries[${lib.key}].pathToLibrary"
                           pathTitle="Path to Library" pathValue="${varLib.pathToLibrary}"
                           patternName="iprInfo.libraries[${lib.key}].patternsText"
                           helpAnchor="projectLibrary"
                           patternValue="${varLib.patternsText}" patternTitle="Library Jar Files Patterns"/>
            <props:iprRemoveJdk key="library_${lib.key}" typeName="global library" shouldShow="${not varLib.used}"/>
          </td>
        </tr>
      </c:forEach>
    </l:settingsGroup>
  </c:if>
  </table>
  </td>
</tr>

<l:settingsGroup title="Java Parameters" className="advancedSetting">
  <c:if test="${empty javaMinVersion}">
    <c:set var="javaMinVersion" value="1.6"/>
  </c:if>
  <props:editJavaHome minVersion="${javaMinVersion}"/>

  <props:editJvmArgs/>

  <c:if test="${showWorkingDir}">
    <props:workingDirectory />
  </c:if>
</l:settingsGroup>

<script type="text/javascript">
  iprSelectProjectType = function () {
    var modeClassMap = {
      ipr: 'ipr_project',
      maven: 'maven_project',
      gradle: 'gradle_project'
    };

    if ($$('input[type=radio][name="iprInfo.projectType"]').length == 0) {
      BS.Util.toggleDependentElements("ipr", 'projectType', false, modeClassMap);
    } else {
      BS.Util.toggleDependentElements($$('input:checked[type=radio][name="iprInfo.projectType"]')[0].value, 'projectType', false, modeClassMap);
    }

    BS.MultilineProperties.updateVisible();
  };

  iprSelectProjectType();

</script>