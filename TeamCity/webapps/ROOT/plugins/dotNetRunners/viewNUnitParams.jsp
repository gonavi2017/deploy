<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="bean" class="jetbrains.buildServer.dotNet.nunit.server.NUnitBean"/>

<c:if test="${not empty propertiesBean.properties[bean.NUnitEnabledKey]}">
  <div class="parameter">
    NUnit runner:
    <strong>
      <c:set var="type" value="${propertiesBean.properties[bean.NUnitVersionKey]}"/>
      <c:forEach var="item" items="${bean.NUnitVersions}">
        <c:if test="${type eq item.value}"><c:out value="${item.description}"/></c:if>
      </c:forEach>
    </strong>
  </div>

  <c:if test="${not empty propertiesBean.properties[bean.NUnitPathKey]}">
    <div class="parameter">
      Path to NUnit console tool: <strong><props:displayValue name="${bean.NUnitPathKey}"/></strong>
    </div>
  </c:if>

  <c:if test="${not empty propertiesBean.properties[bean.NUnitWorkingDirectoryKey]}">
    <div class="parameter">
      Working directory: <strong><props:displayValue name="${bean.NUnitWorkingDirectoryKey}"/></strong>
    </div>
  </c:if>

  <c:if test="${not empty propertiesBean.properties[bean.NUnitConfigFileKey]}">
    <div class="parameter">
      Path to application configuration file: <strong><props:displayValue name="${bean.NUnitConfigFileKey}"/></strong>
    </div>
  </c:if>

  <c:if test="${not empty propertiesBean.properties[bean.NUnitCommadLineKey]}">
    <div class="parameter">
      Additional command line parameters to the NUnit console tool: <strong><props:displayValue name="${bean.NUnitCommadLineKey}"/></strong>
    </div>
  </c:if>

  <div class="parameter">
    .NET Runtime:
    <strong>
      <c:set var="type" value="${propertiesBean.properties[bean.platformTypeKey]}"/>
      <c:forEach var="item" items="${bean.platformTypes}">
        <c:if test="${type eq item.value}"><c:out value="${item.description}"/></c:if>
      </c:forEach>
    </strong>

    <strong>
      <c:set var="type" value="${propertiesBean.properties[bean.platformVersionKey]}"/>
      <c:forEach var="item" items="${bean.platformVersions}">
        <c:if test="${type eq item.value}"><c:out value="${item.description}"/></c:if>
      </c:forEach>
    </strong>
  </div>

  <div class="parameter">
    Run tests from: <strong><props:displayValue name="${bean.NUnitIncludeKey}" emptyValue="none specified"/></strong>
  </div>

  <div class="parameter">
    Do not run tests from: <strong><props:displayValue name="${bean.NUnitExceludeKey}" emptyValue="none specified"/></strong>
  </div>

  <div class="parameter">
    Include categories: <strong><props:displayValue name="${bean.NUnitCategoryIncludeKey}" emptyValue="none specified"/></strong>
  </div>

  <div class="parameter">
    Exclude categories: <strong><props:displayValue name="${bean.NUnitCategoryExcludeKey}" emptyValue="none specified"/></strong>
  </div>

  <c:if test="${not empty propertiesBean.properties[bean.NUnitRunProcessPerAssembly]}">
    <div class="parameter">
      Run process per assembly: <strong><props:displayCheckboxValue name="${bean.NUnitRunProcessPerAssembly}"/></strong>
    </div>
  </c:if>
</c:if>
