<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="appleData" scope="request" type="jetbrains.buildServer.runner.appCode.data.AppleData"/>

<div class="parameter">
  Path to the project or workspace:
  <strong><props:displayValue name="project" emptyValue="Not specified"/></strong>
</div>
<div class="parameter">
  Path to Xcode:
  <strong><props:displayValue name="xcodePath" emptyValue="Not specified"/></strong>
</div>
<props:viewWorkingDirectory/>
<c:set var="isXcode3" value="${propertiesBean.properties['xcode'] eq '3'}"/>
<c:if test="${isXcode3}">
  <div class="parameter">
    Build: <strong>Target-based</strong>
  </div>
  <div class="parameter">
    Target:
    <strong>
      <c:choose>
        <c:when test="${propertiesBean.properties['target'] == '###default###'}">Default</c:when>
        <c:otherwise><props:displayValue name="target" emptyValue="Not specified"/></c:otherwise>
      </c:choose>
    </strong>
  </div>
  <div class="parameter">
    Configuration:
    <strong>
      <c:choose>
        <c:when test="${propertiesBean.properties['configuration'] == '###default###'}">Default</c:when>
        <c:otherwise><props:displayValue name="configuration" emptyValue="Not specified"/></c:otherwise>
      </c:choose>
    </strong>
  </div>
  <c:set var="platformId" value="${propertiesBean.properties['platform']}"/>
  <c:set var="isDefaultPlatform" value="${empty platformId or (platformId eq 'default')}"/>
  <c:set var="platformName" value="Default"/>
  <c:if test="${!isDefaultPlatform}">
    <c:set var="platform" value="${appleData.platformMap[platformId]}"/>
    <c:set var="platformName" value="${platform == null ? platformId : platform.name}"/>
  </c:if>
  <div class="parameter">
    Platform:
    <strong><c:out value="${platformName}"/></strong>
  </div>
  <c:forEach items='<%=new String[] { "sdk", "arch" }%>' var="propName">
    <c:set var="itemId" value="${propertiesBean.properties[propName]}"/>
    <c:set var="isDefaultItem" value="${empty itemId or (itemId eq 'default')}"/>
    <c:set var="itemName" value="Default"/>
    <c:if test="${!isDefaultPlatform and !isDefaultItem}">
      <c:set var="item" value="${platform == null ? null : (propName eq 'sdk' ? platform.sdkMap[itemId] : platform.archMap[itemId])}"/>
      <c:set var="itemName" value="${item == null ? itemId : item.name}"/>
    </c:if>
    <div class="parameter">
      ${propName eq "sdk" ? "SDK" : "Architecture"}:
      <strong><c:out value="${itemName}"/></strong>
    </div>
  </c:forEach>
</c:if>
<c:if test="${!isXcode3}">
  <div class="parameter">
    Build: <strong>Scheme-based</strong>
  </div>
  <div class="parameter">
    Scheme:
    <strong><props:displayValue name="scheme" emptyValue="Not specified"/></strong>
  </div>
  <div class="parameter">
    Use custom build output directory:
    <strong><props:displayCheckboxValue name="useCustomBuildOutputDir"/></strong>
  </div>
  <c:if test="${propertiesBean.properties['useCustomBuildOutputDir'] eq 'true'}">
    <div class="parameter">
      Custom build output directory:
      <strong><props:displayValue name="customBuildOutputDir" emptyValue="."/></strong>
    </div>
  </c:if>
</c:if>
<div class="parameter">
  Build action(s):
  <strong><props:displayValue name="buildActions" emptyValue="Not specified"/></strong>
</div>
<div class="parameter">
  Run tests:
  <strong><props:displayCheckboxValue name="runTests"/></strong>
</div>
<div class="parameter">
  Additional command line parameters:
  <strong><props:displayValue name="additionalCommandLineParameters" emptyValue="Not specified"/></strong>
</div>
