<%@ include file="/include-internal.jsp" %>

<jsp:useBean id="threadDumpsAnalyzerBean" type="jetbrains.buildServer.diagnostic.web.ThreadDumpsAnalyzerExtension.ThreadDumpsAnalyzerBean" scope="request"/>

<form action="<c:url value='/admin/admin.html'/>" method="get" style="margin-top: 0.5em;" id="analyzerForm">
  <table class="runnerFormTable" style="width: 50em;" onkeydown="if (event.keyCode == Event.KEY_RETURN) {$('analyzeBtn').click(); return false;}">
    <tr>
      <td style="width: 40%;"><label for="dumpsDirectory">Thread dumps directory:</label></td>
      <td>
        <forms:select name="dumpsDirectory" enableFilter="true" style="width: 20em;">
          <forms:option value="">-- Choose a directory --</forms:option>
          <c:forEach items="${threadDumpsAnalyzerBean.threadDumpDirectories}" var="dir">
            <forms:option value="${dir.name}" selected="${threadDumpsAnalyzerBean.dumpsDirectory == dir.name}"><c:out value="${dir.name}"/></forms:option>
          </c:forEach>
        </forms:select>
        <forms:button id="analyzeBtn" className="btn_mini" onclick="var form = $('analyzerForm'); BS.Util.disableFormTemp(form); document.location.href=form.action + '?' + BS.Util.serializeForm(form);">Analyze</forms:button>
      </td>
    </tr>
    <tr>
      <td><label for="executionThreshold">Minimum execution time (seconds):</label></td>
      <td><forms:textField name="executionThreshold" value="${threadDumpsAnalyzerBean.executionThreshold}" style="width: 20em;"/></td>
    </tr>
    <tr>
      <td><label for="runnable">Runnable only:</label></td>
      <td><forms:checkbox name="runnable" checked="${threadDumpsAnalyzerBean.runnable}" value="true"/></td>
    </tr>
    <tr>
      <td><label for="relativeTime">Use relative time:</label></td>
      <td><forms:checkbox name="relativeTime" checked="${threadDumpsAnalyzerBean.relativeTime}"/></td>
    </tr>
    <tr>
      <td><label for="threadInclude">Show only threads with text:</label></td>
      <td>
        <c:forEach items="${threadDumpsAnalyzerBean.threadConfiguredInclude}" var="existingInclude">
          <div>&quot;<c:out value="${existingInclude}"/>&quot;&nbsp;<a href="#" onclick="$('threadIncludeDelete').value = '<bs:escapeForJs text="${existingInclude}" forHTMLAttribute="true"/>'; $('analyzeBtn').onclick(); return false;">x</a></div>
        </c:forEach>
        <c:set var="escapedThreadInclude"><c:out value="${threadDumpsAnalyzerBean.threadInclude}"/></c:set>
        <c:set var="escapedThreadIncludeDelete"><c:out value="${threadDumpsAnalyzerBean.threadIncludeDelete}"/></c:set>
        <forms:textField name="threadInclude" value="${escapedThreadInclude}"/>
        <forms:textField style="display:none" name="threadIncludeDelete" value="${escapedThreadIncludeDelete}"/>
      </td>
    </tr>
    <tr>
      <td><label for="threadExclude">Do not show threads with text:</label></td>
      <td>
        <c:forEach items="${threadDumpsAnalyzerBean.threadConfiguredExclude}" var="existingExclude">
          <div>&quot;<c:out value="${existingExclude}"/>&quot;&nbsp;<a href="#" onclick="$('threadExcludeDelete').value = '<bs:escapeForJs text="${existingExclude}" forHTMLAttribute="true"/>'; $('analyzeBtn').onclick(); return false;">x</a></div>
        </c:forEach>
        <c:set var="escapedThreadExclude"><c:out value="${threadDumpsAnalyzerBean.threadExclude}"/></c:set>
        <c:set var="escapedThreadExcludeDelete"><c:out value="${threadDumpsAnalyzerBean.threadExcludeDelete}"/></c:set>
        <forms:textField name="threadExclude" value="${escapedThreadExclude}"/>
        <forms:textField style="display:none" name="threadExcludeDelete" value="${escapedThreadExcludeDelete}"/>
      </td>
    </tr>
  </table>

  <c:set var="threadsMap" value="${threadDumpsAnalyzerBean.threadDumps}"/>
  <c:if test="${not empty threadDumpsAnalyzerBean.errors}">
    <c:forEach items="${threadDumpsAnalyzerBean.errors}" var="error">
      <div style="color: red; font-weight:bold;"><c:out value="${error}"/></div>
    </c:forEach>
  </c:if>
  <c:if test="${not empty threadDumpsAnalyzerBean.dumpsDirectory}">
  <p>Found <strong>${fn:length(threadsMap)}</strong> thread dumps<c:if
      test="${threadDumpsAnalyzerBean.executionThresholdSeconds > 0}"> with threads executing for more than <strong>${threadDumpsAnalyzerBean.executionThresholdSeconds}</strong> seconds</c:if><c:if
      test="${threadDumpsAnalyzerBean.executionThresholdSeconds == 0}"> with threads having exection time</c:if>.</p>

  <table>
    <tr>
      <td style="padding:0 0 0 2em;">Thread dump</td>
      <td style="padding:0 0 0 2em;">Threads</td>
      <td style="padding:0 0 0 2em;">Took</td>
      <c:set var="firstDump" value="${threadsMap[0]}"/>
      <c:forEach items="${firstDump.dump.cpuUsages}" var="cpuUsage">
        <td style="padding:0 0 0 2em;"><c:out value="${cpuUsage.name}"/></td>
      </c:forEach>
      <c:forEach items="${firstDump.dump.memoryUsages}" var="memoryUsage">
        <td style="padding:0 0 0 2em;"><c:out value="${memoryUsage.name}"/></td>
      </c:forEach>
    </tr>
      <c:forEach items="${threadsMap}" var="entry">
        <tr>
          <td style="padding:0 0 0 2em;"><c:out value="${entry.dump.origin.name}"/></td>
          <td style="padding:0 0 0 2em;">${entry.threads.size()}/${entry.dump.threads.size()}</td>
          <td style="padding:0 0 0 2em;"><c:out value="${entry.dump.dumpTookTime}"/></td>
          <c:forEach items="${entry.dump.cpuUsages}" var="cpuUsage">
            <td style="padding:0 0 0 2em;"><span style="<c:if test="${cpuUsage.percent > 90}">color: red</c:if>">
              <c:out value="${cpuUsage.percent}"/>%</span></td>
          </c:forEach>
          <c:forEach items="${entry.dump.memoryUsages}" var="memoryUsage">
            <td style="padding:0 0 0 2em;"><span style="<c:if test="${memoryUsage.percent > 90}">color: red</c:if>">
              <c:out value="${memoryUsage.used}"/> (<c:out value="${memoryUsage.percent}"/>%)</span></td>
          </c:forEach>
        </tr>
      </c:forEach>
  </table>
  <br/>

  <table class="runnerFormTable" style="width: 100%;">
    <c:forEach items="${threadsMap}" var="entry">
      <tr>
        <td>
          <c:url var="dumpLink" value="/admin/admin.html?item=diagnostics&tab=logs&file=${util:escapeUrlForQuotes(entry.dump.origin.parentFile.name)}%2F${util:escapeUrlForQuotes(entry.dump.origin.name)}"/>
          <div style="background: silver; padding: 5px;">
            Thread dump:
            <strong><bs:date value="${entry.dump.date}" pattern="yyyy-MM-dd HH:mm:ss"/></strong>
            (took in <c:out value="${entry.dump.dumpTookTime}"/>) threads shown: ${entry.threads.size()}/${entry.dump.threads.size()}
            <a href="${dumpLink}"><c:out value="${entry.dump.origin.name}"/></a>
          </div>
          <br/>

          <c:forEach items="${entry.threads}" var="thread">
            <span id="thread_${entry.dump.id}_${thread.id}"></span>
            <c:set var="level" value="0"/>
            <c:forEach items="${thread.stages}" var="stage">
              <c:forEach begin="1" end="${level}">&nbsp;&nbsp;</c:forEach
              ><c:set var="level" value="${level + 1}"
              /><c:if test="${not empty stage.startTime}"
            ><c:if test="${not threadDumpsAnalyzerBean.relativeTime}"><bs:date value="${stage.startTime}" pattern="HH:mm:ss"/></c:if
            ><c:if test="${threadDumpsAnalyzerBean.relativeTime}"><strong><c:out value="${stage.elapsedTime}"/></strong></c:if
            ></c:if
            >&nbsp;<span style="white-space: pre"><c:out value="${stage.name}"/></span><br/>
            </c:forEach>
            <c:if test="${not empty thread.lockedByThread}">
              <c:set var="lockedById">${entry.dump.id}_${thread.lockedByThread.id}</c:set>
              <strong>Locked by</strong> <a href="#"
                                           onclick="elem = jQuery($j('[name=trace_${lockedById}]'));
                                           if (elem.length === 0) {alert('No thread found. Check that it is not filtered out.'); return false;}
                                           elem.show();
                                           if (document.location.hash != 'thread_${entry.dump.id}_${thread.id}') document.location.hash='thread_${entry.dump.id}_${thread.id}';
                                           document.location.hash='thread_${lockedById}';
                                           return false;"><c:out value="${thread.lockedByThread.name}"/></a>
            </c:if>
            <c:choose>
              <c:when test="${not empty thread.stack}">
                <c:set var="id">trace_<bs:id/></c:set>
                <div><a href="#" onclick="BS.Util.toggleVisible('${id}'); return false;">Show/hide stacktrace &raquo;</a></div>
                <div style="display: none;" id="${id}" name="trace_${entry.dump.id}_${thread.id}">
                  <c:forEach items="${thread.stack}" var="line">
                    <div style="padding-left: 1em; white-space: pre;"><c:out value="${line}"/></div>
                  </c:forEach>
                </div>
              </c:when>
              <c:otherwise>
                <div style="font-style: italic">No stacktrace</div>
              </c:otherwise>
            </c:choose>
            <br/>
          </c:forEach>
        </td>
      </tr>
    </c:forEach>
  </table>
  </c:if>

  <input type="hidden" name="analyze" value="true"/>
  <input type="hidden" name="item" value="diagnostics"/>
  <input type="hidden" name="tab" value="threadDumpsAnalyzer"/>
</form>