<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bs" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="props" tagdir="/WEB-INF/tags/props" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="bl" uri="/WEB-INF/buildLogTree.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/functions/util" %>

<jsp:useBean id="buildData" type="jetbrains.buildServer.serverSide.SBuild" scope="request"/>
<jsp:useBean id="messagesIterator" type="jetbrains.buildServer.serverSide.buildLog.LowLevelEventsAwareMessageIterator" scope="request"/>
<jsp:useBean id="expand" type="java.lang.String" scope="request"/>
<jsp:useBean id="hideBlocks" type="java.lang.String" scope="request"/>
<jsp:useBean id="consoleStyle" type="java.lang.String" scope="request"/>
<jsp:useBean id="tabID" type="java.lang.String" scope="request"/>
<jsp:useBean id="filters" type="java.util.Collection<jetbrains.buildServer.controllers.viewLog.tree.filters.TreeViewMessageFilter>" scope="request"/>

<c:set var="enabledFilter" value="${param['filter'] eq null ? 'all' : param['filter']}"/>

<c:set var="expand">${fn:forJS(expand, true, false)}</c:set>
<c:set var="filter">${fn:forJS(filter, true, false)}</c:set>
<c:set var="hideBlocks">${hideBlocks == 'true'}</c:set>
<c:set var="consoleStyle">${consoleStyle == 'true'}</c:set>

<div class="stickyBar">
  <div class="actionBar" style="margin-top: 5px;">
    <span class="actionBarRight">
      <span title="Show parent block for each message"><label><forms:checkbox name="" id="hideBlockNames"/>Repeat block names</label></span>
    </span>

    <span class="nowrap">
      <bs:collapseExpand collapseAction="BS.BuildLogTree.reloadExpand('none'); return false;" expandAction="BS.BuildLogTree.reloadExpand('all'); return false;"/>
    </span>

    <span class="nowrap">
      <label class="shift" for="messageFilters">View: </label>
      <select id="messageFilters" onchange="BS.BuildLogTree.reloadFilter(this.options[this.selectedIndex].value);">
          <c:forEach items="${filters}" var="filter" >
            <props:option value="${filter.type}" selected="${filter.type eq enabledFilter}">${filter.displayName}</props:option>
          </c:forEach>
        <props:option value="debug" selected="${'debug' eq enabledFilter}">Verbose</props:option>
      </select>
    </span>

    <span class="nowrap">
      <label class="shift"><forms:checkbox name="" id="useConsoleStyle"/>Console view</label>
    </span>
  </div>
  <div id="msg_overflow_warn_top" class="partialLogWarn hidden">
    Partial build log is displayed to avoid browser freeze.
    <a id="showFullLogLink" href="downloadBuildLog.html?buildId=${buildData.id}&plain=true" target="_blank">Show full build log text</a>
    | <a href="downloadBuildLog.html?buildId=${buildData.buildId}&archived=true">Download .zip</a>
  </div>
</div>

<div class="log rTree" id="buildLog">
  <script type="text/javascript">
    BS.BuildLogTree.init('${expand}', '${enabledFilter}', ${hideBlocks}, ${consoleStyle});
    $j(".stickyBar").sticky({topSpacing:0});
  </script>

  <%--@elvariable id="modelSizeLimit" type="java.lang.Integer"--%>
  <bl:buildLogTreeTag  messagesIterator="${messagesIterator}"
                       build = "${buildData}"
                       filter = "${enabledFilter}"
                       incremental = "false"
                       expand = "${expand}"
                       hideBlocks = "${hideBlocks}"
                       consoleStyle = "${consoleStyle}"
                       baseClasses="${param.baseClasses}"
                       baseLevel="${param.baseLevel}"
                       id="${param.id}"
                       sizeLimit="${not empty modelSizeLimit ? modelSizeLimit : param.sizeLimit}"
                       state="${param.state}"
                       beginningSkipped="${beginningSkipped}"
  />
</div>

<c:if test="${not buildData.finished}">
  <script type="text/javascript">
    $j(document).ready(function () {
      <c:set var="additionalParams"
             value="logTab=tree&filter=${enabledFilter}&expand=${expand}&hideBlocks=${hideBlocks}&tabID=${tabID}&consoleStyle=${consoleStyle}&type=inc"/>
      /* The third argument: the index of last message. */
        BS.BuildLog.startUpdates(${buildData.buildId}, '${buildData.buildType.externalId}', ${messagesIterator.currentIndex}, true, 'buildLogTree.html', '${additionalParams}');
    });
  </script>
</c:if>
