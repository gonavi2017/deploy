<%--Copyright 2000-2013 JetBrains s.r.o.--%>

<%--Licensed under the Apache License, Version 2.0 (the "License");--%>
<%--you may not use this file except in compliance with the License.--%>
<%--You may obtain a copy of the License at--%>

<%--http://www.apache.org/licenses/LICENSE-2.0--%>

<%--Unless required by applicable law or agreed to in writing, software--%>
<%--distributed under the License is distributed on an "AS IS" BASIS,--%>
<%--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.--%>
<%--See the License for the specific language governing permissions and--%>
<%--limitations under the License.--%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<%@include file="globalConsts.jsp" %>
<%@include file="rubyEnvConfiguratorConsts.jsp" %>

<style type="text/css">
  .rec-container {
    display: none;
  }
</style>

<tr>
  <th>
    Configure Ruby environment via <bs:help file="Ruby+Environment+Configurator"/>
  </th>
  <td>
    <forms:select name="REC_MODE" onchange="BS.RubyEC.onFormChange()" className="longField">
      <props:option id="rec-mode-none" value="unspecified" selected="${true}">-- Choose method --</props:option>
      <props:option id="rec-mode-path" value="path">Path to Ruby interpreter</props:option>
      <props:option id="rec-mode-rvm" value="rvm">RVM</props:option>
      <props:option id="rec-mode-rbenv" value="rbenv">rbenv</props:option>
    </forms:select>

    <span class="error" id="error_${UI_USE_RVM_KEY}"></span>

    <props:hiddenProperty name="${UI_INNER_RVM_EXIST_REQUIRMENT_KEY}" value=""/>
    <props:hiddenProperty name="${UI_INNER_RBENV_EXIST_REQUIRMENT_KEY}" value=""/>
    <%-- Old property, used for storing --%>
    <props:hiddenProperty name="${UI_USE_RVM_KEY}" value="${propertiesBean.properties[UI_USE_RVM_KEY]}"/>
  </td>
</tr>

<%-- Path --%>
<tr class="rec-container" id="rec-path-container">
  <th>
    <label for="${UI_RUBY_SDK_PATH_KEY}">Interpreter path:</label>
  </th>
  <td>
    <props:textProperty name="${UI_RUBY_SDK_PATH_KEY}" className="longField"/>
    <span class="smallNote">Leave empty to search interpreter in the <strong>PATH</strong> environment variable.</span>
  </td>
</tr>

<%-- RVM --%>
<tr class="rec-container" id="rec-rvm-container-manual-1">
  <th>
    <forms:radioButton name="REC_RVM_MODE" onclick="BS.RubyEC.onFormChange()" value="manual" id="rvm_manual" checked="true"/>
    <label for="rvm_manual">Interpreter and gemset</label>
  </th>
</tr>
<tr class="rec-container" id="rec-rvm-container-manual-2">
  <th>
    <label for="${UI_RVM_SDK_NAME_KEY}">Interpreter name: <l:star/></label>
  </th>
  <td>
    <props:textProperty name="${UI_RVM_SDK_NAME_KEY}" className="longField"/>
    <span class="error" id="error_${UI_RVM_SDK_NAME_KEY}"></span>
    <span class="smallNote">E.g.: <strong>ruby-1.8.7-p249</strong>, <strong>jruby-1.4.0</strong> or <strong>system</strong></span>
  </td>
</tr>
<tr class="rec-container" id="rec-rvm-container-manual-3">
  <th>
    <label for="${UI_RVM_GEMSET_NAME_KEY}">Gemset:</label>
  </th>
  <td>
    <props:textProperty name="${UI_RVM_GEMSET_NAME_KEY}" className="longField"/>
    <span class="smallNote">Leave empty to use default gemset.</span>
    <props:checkboxProperty name="${UI_RVM_GEMSET_CREATE_IF_NON_EXISTS}"/>
    <label for="${UI_RVM_GEMSET_CREATE_IF_NON_EXISTS}">Create gemset if not exist</label>
  </td>
</tr>
<tr class="rec-container" id="rec-rvm-container-rvmrc">
  <th>
    <forms:radioButton name="REC_RVM_MODE" onclick="BS.RubyEC.onFormChange()" value="rvmrc" id="rvm_rvmrc"/>
    <label for="rvm_manual">Path to a&nbsp;'.rvmrc'&nbsp;file:</label>
  </th>
  <td>
    <div class="posRel">
      <props:textProperty name="${UI_RVM_RVMRC_PATH_KEY}" className="longField"/>
      <bs:vcsTree fieldId="${UI_RVM_RVMRC_PATH_KEY}"/>
    </div>
    <span class="error" id="error_${UI_RVM_RVMRC_PATH_KEY}"></span>
    <span class="smallNote">Path relative to a checkout directory. Leave empty to use ".rvmrc"</span>
  </td>
</tr>
<tr class="rec-container" id="rec-rvm-container-ruby-version">
  <th>
    <forms:radioButton name="REC_RVM_MODE" onclick="BS.RubyEC.onFormChange()" value="ruby_version" id="rvm_ruby_version"/>
    <label for="rvm_manual">Path to a directory with '.ruby-version'<br/> and '.ruby-gemset'&nbsp;files:</label>
  </th>
  <td>
    <div class="posRel">
      <props:textProperty name="${UI_RVM_RUBY_VERSION_PATH_KEY}" className="longField"/>
      <bs:vcsTree fieldId="${UI_RVM_RUBY_VERSION_PATH_KEY}"/>
    </div>
    <span class="error" id="error_${UI_RVM_RUBY_VERSION_PATH_KEY}"></span>
    <span class="smallNote">Path relative to a checkout directory. Leave empty to use checkout directory</span>
  </td>
</tr>

<%-- rbenv --%>
<tr class="rec-container" id="rec-rbenv-container-manual">
  <th>
    <forms:radioButton name="REC_RBENV_MODE" onclick="BS.RubyEC.onFormChange()" value="manual" id="rbenv_manual" checked="true"/>
    <label for="rbenv_manual">Interpreter version:</label>
  </th>
  <td>
    <props:textProperty name="${UI_RBENV_VERSION_NAME_KEY}"/>
    <span class="smallNote">E.g.: <strong>1.9.3-p286</strong> or <strong>jruby-1.7.0</strong></span>
    <span class="error" id="error_${UI_RBENV_VERSION_NAME_KEY}"></span>
  </td>
</tr>
<tr class="rec-container" id="rec-rbenv-container-file">
  <th>
    <forms:radioButton name="REC_RBENV_MODE" onclick="BS.RubyEC.onFormChange()" value="file" id="rbenv_file"/>
    <label for="rbenv_file">Path to a directory with '.ruby-version'<br/> or '.rbenv-version'&nbsp;file:</label>
  </th>
  <td>
    <div class="posRel">
      <props:textProperty name="${UI_RBENV_FILE_PATH_KEY}" className="longField"/>
      <bs:vcsTree fieldId="${UI_RBENV_FILE_PATH_KEY}"/>
    </div>
    <span class="error" id="error_${UI_RBENV_FILE_PATH_KEY}"></span>
    <span class="smallNote">Path relative to a checkout directory. Leave empty to use <nobr>".ruby-version"</nobr>(preferred) or <nobr>".rbenv-version"</nobr></span>
  </td>
</tr>

<%-- For all--%>
<tr class="rec-container" id="rec-check-container">
  <td colspan="2">
    <props:checkboxProperty name="${UI_FAIL_BUILD_IF_NO_RUBY_FOUND_KEY}"/>
    <label for="${UI_FAIL_BUILD_IF_NO_RUBY_FOUND_KEY}">Fail build if Ruby interpreter was not found</label>
  </td>
</tr>

<script type="text/javascript">
  BS.Util.escapeForJQuerySelector = function (obj) {
    return BS.Util.escapeId(obj).substring(1);
  };

  BS.RECFormUtil = {
    setInputValue: function (name, value) {
      var n = BS.Util.escapeForJQuerySelector(name);
      $j('input[name=' + n + ']').val(value);
    },
    setHiddenValue: function (name, value) {
      var n = BS.Util.escapeForJQuerySelector(name);
      $j('input[type=hidden][name=' + n + ']').val(value);
    },
    setTextValue: function (name, value) {
      var n = BS.Util.escapeForJQuerySelector(name);
      $j('input[type=text][name=' + n + ']').val(value);
    },
    setRadioValue: function (name, value) {
      var n = BS.Util.escapeForJQuerySelector(name);
      var v = BS.Util.escapeForJQuerySelector(value);
      $j('input[type=radio][name=' + n + '][value=' + v + ']').click();
    },
    setSelectValue: function (name, value) {
      var n = BS.Util.escapeForJQuerySelector(name);
      $j('select[name=' + n + ']').val(value);
    },
    getInput: function (name) {
      var n = BS.Util.escapeForJQuerySelector(name);
      return $j('input[name=' + n + ']');
    },
    getSelect: function (name) {
      var n = BS.Util.escapeForJQuerySelector(name);
      return $j('select[name=' + n + ']');
    },
    getInputValue: function (name) {
      return this.getInput(name).val();
    },
    getSelectValue: function (name) {
      var n = BS.Util.escapeForJQuerySelector(name);
      return $j('select[name=' + n + ']').val();
    }
  };

  BS.RubyEC = {
    prepareUI: function () {
      this.convertFromStorage();
      BS.jQueryDropdown($('REC_MODE'));
    },
    mode: {
      unspecified: "unspecified",
      path: "path",
      rvm: "rvm",
      rbenv: "rbenv",
      getMode: function () {
        return $j('#REC_MODE').val();
      },
      setMode: function (value) {
        $j('#REC_MODE').val(value);
      }
    },
    rvm: {
      manual: "manual",
      rvmrc: "rvmrc",
      ruby_version: "ruby_version",
      getMode: function () {
        return $j('input[name=REC_RVM_MODE]:checked').val();
      },
      setMode: function (value) {
        $j('input[name=REC_RVM_MODE][value=' + value + ']').click();
      }
    },
    rbenv: {
      manual: "manual",
      file: "file",
      getMode: function () {
        return $j('input[name=REC_RBENV_MODE]:checked').val();
      },
      setMode: function (value) {
        $j('input[name=REC_RBENV_MODE][value=' + value + ']').click();
      }
    },
    convertFromStorage: function () {
      <%-- Take storaged value and convert in into new --%>
      var value = $j(BS.Util.escapeId('${UI_USE_RVM_KEY}')).val();
      if ('manual' == value) {
        this.mode.setMode(this.mode.rvm);
        this.rvm.setMode(this.rvm.manual);
      } else if ('rvmrc' == value) {
        this.mode.setMode(this.mode.rvm);
        this.rvm.setMode(this.rvm.rvmrc);
      } else if ('rvm_ruby_version' == value) {
        this.mode.setMode(this.mode.rvm);
        this.rvm.setMode(this.rvm.ruby_version);
      } else if ('rbenv' == value) {
        this.mode.setMode(this.mode.rbenv);
        this.rbenv.setMode(this.rbenv.manual);
      } else if ('rbenv_file' == value) {
        this.mode.setMode(this.mode.rbenv);
        this.rbenv.setMode(this.rbenv.file);
      } else if ('unspecified' == value) {
        this.mode.setMode(this.mode.unspecified);
      } else {
        this.mode.setMode(this.mode.path);
      }
      this.onFormChange = this._process;
      this.onFormChange();
    },
    _process: function () {
      $j('.rec-container').hide();
      var mode = $j('#REC_MODE').val();
      var ow = $j(BS.Util.escapeId('${UI_USE_RVM_KEY}'));
      switch (mode) {
        case this.mode.rvm:
          var rvm = this.rvm.getMode();
          BS.Util.show('rec-rvm-container-mode');
          BS.Util.show('rec-check-container');
          BS.Util.show('rec-rvm-container-manual-1');
          BS.Util.show('rec-rvm-container-manual-2');
          BS.Util.show('rec-rvm-container-manual-3');
          BS.Util.show('rec-rvm-container-rvmrc');
          BS.Util.show('rec-rvm-container-ruby-version');

          this.setRVMRequirement();
          switch (rvm) {
            case this.rvm.manual:
              ow.val('manual');
              $('${UI_RVM_SDK_NAME_KEY}').focus();
              break;
            case this.rvm.rvmrc:
              ow.val('rvmrc');
              $('${UI_RVM_RVMRC_PATH_KEY}').focus();
              break;
            case this.rvm.ruby_version:
              ow.val('rvm_ruby_version');
              $('${UI_RVM_RUBY_VERSION_PATH_KEY}').focus();
              break;
            default :
              // Do nothing, nothing selected
              ow.val('unspecified');
              break;
          }
          break;
        case this.mode.rbenv:
          var rbenv = this.rbenv.getMode();
          BS.Util.show('rec-rbenv-container-manual');
          BS.Util.show('rec-rbenv-container-file');
          BS.Util.show('rec-check-container');
          this.setRbEnvRequirement();
          switch (rbenv) {
            case this.rbenv.manual:
              ow.val('rbenv');
              $('${UI_RBENV_VERSION_NAME_KEY}').focus();
              break;
            case this.rbenv.file:
              ow.val('rbenv_file');
              $('${UI_RBENV_FILE_PATH_KEY}').focus();
              break;
            default:
              // Do nothing, nothing selected
              ow.val('unspecified');
              break;
          }
          break;
        case this.mode.path:
          ow.val('');
          BS.Util.show('rec-path-container');
          BS.Util.show('rec-check-container');
          $('${UI_RUBY_SDK_PATH_KEY}').focus();
          this.unsetRequirements();
          break;
        case this.mode.unspecified:
          ow.val('unspecified');
          $('REC_MODE').focus();
          this.unsetRequirements();
          break;
        default :
          throw "Invalid state exception, cannot process mode: " + mode;
      }
      BS.VisibilityHandlers.updateVisibility('mainContent');
    },
    onFormChange: function () {
      // Do nothing will be replaced in convertFromStorage, after converting
    },
    unsetRequirements: function () {
      $('${UI_INNER_RVM_EXIST_REQUIRMENT_KEY}').value = "";
      $('${UI_INNER_RBENV_EXIST_REQUIRMENT_KEY}').value = "";
    },
    setRVMRequirement: function () {
      $('${UI_INNER_RVM_EXIST_REQUIRMENT_KEY}').value = "%env.rvm_path%";
      $('${UI_INNER_RBENV_EXIST_REQUIRMENT_KEY}').value = "";
    },
    setRbEnvRequirement: function () {
      $('${UI_INNER_RVM_EXIST_REQUIRMENT_KEY}').value = "";
      $('${UI_INNER_RBENV_EXIST_REQUIRMENT_KEY}').value = "%env.RBENV_ROOT%";
    }
  };

  BS.RubyEC.prepareUI();
</script>
