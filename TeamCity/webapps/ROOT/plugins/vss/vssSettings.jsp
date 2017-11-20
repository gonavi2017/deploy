<%@include file="/include.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<table class="runnerFormTable">
<l:settingsGroup title="VSS Settings">
  <tr>
    <th><label for="ini-path">Path to srcsafe.ini: <l:star/></label></th>
    <td>
      <props:textProperty name="ini-path" className="longField" />
      <span class="error" id="error_ini-path"></span>
      <span class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">Full path to VSS configuration file (srcsafe.ini)</span>
    </td>
  </tr>
  <tr>
    <th><label for="module-name">Project: <l:star/></label></th>
    <td>
      <props:textProperty name="module-name" className="longField" />
      <span class="error" id="error_module-name"></span>
    </td>
  </tr>
  <tr>
    <th><label for="vss-username">Username: <l:star/></label></th>
    <td>
      <props:textProperty name="vss-username" className="longField" />
      <span class="error" id="error_vss-username"></span>
    </td>
  </tr>
  <tr>
    <th><label for="secure:vss-password">Password: <l:star/></label></th>
    <td>
      <props:passwordProperty name="secure:vss-password" className="longField" />
      <span class="error" id="error_secure:vss-password"></span>
    </td>
  </tr>
  <tr>
    <th class="noBorder"><label for="vss-use-ssexe-patch">Checkout options:</label></th>
    <td class="noBorder">
      <props:checkboxProperty name="vss-use-ssexe-patch"/>
        <label for="vss-use-ssexe-patch">Perform full checkout on every build</label>
        <span class="error" id="error_vss-use-ssexe-patch"></span>
    </td>
  </tr>
</l:settingsGroup>
</table>
