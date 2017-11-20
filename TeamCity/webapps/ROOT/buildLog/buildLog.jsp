<%@ include file="../include-internal.jsp" %>

<jsp:useBean id="logReadingError" type="java.lang.String" scope="request"/>
<jsp:useBean id="buildPromotion" type="jetbrains.buildServer.serverSide.BuildPromotion" scope="request"/>
<jsp:useBean id="messagesAvailable" type="java.lang.Boolean" scope="request"/>
<bs:includeUserCss/>

<c:choose>
  <c:when test='${not empty logReadingError}'>
    <div class="logReadingError">${logReadingError}</div>
  </c:when>

  <c:when test="${not messagesAvailable}">
    <i style="color:#888">Build log is empty</i>
  </c:when>

  <%--@elvariable id="queuedLog" type="java.lang.Boolean"--%>
  <c:when test="${queuedLog}">
    <bs:buildLog buildPromotion="${buildPromotion}" messagesIterator="${buildPromotion.buildLog.verboseIterator}" renderRunningTime="false"/>
  </c:when>

  <c:otherwise>
    <jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
    <jsp:useBean id="logTab" type="java.lang.String" scope="request"/>
    <jsp:useBean id="canShowTree" type="java.lang.Boolean" scope="request"/>

    <c:set var="enabledFilter" value="${param['filter'] eq null ? 'all' : param['filter']}"/>

    <bs:linkScript>
      /js/bs/buildLog.js
      /js/jquery/jquery.sticky.js
    </bs:linkScript>

    <c:set var="showTail" value="${logTab == 'tail' || !canShowTree}"/>
    <c:if test="${logTab == 'important'}"><c:set var="enabledFilter" value="important"/></c:if>

    <c:set var="separator"><span class="separator">|</span></c:set>

    <div class="subTabs">
      <table class="subTabsRight">
        <tr>
          <td>
            <a class="downloadLink tc-icon_before icon16 tc-icon_download" href="downloadBuildLog.html?buildId=${buildData.buildId}" style="white-space:nowrap;">Download full build log (~<span id="buildLogSizeEstimate">${buildData.buildLog.sizeEstimate}</span>)</a>
          </td>
          <td>${separator}</td>
          <td><a href="downloadBuildLog.html?buildId=${buildData.buildId}&archived=true">.zip</a></td>
          <c:if test="${enabledFilter eq 'debug'}"><td>${separator}</td>
          <td><a href="downloadRawMessageFile.html?buildId=${buildData.buildId}">raw message file</a></td></c:if>
        </tr>
      </table>

      <c:choose>
        <c:when test="${showTail}">
          <bs:_viewLog build="${buildData}" noLink="true" urlAddOn="&logTab=tree&filter=${enabledFilter}"/><a href="${url}">Tree view</a>
          ${separator}
          <strong>Tail</strong>
        </c:when>
        <c:otherwise>
          <strong>Tree view</strong>
          ${separator}
          <bs:_viewLog build="${buildData}" noLink="true" urlAddOn="&logTab=tail"/><a href="${url}">Tail</a>
        </c:otherwise>
      </c:choose>
    </div>

    <c:choose>
      <%--tail--%>
      <c:when test="${showTail}">
        <jsp:include page="buildLogTail.html"/>
      </c:when>
      <%--tree view--%>
      <c:otherwise>
        <jsp:include page="buildLogTree.html?filter=${enabledFilter}"/>
      </c:otherwise>
    </c:choose>

    <c:if test="${not buildData.finished}">
      <div id="buildLogProgress">
        <span class="icon icon16 buildDataIcon build-status-icon build-status-icon_running-${buildData.buildStatus.successful ? "green" : "red"}-transparent"></span>
        Running...
      </div>
    </c:if>
  </c:otherwise>

</c:choose>