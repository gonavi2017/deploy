<%@include file="/include.jsp"%>
<%@include file="mavenConsts.jsp"%>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>

<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>

<div class="parameter">
  POM file path: <props:displayValue name="pomLocation" emptyValue="not specified"/>
</div>

<div class="parameter">
  Goals: <props:displayValue name="goals" emptyValue="none specified"/>
</div>

<div class="parameter">
  <c:set var="mavenSelection" value="${propertiesBean.properties[MAVEN_SELECTION]}"/>
  Maven used:

  <c:choose>
    <c:when test="${MAVEN_SELECTION_CUSTOM eq mavenSelection}">
      <props:displayValue name="maven.home" emptyValue="not specified"/>
    </c:when>
    <c:when test="${MAVEN_SELECTION_BUNDLED_M2 eq mavenSelection}">
      bundled <c:out value="${BUNDLED_M2_FULL_VERSION}"/>
    </c:when>
    <c:when test="${MAVEN_SELECTION_BUNDLED_M3 eq mavenSelection}">
      bundled <c:out value="${BUNDLED_M3_FULL_VERSION}"/>
    </c:when>
    <c:when test="${MAVEN_SELECTION_BUNDLED_M3_1 eq mavenSelection}">
      bundled <c:out value="${BUNDLED_M3_1_FULL_VERSION}"/>
    </c:when>
    <c:when test="${MAVEN_SELECTION_BUNDLED_M3_2 eq mavenSelection}">
      bundled <c:out value="${BUNDLED_M3_2_FULL_VERSION}"/>
    </c:when>
    <c:otherwise>
      default
    </c:otherwise>
  </c:choose>

</div>

<div class="parameter">
  Additional Maven command line parameters: <props:displayValue name="runnerArgs" emptyValue="none specified"/>
</div>

<div class="parameter">
  <c:set var="settingsSelection" value="${propertiesBean.properties[USER_SETTINGS_SELECTION]}"/>
  User settings provided

  <c:choose>
    <c:when test="${(USER_SETTINGS_SELECTION_BY_PATH eq settingsSelection)} ">
      by path: <props:displayValue name="${USER_SETTINGS_PATH}" emptyValue="not specified"/>
    </c:when>
    <c:when test="${(USER_SETTINGS_SELECTION_DEFAULT eq settingsSelection) or (empty settingsSelection)}">
      by default
    </c:when>
    <c:otherwise>
      by content: <props:displayValue name="${USER_SETTINGS_SELECTION}" emptyValue="not specified"/>
    </c:otherwise>
  </c:choose>
</div>

<div class="parameter">
  Maven metadata disabled: <props:displayValue name="${disableMetadataProp}" emptyValue="false"/>
</div>

<div class="parameter">
  Use own local artifact repository: <props:displayValue name="${USE_OWN_LOCAL_REPO}" emptyValue="false"/>
</div>

<div class="parameter">
  Build only modules affected by changes (incremental building): <props:displayValue name="${IS_INCREMENTAL}" emptyValue="false"/>
</div>

<props:viewJavaHome/>

<div class="parameter">
  Build working directory: <props:displayValue name="teamcity.build.workingDir" emptyValue="not specified"/>
</div>

<props:viewJvmArgs/>
