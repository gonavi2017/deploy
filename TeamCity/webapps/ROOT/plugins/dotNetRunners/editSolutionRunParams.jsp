<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.runner.MSBuild.SolutionBean"/>

<tr>
  <th><label for="${bean.buildFilePathKey}">Solution file path: <l:star/></label></th>
  <td>
    <props:textProperty name="${bean.buildFilePathKey}" className="longField"/><bs:vcsTree fieldId="${bean.buildFilePathKey}"/>
    <span class="error" id="error_${bean.buildFilePathKey}"></span>
    <span class="smallNote">The specified path should be relative to the checkout directory.</span>
  </td>
</tr>

<props:workingDirectory />

<tr>
  <th><label for="${bean.solutionVersionKey}">Visual Studio:</label></th>
  <td>
    <props:selectProperty name="${bean.solutionVersionKey}" enableFilter="true" className="mediumField">
      <c:forEach var="item" items="${bean.solutionVersions}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<props:hiddenProperty name="${bean.runPlatformKey}" value="${bean.platformValue.value}"/>
<props:hiddenProperty name="${bean.versionKey}"/>
<props:hiddenProperty name="${bean.toolsVersionKey}"/>

<script type="text/javascript">
  if (!BS.dotNet) {BS.dotNet = {};};
  BS.dotNet.VSSolution = {
    vsVersionChange: function() {
      var el = $('${bean.solutionVersionKey}');
      var val = el.value;

      <c:forEach var="item" items="${bean.solutionVersions}">
        if (val == '${item.value}') {
          $('${bean.versionKey}').value = '${item.version.value}';
          $('${bean.toolsVersionKey}').value = '${item.toolsVersion.propertyValue}';
          return;
        }
      </c:forEach>
      ;
    }
  };

  (function() {
    var fun = BS.dotNet.VSSolution.vsVersionChange;
    $('${bean.solutionVersionKey}').on("change", fun);
    fun();
  })();
</script>

<tr>
  <th><label for="${bean.targetsKey}">Targets:</label></th>
  <td><props:textProperty name="${bean.targetsKey}" className="longField"/>
    <span class="error" id="error_${bean.targetsKey}"></span>
    <span class="smallNote">Enter targets separated by space or semicolon.
      <strong>Build</strong>,
      <strong>Rebuild</strong>,
      <strong>Clean</strong>,
      <strong>Publish</strong>
      targets are supported by default</span></td>
</tr>

<tr>
  <th><label for="${bean.configurationKey}">Configuration:</label></th>
  <td><props:textProperty name="${bean.configurationKey}" className="longField"/>
    <span class="error" id="error_${bean.configurationKey}"></span>
    <span class="smallNote">Enter solution configuration to build. <strong>Debug</strong> or <strong>Release</strong> are supported in default solution file. Leave blank to use default</span>
  </td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.platformKey}">Platform:</label></th>
  <td><props:textProperty name="${bean.platformKey}" className="longField"/>
    <span class="error" id="error_${bean.platformKey}"></span>
    <span class="smallNote">Enter solution platform for the build. Leave blank to use default</span>
  </td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.runnerArgsKey}">Command line parameters:</label></th>
  <td><props:textProperty name="${bean.runnerArgsKey}" className="longField" expandable="true"/>
    <span class="error" id="error_${bean.runnerArgsKey}"></span>
    <span class="smallNote">Enter additional command line parameters to MSBuild.exe.</span>
  </td>
</tr>
