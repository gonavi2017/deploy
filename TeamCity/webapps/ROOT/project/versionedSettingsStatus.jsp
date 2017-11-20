<%@include file="/include-internal.jsp" %>
<jsp:useBean id="project" type="jetbrains.buildServer.serverSide.SProject" scope="request" />
<jsp:useBean id="settingsBean" type="jetbrains.buildServer.controllers.project.VersionedSettingsBean" scope="request"/>

<style type="text/css">
  div#versionedSettingsStatus {
    margin-top: 2em;
    margin-left: 1em;
  }
  .configErrors {
    margin-left: 1em;
  }
  span.configFile {
    font-weight: bold;
  }
  span.configFileErrorMessage {
    color: red;
  }

  div#versionedSettingsStatus table td {
    vertical-align: top;
  }
</style>
<c:set var="statusUrl">
  <c:url value="/versionedSettingsStatus.html?projectId=${project.externalId}"/>
</c:set>
<bs:refreshable containerId="versionedSettingsStatus" pageUrl="${statusUrl}">
  <c:set var="status" value="${settingsBean.status}"/>
  <c:choose>
    <c:when test="${not empty status}">
      <h3>Current Status:</h3>
      <table>
        <tr>
          <td>
            <span>[<bs:date value="${status.timestamp}" pattern="${status.dateFormat}"/>]:</span>
          </td>
          <td>
            <c:if test="${status.warn}">
              <span class="icon icon16 yellowTriangle"></span>
            </c:if>
            <span class="statusDescription"><c:out value="${status.description}"/></span>
          </td>
        </tr>
        <tr>
          <td></td>
          <td>
            <c:if test="${not empty status.configErrors}">
              <c:forEach var="configError" items="${status.configErrors}">
                <div style="margin-left: 1em;">
                  <c:if test="${configError.filePathPresent}">
                    <span class="configFile"><c:out value="${configError.filePath}"/>:</span>
                  </c:if>
                  <span class="configFileErrorMessage"><c:out value="${configError.message}"/></span>
                </div>
                <c:if test="${configError.detailsPresent}">
                  <div class="grayNote" style="margin-left: 20px;">
                    <c:forEach var="info" items="${configError.details}">
                      <c:out value="${info}" /><br/>
                    </c:forEach>
                  </div>
                </c:if>
              </c:forEach>
              <div>
                  The server will use last known good settings
                  <c:if test="${!settingsBean.settingsRevision.equals('unknown')}">(revision <c:out value="${ settingsBean.settingsRevision }" />)</c:if>
              </div>
            </c:if>
          </td>
        </tr>
        <c:set var="effectiveSettings" value="${settingsBean.effectiveParentSettings}"/>
        <c:set var="definingProject" value="${empty effectiveSettings ? project : effectiveSettings.project}"/>
        <c:if test="${not status.warn and empty status.configErrors and not empty definingProject and outdatedDsl}">
          <tr>
            <td></td>
            <td>
              <span class="icon icon16 yellowTriangle"></span>DSL update is
              <admin:healthStatusReportLink project="${definingProject}" selectedCategory="outdatedProjectSettingsHealthCategory" minSeverity="WARN">required</admin:healthStatusReportLink>
            </td>
          </tr>
        </c:if>
      </table>
    </c:when>
    <c:when test="${empty status and settingsBean.syncEnabled}">
      <h3>Current Status:</h3>
      No settings changes were made since server start
    </c:when>
  </c:choose>
  <script type="text/javascript">
    setTimeout(function() {
      $j("#versionedSettingsStatus").get(0).refresh();
    }, ${settingsBean.statusUpdateIntervalMillis});
  </script>
</bs:refreshable>