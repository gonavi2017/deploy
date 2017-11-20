<%--
  ~ Copyright 2000-2010 JetBrains s.r.o.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing, software
  ~ distributed under the License is distributed on an "AS IS" BASIS,
  ~ WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  ~ See the License for the specific language governing permissions and
  ~ limitations under the License.
  --%>

<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<jsp:useBean id="constants" class="jetbrains.buildServer.dotnetTools.server.inspectCode.InspectCodeConstantsBean"/>

<div class="parameter">
  Path to inspectCode.exe home: <jsp:include page="/tools/selector.html?name=${constants.cltPathKey}&class=longField&view=1"/>
</div>

<div class="parameter">
  <ul style="list-style: none; padding-left: 0; margin-left: 0; margin-top: 0.1em; margin-bottom: 0.1em;">
    <li>Solution file path: <strong><props:displayValue name="${constants.solutionPathKey}" emptyValue="not specified"/></strong></li>
  </ul>
</div>

<div class="parameter">
  <ul style="list-style: none; padding-left: 0; margin-left: 0; margin-top: 0.1em; margin-bottom: 0.1em;">
    <li>Projects to analyze: <strong><props:displayValue name="${constants.projectFilerKey}" emptyValue="all"/></strong></li>
  </ul>
</div>

<div class="parameter">
  <ul style="list-style: none; padding-left: 0; margin-left: 0; margin-top: 0.1em; margin-bottom: 0.1em;">
    <li>Custom settings profile path: <strong><props:displayValue name="${constants.customSettingsProfilePathKey}" emptyValue="not specified"/></strong></li>
  </ul>
</div>

<div class="parameter">
  Enable debug messages: <strong><props:displayCheckboxValue name="${constants.debugKey}"/></strong>
</div>

<div class="parameter">
  Additional inspectCode.exe arguments: <strong><props:displayValue name="${constants.customCommandlineKey}" showInPopup="${true}"/></strong>
</div>
