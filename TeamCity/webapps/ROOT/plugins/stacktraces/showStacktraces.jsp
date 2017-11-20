<%@ include file="/include.jsp" %>
<jsp:useBean id="sessionId" type="jetbrains.buildServer.stacktraces.server.StacktraceId" scope="request"/>
<jsp:useBean id="agent" type="jetbrains.buildServer.serverSide.SBuildAgent" scope="request"/>
<jsp:useBean id="build" type="jetbrains.buildServer.serverSide.SRunningBuild" scope="request"/>
<c:set var="title">Thread dumps of <c:out value="${build.fullName}"/> #<c:out value="${build.buildNumber}"/> (<bs:date value="<%=jetbrains.buildServer.util.Dates.now()%>" no_span="true"/>)</c:set>
<bs:externalPage>
<jsp:attribute name="page_title">${title}</jsp:attribute>
<jsp:attribute name="head_include">
    <bs:linkScript>
      /js/bs/blocks.js
      /js/bs/blocksWithHeader.js
    </bs:linkScript>
    <bs:linkCSS>
      /css/forms.css
    </bs:linkCSS>
    <style type="text/css">
      .threadDumps {
        margin: 0.3em 0.3em 0.3em 1em;
      }

      .cmdLine {
        font-size: 85%;
        margin-bottom: 1em;
      }

      .threadDump {
        white-space: pre;
        margin: 0 0 2em;
        padding: 0.3em;
        border: 1px solid #ccc;
      }

      .defaultSelected {
        background-color: lightcyan;
        border: 1px solid #0254D0;
      }

      .nodeContainer {
        padding-bottom: 3px;
      }

      .node {
        padding: 2px;
      }

      .node:hover {
        cursor: pointer;
      }
    </style>
  </jsp:attribute>
  <jsp:attribute name="body_include">

    <div class="threadDumps clearfix">
      <h2>${title}</h2>
      <div id="stacktraces_loading"></div>
      <div id="stacktraces_content"></div>
    </div>

    <script type="text/javascript">
      (function() {
      var lastSelectedPid = null;
      function showSelectedProcess(pid) {
        var blockId = 'pid' + pid;
        if (lastSelectedPid) {
          var prevSelector = $('selector:' + lastSelectedPid);
          if (prevSelector) {
            prevSelector.className = 'node';
          }
          BS.Util.hide('pid' + lastSelectedPid);
        }
        BS.Util.show(blockId);
        lastSelectedPid = pid;
        var newSelector = $('selector:' + pid);
        if (newSelector) {
          newSelector.className = 'node defaultSelected';
        }
      }
        
      var reloadTid = null;
      var tryLoad = function() {
        BS.ajaxUpdater($('stacktraces_content'), '<c:url value="/stacktraces/show.html"/>', {
          insertion: function(receiver, response) {
            if (response.length == "IN PROGRESS".length) {
              reload();
              return;
            }

            $(receiver).update(response);
            $('stacktraces_loading').hide();

            BS.Clipboard('.clipboard-btn');
          },

          parameters : 'agentId=${sessionId.agentId}&sessionId=${sessionId.sessionId}',
          evalScripts: true
        });
      };

      var reload = function () {
        $('stacktraces_loading').innerHTML = BS.loadingIcon + "&nbsp;Loading...";
        if (reloadTid) {
          clearTimeout(reloadTid);
        }
        reloadTid = setTimeout(tryLoad, 2000);
      };
      reload();

      // Exports
      window.showSelectedProcess = showSelectedProcess;
      })();
    </script>
  </jsp:attribute>
</bs:externalPage>