<%@ include file="/include-internal.jsp"%>
<%@ taglib prefix="l" tagdir="/WEB-INF/tags/layout" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="toolType" scope="request" type="java.lang.String"/>
<jsp:useBean id="toolTypeDisplayName" scope="request" type="java.lang.String"/>
<jsp:useBean id="executableName" scope="request" type="java.lang.String"/>
<jsp:useBean id="versionParameterName" scope="request" type="java.lang.String"/>
<jsp:useBean id="clazz" scope="request" type="java.lang.String"/>
<jsp:useBean id="isDefaultVersionSpecified" scope="request" type="java.lang.Boolean"/>

<c:choose>
  <c:when test="${isDefaultVersionSpecified}">
    <l:settingsGroup title="${toolTypeDisplayName} Settings" className="advancedSetting">
      <tr class="advancedSetting">
        <th>${executableName}:</th>
        <td>
          <jsp:include page="/tools/selector.html?toolType=${toolType}&versionParameterName=${versionParameterName}&class=${clazz}"/>
        </td>
      </tr>
    </l:settingsGroup>
  </c:when>
  <c:otherwise>
    <l:settingsGroup title="${toolTypeDisplayName} Settings">
      <tr>
        <th>${executableName}<l:star/>:</th>
        <td>
          <jsp:include page="/tools/selector.html?toolType=${toolType}&versionParameterName=${versionParameterName}&class=${clazz}"/>
        </td>
      </tr>
    </l:settingsGroup>
  </c:otherwise>
</c:choose>