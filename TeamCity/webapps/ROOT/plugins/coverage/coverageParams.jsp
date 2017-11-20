<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="coverageRunners" scope="request" type="java.util.Collection"/>
<c:if test="${not empty coverageRunners}">
<script type="text/javascript">
  window.coverageRunnerChanged = function(select) {
    var selectedRunner = select.options[select.selectedIndex].value;
    var paramsElems = findParentTable(select).select('.coverageParams');
    for (var i=0; i<paramsElems.length; i++) {
      var elem = paramsElems[i];
      if (selectedRunner == "" || elem.className.indexOf(selectedRunner) == -1) {
        BS.Util.hide(elem);
      } else {
        BS.Util.show(elem);
      }
    }

    BS.MultilineProperties.updateVisible();
  };

  window.findParentTable = function(startFrom) {
    var parentEl = startFrom.parentNode;
    while (parentEl != null) {
      if (parentEl.nodeType == 1 && parentEl.tagName == 'TABLE') {
        return Element.extend(parentEl);
      }
      parentEl = parentEl.parentNode;
    }

    return null;
  }
</script>
<l:settingsGroup title="Code Coverage">
<tr>
  <th class="noBorder"><label for="teamcity.coverage.runner">Choose coverage runner:</label></th>
  <td class="noBorder">
    <props:selectProperty name="teamcity.coverage.runner" onchange="coverageRunnerChanged(this)" enableFilter="true" className="mediumField">
      <props:option value="">&lt;No coverage></props:option>
      <c:forEach items="${coverageRunners}" var="cr">
        <props:option value="${cr.name}"><c:out value="${cr.displayName}"/></props:option>
      </c:forEach>
    </props:selectProperty>
  </td>
</tr>
<c:set var="display"><c:if test="${propertiesBean.properties['teamcity.coverage.runner'] != 'EMMA'}">style="display: none"</c:if></c:set>
<tr class="coverageParams EMMA" ${display}>
  <th></th>
  <td>
    <span class="smallNote">Emma is out of date and it does not support Java 8. Consider using IntelliJ IDEA or JaCoCo coverage runners.</span>
    <span class="smallNote">
      <c:if test="${not empty buildForm and not empty buildForm.buildRunnerBean and buildForm.buildRunnerBean.runTypeInfoKey == 'Ant'}">
        Add a 'clean' target to your Ant build for this coverage runner to work.
      </c:if>
      Do not use the EMMA coverage runner for production builds since it will result in EMMA-instrumented class files.</span>
    <br/>
    <props:checkboxProperty name="teamcity.coverage.emma.include.source"/>
    <label for="teamcity.coverage.emma.include.source">Include source files in the coverage data</label>
  </td>
</tr>
<tr class="coverageParams EMMA" ${display}>
  <th><label for="teamcity.coverage.emma.instr.parameters">Coverage instrumentation parameters:</label></th>
  <td>
    <props:textProperty name="teamcity.coverage.emma.instr.parameters" className="longField"/>
      <span class="smallNote">
    You can provide a filter for classes included into code coverage. See the
    <a target="_blank" showdiscardchangesmessage="false"
       href="http://emma.sourceforge.net/reference_single/reference.html#tool-ref.instr.cmdline">EMMA documentation</a> for details.
  </span>

  </td>
</tr>
<c:set var="display"><c:if test="${propertiesBean.properties['teamcity.coverage.runner'] != 'IDEA'}">style="display: none"</c:if></c:set>
<c:if test="${not empty buildForm and not empty buildForm.buildRunnerBean and buildForm.buildRunnerBean.runTypeInfoKey == 'Maven2'}">
<tr class="coverageParams IDEA" ${display}>
  <th></th>
  <td><span class="smallNote">To evaluate the coverage correctly, the build should start tests with Surefire 2.4 or higher.
    Make sure that the <b>fork mode</b> is not off.</span></td>
</tr>
</c:if>
<tr class="coverageParams IDEA" ${display}>
  <th><label for="teamcity.coverage.idea.includePatterns">Classes to instrument:</label><l:star/></th>
  <td>
    <c:set var="note">Newline-separated patterns for fully qualified class names to be analyzed by code coverage.
      A pattern should start with a valid package name and can contain a wildcard, for example: <strong>org.apache.*</strong></c:set>
    <props:multilineProperty name="teamcity.coverage.idea.includePatterns" linkTitle="Type include patterns" expanded="true" cols="40" rows="3" className="longField" note="${note}"/>
  </td>
</tr>
<tr class="coverageParams IDEA" ${display}>
  <th><label for="teamcity.coverage.idea.includePatterns">Classes to exclude from instrumentation:</label></th>
  <td>
    <c:set var="note">
      Newline-separated patterns for fully qualified class names to be excluded from the coverage.
      Exclude patterns have priority over include patterns.</c:set>
    <props:multilineProperty name="teamcity.coverage.idea.excludePatterns" linkTitle="Type exclude patterns" expanded="true" cols="40" rows="3" className="longField" note="${note}"/>
  </td>
</tr>
<c:set var="display"><c:if test="${propertiesBean.properties['teamcity.coverage.runner'] != 'JACOCO'}">style="display: none"</c:if></c:set>
  <tr class="coverageParams JACOCO" ${display}>
    <th><label for="teamcity.coverage.jacoco.classpath">Classfile directories or jars:</label><l:star/></th>
    <td>
      <c:set var="note">Newline-delimited set of path patterns in the form of +|-:[path] to scan for classfiles
        to be analyzed. Make sure the path is valid. Excluding libraries and test classes from analysis is recommended.
        Ant like patterns are supported, e.g.: '+:build/main/**/*.class'</c:set>
      <props:multilineProperty name="teamcity.coverage.jacoco.classpath" linkTitle="Type classfile directories or jars" expanded="true" cols="40" rows="3" className="longField" note="${note}"/>
    </td>
  </tr>
<tr class="coverageParams JACOCO" ${display}>
  <th><label for="teamcity.coverage.jacoco.patterns">Classes to instrument:</label></th>
  <td>
    <c:set var="note">
      Newline-delimited set of patterns in the form of +|-:[pattern] of classes to analyze.
      Leave default or blank for small projects or if performance is not an issue.  Wildcards are supported,
      e.g. '+:com.*:+:org.*'.</c:set>
    <props:multilineProperty name="teamcity.coverage.jacoco.patterns" linkTitle="Type class patterns" expanded="true" cols="40" rows="3" className="longField" note="${note}"/>
  </td>
</tr>
</l:settingsGroup>
<script type="text/javascript">
  coverageRunnerChanged($('teamcity.coverage.runner'));
</script>
</c:if>
