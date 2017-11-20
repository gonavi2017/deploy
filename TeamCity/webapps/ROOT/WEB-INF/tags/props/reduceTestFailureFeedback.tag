<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="props" tagdir="/WEB-INF/tags/props"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ attribute name="showRecentlyFailed" required="false" type="java.lang.Boolean"
  %><%@ attribute name="showRunNewAndModified" required="false" type="java.lang.Boolean"
  %><%@ attribute name="showDepsBasedTestRun" required="false" type="java.lang.Boolean" %>
<jsp:useBean id="propertiesBean" type="jetbrains.buildServer.controllers.BasePropertiesBean" scope="request"/>
<c:set var="propName" value="teamcity.tests.runRiskGroupTestsFirst"/>
<c:set var="propValue" value="${propertiesBean.properties[propName]}"/>
<c:set var="recentlyFailedGroup" value="recentlyFailed"/>
<c:set var="newAndModifiedGroup" value="newAndModified"/>
<c:set var="affectedTestsDepsBasedGroup" value="affectedTestsDependencyBased"/>
<script type="text/javascript">
  BS = BS || {};
  BS.ReduceTestFailure = BS.ReduceTestFailure || {};
  BS.ReduceTestFailure.enableOrDisableGroup = function(checkbox, groupName) {
    var value = $('${propName}').value;

    if (checkbox.checked) {
      if (value.indexOf(groupName) != -1) return;

      if (value.length == 0) {
        $('${propName}').value = groupName;
      } else {
        $('${propName}').value = value + "," + groupName;
      }
    } else {
      var groups = value.split(',');

      var newValue = '';

      for (var i=0; i<groups.length; i++) {
        if (groupName == groups[i]) continue;
        if (newValue.length > 0) {
          newValue += ',';
        }
        newValue += groups[i];
      }

      $('${propName}').value = newValue;
    }
  }
</script>
<tr class="advancedSetting">
  <th>
    Reduce test failure feedback time:
  </th>
  <td>
    <props:hiddenProperty name="${propName}"/>
<c:if test="${showRecentlyFailed}">
  <div>
    <forms:checkbox id="${recentlyFailedGroup}Group"
                    name=""
                    checked="${fn:contains(propValue, recentlyFailedGroup)}"
                    onclick="BS.ReduceTestFailure.enableOrDisableGroup(this, '${recentlyFailedGroup}')"/>
    <label for="${recentlyFailedGroup}Group">Run recently failed tests first</label>
    </div>
</c:if>
<c:if test="${showRunNewAndModified}">
  <div>
    <forms:checkbox id="${newAndModifiedGroup}Group"
                    name=""
                    checked="${fn:contains(propValue, newAndModifiedGroup)}"
                    onclick="BS.ReduceTestFailure.enableOrDisableGroup(this, '${newAndModifiedGroup}')"/>
    <label for="${newAndModifiedGroup}Group">Run new and modified tests first</label>
  </div>
</c:if>
<c:if test="${showDepsBasedTestRun}">
  <div>
    <forms:checkbox id="${affectedTestsDepsBasedGroup}Group"
                    name=""
                    checked="${fn:contains(propValue, affectedTestsDepsBasedGroup)}"
                    onclick="BS.ReduceTestFailure.enableOrDisableGroup(this, '${affectedTestsDepsBasedGroup}')"/>
    <label for="${affectedTestsDepsBasedGroup}Group">Run affected tests only (dependency based)</label>
  </div>
</c:if>
  </td>
</tr>
<script type="text/javascript">
  if ($('${propName}').className.indexOf('valueChanged') != -1) {
    $('${propName}').parentNode.className += ' valueChanged';
  }
</script>