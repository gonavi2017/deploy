<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.runner.MSBuild.SolutionBean"/>

<div class="parameter">
  Solution file path: <props:displayValue name="${bean.buildFilePathKey}" emptyValue="not specified"/>
</div>

<props:viewWorkingDirectory/>

<div class="parameter">
  Visual Studio:
  <strong>
    <c:set var="vs" value="${propertiesBean.properties[bean.solutionVersionKey]}"/>
    <c:forEach var="item" items="${bean.solutionVersions}">
      <c:if test="${vs eq item.value}"><c:out value="${item.description}"/></c:if>
    </c:forEach>
  </strong>
</div>

<div class="parameter">
  Targets: <props:displayValue name="${bean.targetsKey}" emptyValue="none specified"/>
</div>

<div class="parameter">
  Configuration: <props:displayValue name="${bean.configurationKey}" emptyValue="default"/>
</div>

<div class="parameter">
  Platform: <props:displayValue name="${bean.platformKey}" emptyValue="default"/>
</div>

<div class="parameter">
  Command line parameters: <props:displayValue name="${bean.runnerArgsKey}" emptyValue="none specified"/>
</div>
