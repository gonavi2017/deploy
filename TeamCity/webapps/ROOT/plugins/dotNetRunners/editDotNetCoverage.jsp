<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"  %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="coverage" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageTypeForm"/>
<jsp:useBean id="cbean" scope="request" type="jetbrains.buildServer.dotNetCoverage.CoverageBean"/>
<jsp:useBean id="teamcityPluginResourcesPath" scope="request" type="java.lang.String"/>

<l:settingsGroup title=".NET Coverage">

<c:set var="toolsTitle">.NET Coverage tool:<bs:help file="Configuring+.NET+Code+Coverage"/></c:set>
<c:set var="toolsNote">
  <span class="smallNote">Choose a .NET coverage tool.</span>
  <c:if test="${cbean.showWarningOnCoverageLimitations}">
    <span class="tc-icon_before icon16 tc-icon_attention smallNoteAttention">
      Test code coverage is supported only for NUnit tests run using
      TeamCity facilities.<bs:help anchor="Configuring.NETCodeCoverage-coverageSupportNAntMSBuild" file="Configuring+.NET+Code+Coverage"/>
    </span>
  </c:if>
</c:set>
<props:selectSectionProperty name="${cbean.coverageToolNameField}" title="${toolsTitle}" note="${toolsNote}">
  <props:selectSectionPropertyContent value="" caption="<No .NET Coverage>"/>

  <c:forEach items="${coverage.types}" var="type">
    <props:selectSectionPropertyContent value="${type.id}" caption="${type.name}">
      <jsp:include page="${teamcityPluginResourcesPath}/${type.editPage}" />
    </props:selectSectionPropertyContent>
  </c:forEach>
</props:selectSectionProperty>

</l:settingsGroup>