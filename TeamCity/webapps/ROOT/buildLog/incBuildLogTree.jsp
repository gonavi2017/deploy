<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %><%@
    taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@
    taglib prefix="bl" uri="/WEB-INF/buildLogTree.tld"
%><jsp:useBean id="server" type="jetbrains.buildServer.serverSide.SBuildServer" scope="request"
    /><jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"
    /><jsp:useBean id="messagesIterator" type="jetbrains.buildServer.serverSide.buildLog.LowLevelEventsAwareMessageIterator" scope="request"
    />
<c:set var="enabledFilter" value="${param['filter'] eq null ? 'all' : param['filter']}"/>

<bl:buildLogTreeTag  messagesIterator="${messagesIterator}"
                     build = "${buildData}"
                     filter = "${enabledFilter}"
                     incremental = "true"
                     expand = "${param.expand}"
                     hideBlocks = "${param.hideBlocks}"
                     consoleStyle = "${param.consoleStyle}"
                     baseClasses="${param.baseClasses}"
                     baseLevel="${param.baseLevel}"
                     id="${param.id}"
                     sizeLimit="${param.sizeLimit}"
                     state="${param.state}"
/>
<div class="hidden"><bs:buildDataIcon buildData="${buildData}" imgId="buildDataIcon" imgOnly="true"/></div>
  <div class="buildLogUpdater" onclick="return {<c:if test="${buildData.finished}"
      >finish: true,</c:if
      ><c:if test="${not buildData.finished}"
      >loaderIcon: '${buildData.buildStatus.successful ? "green" : "red"}',</c:if
      >updateCounter: ${messagesIterator.currentIndex},updateState: '${buildData.buildLog.sizeEstimate}'}"></div>