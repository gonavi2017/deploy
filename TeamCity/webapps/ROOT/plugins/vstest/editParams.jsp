<%@ include file="/include.jsp" %>
<%@ taglib prefix="prope" uri="http://www.springframework.org/tags/form" %>

<%@include file="paramsConstants.jsp"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="supportBean" class="jetbrains.buildServer.dotNet.vstest.server.VisualStudioTestBean"/>
<style>
  #customSelector {
    margin-top: 12px;
  }

  /* override too big specificity of smallNote */
  #x64Note.hidden {
    display: none;
  }
</style>

<props:hiddenProperty name="dotNetTestRunner.Type" value="GenericProcess"/>

<script type="text/javascript">
(function() {
  var hiddenClass = 'hidden';
  BS.DotTest = {};

  BS.DotTest.Common = {
    engines: [],
    selectedType: undefined,
    initialised: false,
    init: function (engines, selectors) {
      this.engines = engines;
      this.selectors = selectors;
      BS.Util.hide('customSelector');
      this.selectEngine($(selectors.engineSelectId));
      var updateX64 = function() {
        $j('#x64Note').toggleClass(hiddenClass, $j(BS.Util.escapeId(selectors.platformElemId)).val() !== 'x64');
      };

      $j(BS.Util.escapeId(selectors.platformElemId)).off('change', updateX64).on('change', updateX64);
      updateX64();
      this.initialised = true;
    },

    selectEngine: function(select) {
      this.selectedType = select.value;
      this.onTypeChanged();
    },

    onTypeChanged: function() {
      this.onRunnerChanged();
      $j('#msTestSelector').toggleClass(hiddenClass, this.selectedType !== 'MSTest');
      $j('#vsTestSelector').toggleClass(hiddenClass, this.selectedType === 'MSTest');
      this.showSpecificOptions();
    },

    showSpecificOptions: function() {
      var s = '.' + this.selectedType;
      $j('.js_testsetting')
          .filter(s).removeClass(hiddenClass).end()
          .not(s).addClass(hiddenClass);
      BS.MultilineProperties.updateVisible();
    },

    onRunnerChanged: function() {
      this.checkAndSetValue($j(BS.Util.escapeId(this.selectors[(this.selectedType == 'MSTest' ? 'ms' : 'vs') + 'TestVersionSelectId'])).val());

      var otherSelectId = this.selectors[(this.selectedType !== 'MSTest' ? 'ms' : 'vs') + 'TestVersionSelectId'],
          otherSelect = $j(BS.Util.escapeId(otherSelectId));

      otherSelect.val(otherSelect.find('option:first').val());

      /*
      BS.jQueryDropdown destroys dropdown and re-creates it again leading to blink in UI,
      on the other hand `ufd('changeOptions')` on uninitialized plugin throws exception
       */
      if (!$(BS.jQueryDropdown.namePrefix + otherSelectId)) {
        BS.jQueryDropdown(otherSelect).ufd('changeOptions');
      } else {
        otherSelect.ufd('changeOptions');
      }
    },

    checkAndSetValue: function(value) {
      value == 'custom' && !this.initialised || $j(BS.Util.escapeId(this.selectors.runnerPathId)).val(value != 'custom' ? value : '');
      BS.Util[value == 'custom' ? 'show' : 'hide']('customSelector');

      BS.VisibilityHandlers.updateVisibility($('customSelector'))
    }
  };
})();
</script>

<tr>
  <th><label for="${dotTestEngine}">Test engine type: <bs:help file="Visual+Studio+Tests" anchor="engines"/></label></th>
  <td>
    <props:selectProperty name="${dotTestEngine}"
                          id="${dotTestEngine}_select"
                          enableFilter="true"
                          className="mediumField"
                          onchange="BS.DotTest.Common.selectEngine(this);">
      <c:forEach var="item" items="${supportBean.engines}">
        <props:option value="${item}"><c:out value="${item}"/></props:option>
      </c:forEach>
    </props:selectProperty>
    <props:hiddenProperty name="${dotTestEngine}"/>
  </td>
</tr>

<tr>
  <th>Test engine version: </th>
  <td>
    <%--here be mstest selector--%>
    <div id="msTestSelector">
      <forms:select name="${msTestPath}_select"
                    enableFilter="true"
                    className="mediumField"
                    onchange="BS.DotTest.Common.onRunnerChanged(this)">
        <c:set var="valueFound" value="${false}"/>
        <c:forEach items="${supportBean.MSTestPathValues}" var="it">
          <c:set var="valueSelected" value="${it.value eq propertiesBean.properties[dotTestRunnerPath]}"/>
          <c:if test="${valueSelected}"><c:set var="valueFound" value="${true}"/></c:if>
          <forms:option value="${it.value}" selected="${valueSelected}"><c:out value="${it.description}"/></forms:option>
        </c:forEach>
        <forms:option value="custom" selected="${not valueFound}">&lt;Custom&gt;</forms:option>
      </forms:select>
    </div>
    <%--here be vstest selector--%>
    <div id="vsTestSelector">
      <forms:select name="${vsTestVersion}_select"
                    enableFilter="true"
                    className="mediumField"
                    onchange="BS.DotTest.Common.onRunnerChanged(this)">
        <c:set var="valueFound" value="${false}"/>
        <c:forEach var="v" items="${supportBean.supportedVSTestVersions}">
          <c:set var="valueSelected" value="${v.asReference eq propertiesBean.properties[dotTestRunnerPath]}"/>
          <c:if test="${valueSelected}"><c:set var="valueFound" value="${true}"/></c:if>
          <forms:option value="${v.asReference}" selected="${valueSelected}"><c:out value="${v.description}"/></forms:option>
        </c:forEach>
        <forms:option value="custom" selected="${not valueFound}">&lt;Custom&gt;</forms:option>
      </forms:select>
    </div>
    <div id="customSelector">
      <props:textProperty name="${dotTestRunnerPath}" className="longField"/>
      <span class="smallNote">Specify custom path to test runner</span>
    </div>
    <span class="error" id="error_${dotTestRunnerPath}"></span>
  </td>
</tr>

<tr>
  <th><label for="${dotTestInclude}">Test file names: <span class="js_testsetting VSTest"><l:star/></span> </label></th>
  <td>
    <c:set var="note">
      Newline-separated list of assemblies to be included in test run. <bs:helpLink file="Wildcards">Wildcards</bs:helpLink> are supported. <br/>
      Paths to the assemblies must be relative to the build checkout directory
    </c:set>
    <props:multilineProperty expanded="true" name="${dotTestInclude}" className="longField" note="${note}"
                             rows="3" cols="49" linkTitle="Edit included assemblies"/>
    <c:set var="note">
      Newline-separated list of assemblies to be included in test run. <bs:helpLink file="Wildcards">Wildcards</bs:helpLink> are supported. <br/>
      Paths to the assemblies must be relative to the build checkout directory
    </c:set>
    <props:multilineProperty name="${dotTestExclude}" className="longField" note="${note}"
                             rows="3" cols="49" linkTitle="Edit excluded assemblies"/>
    <span class="error" id="error_NoTests"></span>
  </td>
</tr>

<tr class="advancedSetting">
  <th><label for="${dotTestRunSettings}">Run configuration file:</label></th>
  <td>
    <props:textProperty className="longField" name="${dotTestRunSettings}"/>
    <bs:vcsTree treeId="${dotTestRunSettings}_vcsTree" fieldId="${dotTestRunSettings}"/>
    <span class="smallNote">Path to run settings configuration file</span>
  </td>
</tr>

<%@include file="editMsTestParams.jspf"%>
<%@include file="editVsTestParams.jspf"%>

<tr class="advancedSetting">
  <th><label for="${dotTestExtraCmd}">Additional command line parameters: <bs:help file="Visual+Studio+Tests" anchor="runnersettings"/></label></th>
  <td>
    <props:textProperty className="longField" name="${dotTestExtraCmd}"/>
    <span class="error" id="error_${dotTestExtraCmd}"></span>
    <span class="smallNote">Additional parameters to add to the command line for the selected test engine</span>
  </td>
</tr>

<%--engine selection--%>
<script type="text/javascript">
    BS.DotTest.Common.init([<c:forEach var="item" items="${supportBean.engines}" varStatus="status">
        '${item}'<c:if test="${not status.last}">,</c:if></c:forEach>],
      {
        platformElemId: '${platform}',
        engineSelectId: '${dotTestEngine}_select',
        msTestVersionSelectId: '${msTestPath}_select',
        vsTestVersionSelectId: '${vsTestVersion}_select',
        runnerPathId: '${dotTestRunnerPath}'
      }
    );
</script>
