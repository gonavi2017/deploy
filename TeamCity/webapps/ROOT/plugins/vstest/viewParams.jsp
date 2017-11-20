<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags"%>
<jsp:useBean id="propertiesBean" scope="request" type="jetbrains.buildServer.controllers.BasePropertiesBean"/>
<jsp:useBean id="supportBean" class="jetbrains.buildServer.dotNet.vstest.server.VisualStudioTestBean"/>

<%@include file="paramsConstants.jsp"%>

<div class="parameter">
  Included assemblies:
  <props:displayValue name="${dotTestInclude}"
                      emptyValue="<empty>"
                      showInPopup="true"
                      popupTitle="Test assemblies on:"
                      popupLinkText="View Assemblies"/>
</div>

<div class="parameter">
  Excluded assemblies:
  <strong><props:displayValue name="${dotTestExclude}"
                              emptyValue="<empty>"
                              showInPopup="true"
                              popupTitle="Test assemblies on:"
                              popupLinkText="View Assemblies"/></strong>
</div>

<%-- run runsettings --%>
<div class="parameter">
  Run settings file: <strong><props:displayValue name="${dotTestRunSettings}" emptyValue="none specified" /></strong>
</div>
<%-- additional command line--%>
<div class="parameter">
  Additional commandline parameters: <strong><props:displayValue name="${dotTestExtraCmd}" emptyValue="none specified" /></strong>
</div>

<c:choose>
  <c:when test="${engine_mstest == propertiesBean.properties[dotTestEngine]}">
    <div class="parameter">
      MSTest version: <strong>
      <c:set var="mstestOptionSelected" value="${false}"/>
      <c:forEach var="it" items="${supportBean.MSTestPathValues}">
        <c:if test="${propertiesBean.properties[dotTestRunnerPath] eq it.value}">
          <c:out value="${it.description}"/>
          <c:set var="mstestOptionSelected" value="${true}"/>
        </c:if>
      </c:forEach>
      <c:if test="${not mstestOptionSelected}">
        Custom (<c:out value="${propertiesBean.properties[dotTestRunnerPath]}"/>)
      </c:if>
    </strong>
    </div>
    <div class="parameter">
      MSTest metadata: <props:displayValue name="${msTestMetadata}" emptyValue="none specified"/>
    </div>
    <div class="parameter">
      Testlist from metadata to run:
      <strong><props:displayValue name="${msTestTestlist}"
                                  emptyValue="<empty>"
                                  showInPopup="true"
                                  popupTitle="Testlist from metadata:"
                                  popupLinkText="View Testlist"/></strong>
    </div>
    <div class="parameter">
      Test:
      <strong><props:displayValue name="${msTestTest}"
                                  emptyValue="<empty>"
                                  showInPopup="true"
                                  popupTitle="Test:"
                                  popupLinkText="View Test"/></strong>
    </div>
    <div class="parameter">
      Unique:
      <strong>
        <props:displayCheckboxValue name="${msTestUnique}"/>
      </strong>
    </div>
    <div class="parameter">
      Results file: <strong><props:displayValue name="${msTestResult}" emptyValue="none specified" /></strong>
    </div>
  </c:when>
  <c:when test="${engine_vstest == propertiesBean.properties[dotTestEngine]}">
    <div class="parameter">
      VSTest version: <strong>
      <c:set var="vstestOptionSelected" value="${false}"/>
      <c:forEach var="it" items="${supportBean.supportedVSTestVersions}">
        <c:if test="${it.asReference eq propertiesBean.properties[dotTestRunnerPath]}">
          <c:out value="${it.description}"/>
          <c:set var="vstestOptionSelected" value="${true}"/>
        </c:if>
      </c:forEach>
      <c:if test="${not vstestOptionSelected}">
        Custom (<c:out value="${propertiesBean.properties[dotTestRunnerPath]}"/>)
      </c:if>
    </strong>
    </div>
    <div class="parameter">
      Target platform: <strong><props:displayValue name="${platform}"/></strong>
    </div>
    <div class="parameter">
      Framework: <strong><props:displayValue name="${framework}"/></strong>
    </div>
    <div class="parameter">
      Test names: <strong><props:displayValue name="${testNames}" emptyValue="none specified"/></strong>
    </div>
    <div class="parameter">
      Test case filter: <strong><props:displayValue name="${testCaseFilter}" emptyValue="none specified"/></strong>
    </div>
  </c:when>
  <c:otherwise></c:otherwise>
</c:choose>







