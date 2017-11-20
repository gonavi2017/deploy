<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<props:displayIdeaSettingsValue />

<div class="parameter">
  Path to IDEA: <props:displayValue name="idea.app.home" emptyValue="use bundled"/>
</div>

<div class="parameter">
  Inspections profile path: <props:displayValue name="inspection.profile.file" emptyValue="not specified"/>
</div>

<div class="parameter">
  Inspections profile name: <props:displayValue name="inspection.profile.name" emptyValue="not specified"/>
</div>

<div class="parameter">
  Include / exclude patterns: <props:displayValue name="includeExclude.patterns" emptyValue="not specified"/>
</div>

<props:viewJvmArgs/>
