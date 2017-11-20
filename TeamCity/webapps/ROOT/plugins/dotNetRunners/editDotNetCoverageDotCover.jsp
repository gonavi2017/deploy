<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"  %>
<jsp:useBean id="cns" scope="request" class="jetbrains.buildServer.dotNetCoverage.dotCover.DotCoverConstants"/>

<jsp:include page="/tools/editToolUsage.html?toolType=${cns.cltToolTypeName}&versionParameterName=${cns.dotCoverHome}&class=longField"/>

<tr>
  <th><label for="${cns.dotCoverFilters}">Filters:</label></th>
  <td>
    <c:set var="note">
      Specify a new-line separated list of filters for code coverage. Use the <i>+:myassemblyName</i> or <i>-:myassemblyName</i> syntax to
      include or exclude an assembly (by name, without extension) from code coverage. Use asterisk (*) as a wildcard if needed.<bs:help file="JetBrains+dotCover"/>
    </c:set>
    <props:multilineProperty name="${cns.dotCoverFilters}" className="longField" expanded="true" cols="60" rows="4" linkTitle="Assemblies Filters" note="${note}"/>
  </td>
</tr>

<tr>
  <th><label for="${cns.dotCoverAttributeFilters}">Attribute Filters:</label></th>
  <td>
    <c:set var="note">
      Specify a new-line separated list of attribute filters for code coverage. Use the <i>-:attributeName</i> syntax to exclude a code marked with attributes from code coverage. Use asterisk (*) as a wildcard if needed.<bs:help file="JetBrains+dotCover"/>
    </c:set>
    <props:multilineProperty name="${cns.dotCoverAttributeFilters}" className="longField" cols="60" rows="4" linkTitle="Attribute Filters" note="${note}"/>
    <span class="smallNote"><strong>Supported only with dotCover 2.0 or newer</strong></span>
  </td>
</tr>

<tr class="advancedSetting">
  <th><label for="${cns.customCommandline}">Additional dotCover.exe arguments:</label></th>
  <td>
    <props:multilineProperty name="${cns.customCommandline}" linkTitle="Edit command line" cols="60" rows="5" />
    <span class="smallNote">Additional commandline parameters to add to calling dotCover.exe separated by new lines.</span>
    <span id="error_${cns.customCommandline}" class="error"></span>
  </td>
</tr>
