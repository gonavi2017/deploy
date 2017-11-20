<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.nunit.server.NUnitBean"/>
<jsp:useBean id="testRunner" class="jetbrains.buildServer.dotNet.testRunner.server.DotNetTestRunnerBean"/>

<script type="text/javascript">
  BS.platformVersionAutoItem = null;

  BS.NUnit = {
    updatePathVisibility: function() {
      var curVersion = $j('#${bean.NUnitVersionKey}').val();
      var platformVersionDropdown = document.getElementById('platformVersionDropdown');

      if (curVersion == 'NUnit-3.0.0') {
        $j('#nUnitPathContainer').removeClass("hidden");
        $j('#nUnitCommandLineContainer').removeClass("hidden");
        $j('#nUnitWorkingDirectoryContainer').removeClass("hidden");
        $j('#nUnitConfigFileContainer').removeClass("hidden");
        $j('#nUnitRunProcessPerAssembly').addClass("hidden");

        if (BS.platformVersionAutoItem != null) {
          platformVersionDropdown.add(BS.platformVersionAutoItem, 0);
          BS.platformVersionAutoItem = null;
        }
      }
      else {
        $j('#nUnitPathContainer').addClass("hidden");
        $j('#nUnitCommandLineContainer').addClass("hidden");
        $j('#nUnitWorkingDirectoryContainer').addClass("hidden");
        $j('#nUnitConfigFileContainer').addClass("hidden");
        $j('#nUnitRunProcessPerAssembly').removeClass("hidden");

        if (BS.platformVersionAutoItem == null) {
          BS.platformVersionAutoItem = platformVersionDropdown[0];
          platformVersionDropdown.remove(0);
        }
      }

      BS.VisibilityHandlers.updateVisibility($('runnerParams'));
      BS.jQueryDropdown(platformVersionDropdown).ufd("changeOptions");
    }
  }
</script>
<tr>
  <th><label for="${bean.NUnitVersionKey}">NUnit runner:<bs:help file="NUnit" anchor="runner"/></label></th>
  <td>
    <props:selectProperty name="${bean.NUnitVersionKey}" enableFilter="true" className="mediumField" onchange="BS.NUnit.updatePathVisibility()">
      <c:forEach var="item" items="${bean.NUnitVersions}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr id="nUnitPathContainer">
  <th><label for="${bean.NUnitPathKey}">Path to NUnit console tool: <l:star/><bs:help file="NUnit" anchor="pathToNUnitConsoleTool"/></label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.NUnitPathKey}" className="longField"/>
    </div>
    <span class="error" id="error_${bean.NUnitPathKey}"></span>
    <span class="smallNote">Specify the path to NUnit console tool including the file name. Paths relative to the checkout directory are supported.</span>
  </td>
</tr>

<tr class="advancedSetting hidden" id="nUnitWorkingDirectoryContainer">
  <th><label for="${bean.NUnitConfigFileKey}">Working directory:<bs:help file="NUnit" anchor="workingDirectory"/></label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.NUnitWorkingDirectoryKey}" className="longField"/>
      <bs:vcsTree fieldId="${bean.NUnitWorkingDirectoryKey}" dirsOnly="true"/>
    </div>
    <span class="error" id="error_${bean.NUnitWorkingDirectoryKey}"></span>
    <span class="smallNote">Optional, set if differs from the directory of the testing assembly. Paths relative to the checkout directory are supported.</span>
  </td>
</tr>

<tr class="advancedSetting hidden" id="nUnitConfigFileContainer">
  <th><label for="${bean.NUnitConfigFileKey}">Path to application configuration file:<bs:help file="NUnit" anchor="appConfigFile"/></label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.NUnitConfigFileKey}" className="longField"/>
      <bs:vcsTree fieldId="${bean.NUnitConfigFileKey}"/>
    </div>
    <span class="error" id="error_${bean.NUnitConfigFileKey}"></span>
    <span class="smallNote">Specify the path to the application configuration file to be used by NUnit tests. Paths relative to the checkout directory are supported.</span>
  </td>
</tr>

<tr class="advancedSetting hidden" id="nUnitCommandLineContainer">
  <th><label for="${bean.NUnitCommadLineKey}">Additional command line parameters:<bs:help file="NUnit" anchor="cmdParameters"/></label></th>
  <td>
    <div class="posRel">
      <props:textProperty name="${bean.NUnitCommadLineKey}" className="longField"/>
    </div>
    <span class="error" id="error_${bean.NUnitCommadLineKey}"></span>
    <span class="smallNote">Enter additional command line parameters to the NUnit console tool</span>
  </td>
</tr>

<tr>
  <th rowspan="2"><label>.NET Runtime: </label></th>
  <td>
    <label for="${bean.platformTypeKey}" class="fixedLabel">Platform:</label>
    <props:selectProperty name="${bean.platformTypeKey}" enableFilter="true" className="smallField">
      <c:forEach var="item" items="${bean.platformTypes}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <td>
    <label for="${bean.platformVersionKey}" class="fixedLabel">Version:</label>
    <props:selectProperty name="${bean.platformVersionKey}" enableFilter="true" className="smallField" id="platformVersionDropdown">
      <c:forEach var="item" items="${bean.platformVersions}">
        <props:option value="${item.value}"><c:out value="${item.description}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>

<tr>
  <th><label for="${bean.NUnitIncludeKey}">Run tests from: <l:star/></label></th>
  <td><c:set var="note">Enter comma- or newline-separated paths to assembly files relative to the checkout directory. Wildcards are supported.</c:set
      ><props:multilineProperty
      name="${bean.NUnitIncludeKey}"
      className="longField"
      linkTitle="Edit assembly files include list"
      rows="3"
      cols="49"
      expanded="${true}"
      note="${note}"
      /></td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.NUnitExceludeKey}">Do not run tests from:</label></th>
  <td><c:set var="note">Enter comma- or newline-separated paths to assembly files relative to the checkout directory. Wildcards are supported.</c:set
      ><props:multilineProperty
      name="${bean.NUnitExceludeKey}"
      className="longField"
      linkTitle="Edit assembly files exclude list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.NUnitExceludeKey]}"
      note="${note}"
      /></td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.NUnitCategoryIncludeKey}">Include categories:</label></th>
  <td><c:set var="note">Enter comma- or newline-separated names of NUnit categories. Category expressions are supported as well. <bs:help file='NUnit' anchor="settings"/></c:set
      ><props:multilineProperty
      name="${bean.NUnitCategoryIncludeKey}"
      className="longField"
      linkTitle="Edit test categories include list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.NUnitCategoryIncludeKey]}"
      note="${note}"
      /></td>
</tr>

<tr class="advancedSetting">
  <th><label for="${bean.NUnitCategoryExcludeKey}">Exclude categories:</label></th>
  <td><c:set var="note">Enter comma- or newline-separated names of NUnit categories. Category expressions are supported as well. <bs:help file='NUnit' anchor="settings"/></c:set
      ><props:multilineProperty
      name="${bean.NUnitCategoryExcludeKey}"
      className="longField"
      linkTitle="Edit test categories exclude list"
      rows="3"
      cols="49"
      expanded="${not empty propertiesBean.properties[bean.NUnitCategoryExcludeKey]}"
      note="${note}"
      /></td>
</tr>

<tr class="advancedSetting hidden" id="nUnitRunProcessPerAssembly">
  <th><label for="${bean.NUnitRunProcessPerAssembly}">Run process per assembly:</label></th>
  <td><props:checkboxProperty name="${bean.NUnitRunProcessPerAssembly}" />
    <span class="smallNote">During sequential execution, a new process will be spawned for each test assembly.</span>
    <span class="error" id="error_${bean.NUnitRunProcessPerAssembly}"></span>
  </td>
</tr>

<props:hiddenProperty name="${bean.NUnitEnabledKey}" value="checked"/>
<props:hiddenProperty name="${testRunner.testRunnerTypeKey}" value="${testRunner.testRunnerTypeNUnitValue}"/>

<props:reduceTestFailureFeedback showRecentlyFailed="true" showRunNewAndModified="false"/>

<script type="text/javascript">
  BS.NUnit.updatePathVisibility();
</script>
