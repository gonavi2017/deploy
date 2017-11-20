<%@ include file="/include.jsp"%>
<jsp:useBean id="threadDumpsTree" type="jetbrains.buildServer.stacktraces.common.ThreadDumpTree" scope="request"/>
<c:set var="elements" value="${threadDumpsTree.sortedElements}"/>
<c:if test="${fn:length(elements) == 0}">
  TeamCity was unable to locate any processes of this build.
</c:if>
<c:if test="${fn:length(elements) > 0}">
<div>
  <h3  class="title_underlined">Process tree:</h3>
  <bs:smallNote>Click on an item in the tree to view thread dump.</bs:smallNote>
<c:forEach items="${elements}" var="element">
  <c:set var="indent" value="${2*element.level}em"/>
  <div class="nodeContainer" style="text-indent: ${indent};">
    <a href="#" id="selector:${element.info.pid}" onclick="showSelectedProcess('${element.info.pid}'); return false" class="node ${element.defaultSelected ? 'defaultSelected' : ''}" title="Click to show thread dump of this process">PID: ${element.info.pid} <c:out value="${element.fileName}"/></a>
  </div>
  <c:if test="${element.defaultSelected}">
    <c:set var="defaultSelected" value="${element.info.pid}"/>
  </c:if>
</c:forEach>
</div>

<c:forEach items="${elements}" var="element">
  <c:set var="threadDump" value="${element.info}"/>

  <div id="pid${threadDump.pid}" style="display: none;">
  <h3 class="title_underlined">Process ID (PID): ${threadDump.pid}</h3>
  <c:set var="cmdLineId" value="cmdLine${threadDump.pid}"/>
  <p class="icon_before icon16 blockHeader collapsed" id="id${cmdLineId}">Process command line</p>
  <div class="cmdLine mono" id="${cmdLineId}">
    <c:out value="${threadDump.cmdLine}"/>
  </div>

  <script type="text/javascript">
    <l:blockState blocksType="Block_id${cmdLineId}"/>
      new BS.BlocksWithHeader('id${cmdLineId}');
  </script>

  <div class="clipboardButton">
    <span class="clipboard-btn tc-icon_before icon16 tc-icon_copy" data-clipboard-action="copy" data-clipboard-target="#pid${threadDump.pid} .threadDump.mono">Copy to clipboard</span>
  </div>

  <pre class="threadDump mono"><c:out value="${threadDump.stacktrace}"/></pre>
  </div>
</c:forEach>
<script type="text/javascript">
  showSelectedProcess('${defaultSelected}');
</script>
</c:if>