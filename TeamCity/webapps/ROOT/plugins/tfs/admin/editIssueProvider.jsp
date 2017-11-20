<%@ include file="/include.jsp" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<jsp:useBean id="cons" class="jetbrains.buildServer.issueTracker.tfs.TfsIssueConstants"/>

<div>
  <table class="editProviderTable">
    <c:if test="${showType}">
      <tr>
        <th><label class="shortLabel">Connection Type:</label></th>
        <td>${cons.longName}</td>
      </tr>
    </c:if>
    <tr>
      <th><label for="${cons.propertyName}" class="shortLabel">Display Name: <l:star/></label></th>
      <td>
        <props:textProperty name="${cons.propertyName}" maxlength="100"/>
        <span id="error_${cons.propertyName}" class="error"></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyHost}" class="shortLabel">Server URL: <l:star/></label></th>
      <td>
        <props:textProperty name="${cons.propertyHost}"/>
        <span id="error_${cons.propertyHost}" class="error"></span>
        <span class="fieldExplanation">
          http[s]://&lt;host&gt;:&lt;port&gt;/tfs/&lt;collection&gt;/&lt;project&gt; or<br/>
          https://&lt;account&gt;.visualstudio.com/&lt;project&gt;</span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyUsername}" class="shortLabel">Username:</label></th>
      <td>
        <props:textProperty name="username" maxlength="100"/>
        <span id="error_username" class="error"></span>
        <span class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">Leave blank to use the TeamCity user account</span>
        <span class="fieldExplanation">For VSTS use alternate credentials or tokens
          <bs:help file="Team+Foundation+Server" anchor="vsts"/></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyPassword}" class="shortLabel">Password:</label></th>
      <td>
        <props:passwordProperty name="${cons.propertyPassword}" maxlength="100"/>
        <span id="error_${cons.propertyPassword}" class="error"></span>
      </td>
    </tr>
    <tr>
      <th><label for="${cons.propertyPattern}" class="shortLabel">Pattern: <l:star/></label></th>
      <td>
        <props:textProperty name="${cons.propertyPattern}" maxlength="100"/>
        <span id="error_${cons.propertyPattern}" class="error"></span>
        <span class="fieldExplanation">Use general regexp, e.g. #(\d+) <bs:help file="Integrating+TeamCity+with+Issue+Tracker"/></span>
      </td>
    </tr>
  </table>
</div>

<script type="text/javascript">
  $j(document).ready(function () {
    if (!$('${cons.propertyPattern}').value) {
      $('${cons.propertyPattern}').value = '#(\\d+)';
    }

    // if we have received some init values
    // var params = window.location.search.toQueryParams();
    var params = BS.IssueProviderForm.initOptions;
    if (params && params['addTracker']) {
      $('${cons.propertyName}').value = decodeURIComponent(params['name']);
      $('${cons.propertyHost}').value = decodeURIComponent(params['serverUrl']);
    }
  });
</script>
