<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<c:set var="displayPserver" value="${
  empty propertiesBean.properties['cvs-root'] or
  fn:startsWith(propertiesBean.properties['cvs-root'], ':pserver:') ? true : false
}"/>

<c:set var="displayExt" value="${
  fn:startsWith(propertiesBean.properties['cvs-root'], ':ext:') ? true : false
}"/>

<c:set var="displaySsh" value="${
  fn:startsWith(propertiesBean.properties['cvs-root'], ':ssh:') ? true : false
}"/>

<c:set var="displayLocal" value="${
  (not empty propertiesBean.properties['cvs-root']) and (not fn:startsWith(propertiesBean.properties['cvs-root'], ':')) and (not fn:contains(propertiesBean.properties['cvs-root'], '%')) ? true : false
}"/>

<c:set var="displayUnknown" value="${
  (not displayPserver and not displayExt and not displaySsh and not displayLocal) ? true : false
}"/>

<table class="runnerFormTable">
<l:settingsGroup title="CVS Root">
<tr>
  <th><label for="module-name">Module name: <l:star/></label></th>
  <td><props:textProperty name="module-name" className="longField" />
      <span class="error" id="error_module-name"></span></td>
</tr>
<tr>
  <th><label for="cvs-root">CVS root: <l:star/></label></th>
  <td><select style="width:6em;" id="protocol" onchange="{
      var selectedValue = this.options[this.selectedIndex].value;

      $('pserverProtocol').style.display = 'none';
      $('extProtocol').style.display = 'none';
      $('sshProtocol').style.display = 'none';
      $('localProtocol').style.display = 'none';
      $('proxy').style.display = 'none';
      if (selectedValue == ':pserver:') {
        $('pserverProtocol').style.display = 'block';
        $('proxy').style.display = 'block';
      }
      if (selectedValue == ':ext:') {
        $('extProtocol').style.display = 'block';
      }
      if (selectedValue == ':ssh:') {
        $('sshProtocol').style.display = 'block';
        $('proxy').style.display = 'block';
      }
      if (selectedValue == '') {
        $('localProtocol').style.display = 'block';
      }

      if (selectedValue == 'unknown') {
        $('localProtocol').style.display = 'block';
        $('sshProtocol').style.display = 'block';
        $('pserverProtocol').style.display = 'block';
        $('extProtocol').style.display = 'block';
        $('proxy').style.display = 'block';
      }

      if (selectedValue != 'unknown') {
        if ($('cvs-root').value == '') {
          $('cvs-root').value = selectedValue;
        } else {
          $('cvs-root').value =$('cvs-root').value.replace(/^:[a-z]+:(.*)$/g, selectedValue + '$1');
          if ($('cvs-root').value.indexOf(selectedValue) == -1) {
            $('cvs-root').value = selectedValue + $('cvs-root').value;
          }
        }
      }

      BS.VisibilityHandlers.updateVisibility('mainContent');
    }">
      <props:option value=":pserver:" selected="${displayPserver}">pserver</props:option>
      <props:option value=":ext:" selected="${displayExt}">ext</props:option>
      <props:option value=":ssh:" selected="${displaySsh}">ssh</props:option>
      <props:option value="" selected="${displayLocal}">local</props:option>
    <c:if test="${displayUnknown}">
      <props:option value="unknown" selected="${displayUnknown}">unknown</props:option>
    </c:if>
    </select>
    <c:set var="onchange">
      var matchResult = this.value.match(/^:[a-z]+:/);
      if (matchResult) {
        var protocol = matchResult[0];
        for (var i=0; i < $('protocol').options.length; i++) {
          if ($('protocol').options[i].value == protocol) {
            $('protocol').selectedIndex = i;
            $('protocol').onchange();
            break;
          }
        }
      }
    </c:set>
    <props:textProperty name="cvs-root" style="width:24.5em" onchange="${onchange}"/>
    <span class="error" id="error_cvs-root"></span>

    <script type="text/javascript">
      BS.jQueryDropdown("#protocol");
    </script>
  </td>
</tr>
</l:settingsGroup>
<l:settingsGroup title="Checkout Options">
<tr>
  <c:set var="headMode" value="${propertiesBean.properties['cvs-tag-mode'] == 'HEAD'}"/>
  <c:set var="tagMode" value="${propertiesBean.properties['cvs-tag-mode'] == 'TAG'}"/>
  <c:set var="branchMode" value="${propertiesBean.properties['cvs-tag-mode'] == 'BRANCH'}"/>
  <c:set var="onclick">
    $('cvs-tag-name').disabled = true;
    $('cvs-branch-name').disabled = true;
    BS.VisibilityHandlers.updateVisibility('mainContent');
  </c:set>
  <th colspan="2"><props:radioButtonProperty name="cvs-tag-mode" id="cvs-tag-mode_HEAD" value="HEAD" onclick="${onclick}"/> <label for="cvs-tag-mode_HEAD">Checkout HEAD revision</label></th>
</tr>

<tr>
  <c:set var="onclick">
    $('cvs-tag-name').disabled = true;
    $('cvs-branch-name').disabled = false;
    $('cvs-branch-name').focus();
    BS.VisibilityHandlers.updateVisibility('mainContent');
  </c:set>
  <th><props:radioButtonProperty name="cvs-tag-mode" id="cvs-tag-mode_BRANCH" value="BRANCH" onclick="${onclick}"/> <label for="cvs-tag-mode_BRANCH">Checkout from branch: </label></th>
  <td><props:textProperty name="cvs-branch-name" className="longField"  disabled="${not branchMode}"/>
    <span class="error" id="error_cvs-branch-name"></span></td>
</tr>

<tr>
  <c:set var="onclick">
    $('cvs-tag-name').disabled = false;
    $('cvs-branch-name').disabled = true;
    $('cvs-tag-name').focus();
    BS.VisibilityHandlers.updateVisibility('mainContent');
  </c:set>
  <th><props:radioButtonProperty name="cvs-tag-mode" id="cvs-tag-mode_TAG" value="TAG" onclick="${onclick}"/> <label for="cvs-tag-mode_TAG">Checkout by tag: </label></th>
  <td><props:textProperty name="cvs-tag-name" className="longField"  disabled="${not tagMode}"/>
    <span class="error" id="error_cvs-tag-name"></span></td>
</tr>
<tr class="advancedSetting">
  <th><label for="cvs-quiet-period">Quiet period: </label><bs:help file="CVS" anchor="cvsQuietPeriodOptionDescription"/></th>
  <td><props:textProperty name="cvs-quiet-period" className="mediumField" maxlength="20"/> seconds
    <span class="error" id="error_cvs-quiet-period"></span></td>
</tr>

</l:settingsGroup>

<c:set var="cvsPassFileUsed" value="${not empty propertiesBean.properties['use-cvspass-file']}"/>
</table>

<!--The visibility of the following settings depends on the CVS root selection, hence the tables in the divs-->
<div id="pserverProtocol" style="${displayPserver or displayUnknown ? '' : 'display: none;'}">
<table class="runnerFormTable">
  <l:settingsGroup title="PServer Protocol Settings">
  <tr>
    <c:set var="onclick">
      $('secure:cvs-password').disabled = !this.checked;
      $('cvspass-file').disabled = this.checked;
      if (this.checked) {
        $('secure:cvs-password').focus();
      }

      BS.VisibilityHandlers.updateVisibility('mainContent');
    </c:set>
    <th><props:radioButtonProperty checked="${not cvsPassFileUsed}" name="use-cvspass-file"
                                 id="use-cvspass-file1" value=""
                                 onclick="${onclick}"/>
      <label for="use-cvspass-file1">CVS password:</label></th>
    <td><props:passwordProperty name="secure:cvs-password" className="longField"  disabled="${cvsPassFileUsed}"/>
    <span class="error" id="error_secure:cvs-password"></span>
    </td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('secure:cvs-password').disabled = this.checked;
      $('cvspass-file').disabled = !this.checked;
       if (this.checked) {
         $('cvspass-file').focus();
       }

      BS.VisibilityHandlers.updateVisibility('mainContent');
    </c:set>
    <th><props:radioButtonProperty checked="${cvsPassFileUsed}" name="use-cvspass-file"
                                 id="use-cvspass-file2" value="true"
                                 onclick="${onclick}"/>
      <label for="use-cvspass-file2">Password file path:</label></th>
    <td><props:textProperty name="cvspass-file" className="longField"  disabled="${not cvsPassFileUsed}"/>
    <span class="error" id="error_cvspass-file"></span></td>
  </tr>
  <tr class="advancedSetting">
    <th><label for="connection-timeout">Connection timeout:</label></th>
    <td><props:textProperty name="connection-timeout" size="10" maxlength="20" className="mediumField"/><span> seconds</span>
    <span class="error" id="error_connection-timeout"></span></td>
  </tr>
</l:settingsGroup>
</table>
</div>

<div id="extProtocol" style="${displayExt or displayUnknown ? '' : 'display: none;'}">
 <table class="runnerFormTable">
   <l:settingsGroup title="Ext Protocol Settings">
  <tr>
    <th><label for="ext-rsh">Path to external rsh:</label></th>
    <td><props:textProperty name="ext-rsh" className="longField" />
    <span class="error" id="error_ext-rsh"></span></td>
  </tr>
  <tr>
    <th><label for="ext-ppk-file">Path to private key file:</label></th>
    <td><props:textProperty name="ext-ppk-file" className="longField" />
    <span class="error" id="error_ext-ppk-file"></span></td>
  </tr>
  <tr>
    <th><label for="ext-additional-parameters">Additional parameters:</label></th>
    <td><props:textProperty name="ext-additional-parameters" className="longField" />
    <span class="error" id="error_ext-additional-parameters"></span></td>
  </tr>
  </l:settingsGroup>
 </table>

</div>

<c:set var="privateKeyFileUsed" value="${not empty propertiesBean.properties['ssh-path-to-ppk']}"/>

<div id="sshProtocol" style="${displaySsh or displayUnknown ? '' : 'display: none;'}">
  <table class="runnerFormTable">
  <l:settingsGroup title="SSH Protocol Settings (internal implementation)">

  <tr class="advancedSetting">
    <th><label for="ssh-type">SSH version:</label></th>
    <td><props:selectProperty id="ssh-type" name="ssh-type" enableFilter="true" className="mediumField">
      <props:option value="">Allow both: ssh1 and ssh2</props:option>
      <props:option value="ssh1">Force ssh1</props:option>
      <props:option value="ssh2">Force ssh2</props:option>
    </props:selectProperty></td>
  </tr>
  <tr class="advancedSetting">
    <th><label for="ssh-port">SSH port: <l:star/></label></th>
    <td><props:textProperty name="ssh-port" maxlength="40" className="mediumField"/>
    <span class="error" id="error_ssh-port"></span></td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('secure:ssh-password').disabled = !this.checked;
      $('ssh-path-to-ppk').disabled = this.checked;
      $('secure:ssh-ppk-password').disabled = this.checked;
      if (this.checked) {
        $('secure:ssh-password').focus();
      }

      BS.VisibilityHandlers.updateVisibility('mainContent');
    </c:set>
    <th><props:radioButtonProperty name="ssh-use-ppk" value="false" checked="${not privateKeyFileUsed}" id="ssh-use-ppk_1" onclick="${onclick}"/>
    <label for="ssh-use-ppk_1">SSH password:</label></th>
    <td><props:passwordProperty name="secure:ssh-password" className="longField"  disabled="${privateKeyFileUsed}"/>
    <span class="error" id="error_secure:ssh-password"></span></td>
  </tr>
  <tr>
    <c:set var="onclick">
      $('secure:ssh-password').disabled = this.checked;
      $('ssh-path-to-ppk').disabled = !this.checked;
      $('secure:ssh-ppk-password').disabled = !this.checked;
      if (this.checked) {
        $('ssh-path-to-ppk').focus();
      }

      BS.VisibilityHandlers.updateVisibility('mainContent');
    </c:set>
    <th><props:radioButtonProperty name="ssh-use-ppk" value="true" checked="${privateKeyFileUsed}" id="ssh-use-ppk_2" onclick="${onclick}" />
    <label for="ssh-use-ppk_2">Private key</label></th>
    <td>
    <label for="ssh-path-to-ppk" class="fixedLabel">File path:</label>
      <props:textProperty name="ssh-path-to-ppk"  className="mediumField" disabled="${not privateKeyFileUsed}"/>
      <span class="error" id="error_ssh-path-to-ppk"></span>
    <br/>
    <label for="secure:ssh-ppk-password" class="fixedLabel">Password:</label>
      <props:passwordProperty name="secure:ssh-ppk-password" className="mediumField" disabled="${not privateKeyFileUsed}"/>
      <span class="error" id="error_secure:ssh-ppk-password"></span>
    </td>
  </tr>
  </l:settingsGroup>
  </table>
</div>

<div id="localProtocol" style="${displayLocal or displayUnknown ? '' : 'display: none;'}">
  <table class="runnerFormTable">
    <l:settingsGroup title="Local CVS settings">
    <tr>
      <th><label for="local-path-to-client">Path to CVS client:</label></th>
      <td><props:textProperty name="local-path-to-client" className="longField" />
        <span class="error" id="error_local-path-to-client"></span></td>
    </tr>
    <tr>
      <th><label for="local-server-command">Server command:</label></th>
      <td><props:textProperty name="local-server-command" className="longField" />
            <span class="error" id="error_local-server-command"></span></td>
    </tr>
    </l:settingsGroup>
  </table>
</div>

<c:set var="displayProxy" value="${displayPserver or displaySsh or displayUnknown}"/>
<c:set var="proxyUsed" value="${not empty propertiesBean.properties['use-proxy']}"/>

<div id="proxy" style="${displayProxy or displayUnknown ? '' : 'display: none;'}">

  <table class="runnerFormTable advancedSetting">
    <l:settingsGroup title="Proxy Settings">

    <tr>
      <th>
        <props:checkboxProperty name="use-proxy" onclick="{
      var form = this.form;
      for (var i=0; i<form.elements.length; i++) {
        var control = form.elements[i];
        if (control.id && control.id.indexOf('proxy-') != -1) {
          control.disabled = !this.checked;
        }
      }
      BS.VisibilityHandlers.updateVisibility('mainContent');
    }" checked="${proxyUsed}"/> <label for="use-proxy">Use proxy</label></th>
    <td><props:selectProperty name="proxy-type" id="proxy-type" enableFilter="true" disabled="${not proxyUsed}" className="mediumField">
          <props:option value="">HTTP</props:option>
          <props:option value="socks4">Socks 4</props:option>
          <props:option value="socks5">Socks 5</props:option>
        </props:selectProperty></td>
    </tr>

    <tr>
      <th><label for="proxy-host">Proxy host: <l:star/></label></th>
      <td><props:textProperty name="proxy-host" className="longField"  disabled="${not proxyUsed}"/>
      <span class="error" id="error_proxy-host"></span></td>
    </tr>

    <tr>
      <th><label for="proxy-port">Proxy port: <l:star/></label></th>
      <td><props:textProperty name="proxy-port" className="longField" maxlength="128" disabled="${not proxyUsed}"/>
        <span class="error" id="error_proxy-port"></span></td>
    </tr>

    <tr>
      <th><label for="proxy-login">Login:</label></th>
      <td><props:textProperty name="proxy-login" className="longField"  disabled="${not proxyUsed}"/>
      <span class="error" id="error_proxy-login"></span></td>
    </tr>

    <tr>
      <th><label for="secure:proxy-password">Password:</label></th>
      <td><props:passwordProperty name="secure:proxy-password" className="longField"  disabled="${not proxyUsed}"/>
      <span class="error" id="error_secure:proxy-password"></span></td>
    </tr>

    </l:settingsGroup>
  </table>
</div>

<table class="runnerFormTable advancedSetting">
  <l:settingsGroup title="Advanced Options">
  <tr>
    <th colspan="2">
      <props:checkboxProperty name="zip-compression"/>
      <label for="zip-compression">Use GZIP compression</label></th>
  </tr>

  <tr>
    <th colspan="2">
      <props:checkboxProperty name="cvs-send-env"/>
      <label for="cvs-send-env">Send all environment variables to the CVS server</label></th>
  </tr>

  <tr>
    <th colspan="2" class="noBorder">
      <props:checkboxProperty name="history-supported"/>
      <label for="history-supported">History command supported</label></th>
  </tr>
</l:settingsGroup>
</table>
