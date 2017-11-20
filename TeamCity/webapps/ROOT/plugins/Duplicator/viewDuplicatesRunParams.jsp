<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<props:displayIdeaSettingsValue />

<div class="parameter">
  Path to IDEA: <props:displayValue name="idea.app.home" emptyValue="use bundled"/>
</div>

<div class="parameter">
  Include test sources: <strong><props:displayCheckboxValue name="duplicates.runner.include.tests"/></strong>
</div>

<div class="parameter">
  Include / exclude patterns: <props:displayValue name="includeExclude.patterns" emptyValue="not specified"/>
</div>

<div class="parameter">
  Detalization level:
</div>

<div class="nestedParameter">
  <ul style="list-style: none; padding-left: 0; margin-left: 0; margin-top: 0.1em; margin-bottom: 0.1em;">
    <li>distinguish variables: <strong><props:displayCheckboxValue name="duplicates.runner.variable"/></strong></li>
    <li>distinguish fields: <strong><props:displayCheckboxValue name="duplicates.runner.field"/></strong></li>
    <li>distinguish methods: <strong><props:displayCheckboxValue name="duplicates.runner.method"/></strong></li>
    <li>distinguish types: <strong><props:displayCheckboxValue name="duplicates.runner.type"/></strong></li>
    <li>distinguish literals: <strong><props:displayCheckboxValue name="duplicates.runner.literal"/></strong></li>
  </ul>
</div>

<div class="parameter">
  Ignore duplicates with complexity simpler than: <strong><props:displayValue name="duplicates.runner.bound" emptyValue="not specified"/></strong>
</div>

<div class="parameter">
  Ignore duplicate subexpressions with complexity simpler than: <strong><props:displayValue name="duplicates.runner.discard" emptyValue="not specified"/></strong>
</div>

<div class="nestedParameter">
  Check if subexpression can be extracted: <strong><props:displayCheckboxValue name="duplicates.runner.visibility"/></strong>
</div>

<props:viewJvmArgs/>

