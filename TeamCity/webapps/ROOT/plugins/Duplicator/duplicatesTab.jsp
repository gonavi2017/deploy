<%--@elvariable id="build" type="SBuildData"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true"
  %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
  %><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
  %><%@ taglib prefix="bs" tagdir="/WEB-INF/tags"
  %><%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms"
  %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<form>
<div id="duplicateBrowser">
  <div class="actionBar"> <!--Counters-->
    <%@ include file="duplicateSummary.jsp" %>

    <%--@elvariable id="stats" type="int[]"--%>
    <forms:checkbox name="" checked="${stats[1] > 0}" disabled="${stats[1] == 0}" id="filterNew" onclick="DB.pathIndex = 0; DB.listModules();"/>
    <label class="rightLabel" for="filterNew">new only</label>
  </div>
  <div id="navs"> <!--TOP 3-->
    <div class="paneM">Scope<div id="modules"></div></div>
    <div class="paneD">Duplicates<div id="duplicates"></div></div>
    <div class="paneI">Instances list<div id="instances"></div></div>
  </div>
  <div id="toolbars"> <!--TOOLBARS-->
    <div class="toolbar left">
      <div class="toolbar-inner">
        <a class="fileActivator" href="#" onclick="DB.openFragment(0); return false" title="Click to open in the active IDE">
          <i class="icon icon_open-in-ide"></i>
        </a>
        <span id="file_0">&nbsp;</span>
      </div>
    </div>
    <div class="toolbar right">
      <div class="toolbar-inner">
        <a class="fileActivator" href="#" onclick="DB.openFragment(1); return false" title="Click to open in the active IDE">
          <i class="icon icon_open-in-ide"></i>
        </a>
        <span id="file_1">&nbsp;</span>
      </div>
    </div>
  </div>
  <div id="sources"> <!--SOURCES-->
    <div id="outer_0" class="paneF leftPaneF"><div class="paneInner"><div class="source"><div id="pane_0" style="width:200%"></div></div></div></div>
    <div id="outer_1" class="paneF rightPaneF"><div class="paneInner"><div class="source"><div id="pane_1" style="width:200%"></div></div></div></div>
  </div>
</div>
<br/>
  <input type="hidden" id="filepath_0" name="filepath_0" value=""/>
  <input type="hidden" id="filepath_1" name="filepath_1" value=""/>

  <textarea id="modulesT" style="display:none;">
    <div id="moduleList">
      {for path in modules}
      {if (!$("filterNew").checked || path[2])}
          <a class="module" href="#" id="path_\${path_index}" onclick="DB.selectPath('\${path_index}'); return false" >\${path[0]}</a>
      {/if}
      {/for}
    </div>
  </textarea>

  <textarea id="duplicatesT" style="display:none;">
    <select size="10" id="dupeList" onchange="this.options.length>0 && DB.selectDupe(this.options[this.selectedIndex].value)">
      {for info in dupes}
        {if (!$("filterNew").checked || info[4]>0)
        &&
        (DB.currentPaths.length==0 || (0<=DB.currentPaths.indexOf(info[0]+",")))
        }
          <option id="dupe_\${info[0]}" value="\${info[0]}">cost \${info[1]}, \${info[2]} duplicates in \${info[3]} file(s)</option>
        {/if}
      {/for}
    </select>
  </textarea>

<textarea id="instancesT" style="display:none;">
{for instance in instances}
\${name=DB.files[instance[0]]|eat}
\${nameSplit=name.lastIndexOf("/")+1|eat}
\${fileName=name.substring(nameSplit)|eat}
\${filePath=name.substring(0,nameSplit)|eat}
\${instance[-1]=fileName+":"+(instance[1])+" ("+filePath+")"|eat}
<div id="instance_\${instance_index}" class="instance">
      <a id="toRight" class="to" href="#"
         title="Show fragment in LEFT panel"
         onclick="DB.displayFragment(\${instance_index}, \${instance[0]}, '\${instance[2]}', 0, \${instance[1]}); return false"
        ></a
        ><a id="toLeft" class="to" href="#"
         title="Show fragment in RIGHT panel"
         onclick="DB.displayFragment(\${instance_index}, \${instance[0]}, '\${instance[2]}', 1, \${instance[1]}); return false"
        ></a>&nbsp;#\${Math.round(instance_index)+1}&nbsp;\${instance[-1]}</div>
{/for}
</textarea>
</form>
<script type="text/javascript">
var DB = {}; //duplicate browser

DB.modules = [
  <%--@elvariable id="modules" type="java.util.Map<String, Object[]>"--%>
  <c:forEach items="${modules}" var="path" varStatus="pathIteration"> ['${path.key}', '${path.value[0]}', ${path.value[1]}]<c:if test="${!pathIteration.last}">,</c:if></c:forEach>
];

//array of records: 0:duplicate_id, 1:cost, 2:instanceCount, 3:fileCount, 4:diffCount
DB.dupes = [
  <%--@elvariable id="infos" type="java.util.List<long[]>"--%>
  <c:forEach items="${infos}" var="info" varStatus="infoIteration"> ['${info[0]}', ${info[1]}, ${info[2]}, ${info[3]}, ${info[4]}]<c:if test="${!infoIteration.last}">,</c:if></c:forEach>
];

DB.files = {
  // map file_id to file name
  <%--@elvariable id="files" type="java.util.Map<Long, String>"--%>
  <c:forEach items="${files}" var="file" varStatus="filesIteration">${file.key}:"${fn:escapeXml(file.value)}"<c:if test="${!filesIteration.last}">,</c:if></c:forEach>
};

//indexed by dupe.id
DB.instances = {};

DB.currentPaths = "";
DB.pathIndex = 0;
DB.paneLine = [0,0];

DB.listDuplicates = function() {
  var filter = $("filterNew"),
      duplicates = $("duplicates"),
      instances = $("instances");

  var filterChecked = filter.checked;
  var filterEnabled = filter.disabled;
  filter.disabled = true;
  duplicates.innerHTML = TrimPath.processDOMTemplate("duplicatesT", {dupes:DB.dupes});
  duplicates.scrollTop = 0;
  instances.scrollTop = 0;
  var idx = 0;
  if (filterChecked) {
    for (idx = 0; idx<DB.dupes.length && DB.dupes[idx][4]==0; idx++) {
      //find top new
    }
  }

  var dupeList = $("dupeList");

  dupeList.selectedIndex = 0;
  dupeList.onchange();
  filter.checked = filterChecked;
  filter.disabled = filterEnabled;
};

DB.listModules = function() {
  var modules = $("modules");
  modules.innerHTML = TrimPath.processDOMTemplate("modulesT", {modules:DB.modules});
  modules.scrollTop = 0;
  DB.selectPath(0);
};

DB.selectPath = function (path_index) {
  $("path_" + DB.pathIndex).removeClassName("active");
  DB.pathIndex = path_index;
  $("path_" + DB.pathIndex).addClassName("active");
  DB.currentPaths = DB.modules[DB.pathIndex][1];
  DB.listDuplicates();
};

DB.selectDupe = function (dupeId) {
  if (DB.instances[dupeId]) {
    DB.activateDupe(dupeId);
  } else {
    $("instances").innerHTML = '<div class="details"><i class="icon-refresh icon-spin"></i>&nbsp;Loading...</div>';
    BS.ajaxRequest("duplicatesTabInstances.html?buildId=${build.buildId}&fragmentId=" + dupeId, {
         onSuccess: function(t) {
           var instancesText = t.responseText;
           DB.instances[dupeId] = eval(instancesText);
           DB.activateDupe(dupeId);
         }
      }
    );
  }
};

DB.activateDupe = function (dupeId) {
  var data = DB.instances[dupeId];
  $("instances").innerHTML = TrimPath.processDOMTemplate("instancesT", {instances:data, dupeId:dupeId});
  DB.prevFragment = [-1,-1];
  DB.displayFragment(0, data[0][0], data[0][2], 0, data[0][1]);
  DB.displayFragment(1, data[1][0], data[1][2], 1, data[1][1]);
};

DB.fragmentsCache = {};
DB.displayFragment = function(i, fileId, offsetInfo, pane, startLine) {
  DB.paneLine[pane] = startLine;
  if (DB.prevFragment[pane]==i) return;

  //move cursor
  var paneEl = $("instance_" + DB.prevFragment[pane]);
  if (paneEl) {
    paneEl.removeClassName("cursor_" + pane);
  }
  $("instance_" + i).addClassName("cursor_" + pane);
  DB.prevFragment[pane] = i;

  var key = fileId + "_" + offsetInfo;
  if (DB.fragmentsCache[key]) {
    DB.formatFragment(pane, i, DB.files[fileId], DB.fragmentsCache[key], startLine);
  } else {
    $("file_"+pane).innerHTML = '<i class="icon-refresh icon-spin"></i>&nbsp;Loading...';
    $("pane_"+pane).innerHTML = "";
    BS.ajaxRequest("duplicatesTabText.html?buildId=${build.buildId}&fileName=" + encodeURIComponent(DB.files[fileId]) + "&offsetInfo=" + encodeURIComponent(offsetInfo) + "&startLine=" + startLine, {
         onSuccess: function(t) {
           DB.fragmentsCache[key] = t.responseText;
           DB.formatFragment(pane, i, DB.files[fileId], DB.fragmentsCache[key], startLine);
           DB.doResize();
         }
      }
    );
  }
};

DB.formatFragment = function(pane, i, name, text, startLine) {
  $("filepath_" + pane).value = name;
  var nameSplit = name.lastIndexOf("/") + 1;
  var fileName = name.substring(nameSplit);
  var filePath = name.substring(0, nameSplit);
  $("file_" + pane).innerHTML = "#" + (i + 1) + " " + fileName + ":" + (startLine) + "<br>" + filePath;
  $("pane_" + pane).innerHTML = text;
};

DB.openFragment = function(pane) {
  var filePath = $("filepath_"+pane).value.replace("\\","/","gi");
  BS.Activator.doOpen("file?file="+filePath+"&line="+DB.paneLine[pane]);
};

DB.doResize = function() {
  var height = $j(window).height();
  var offset = $j("#sources").offset().top + 115;

  height = height - offset;

  var leftPane = $j("#outer_0"),
      rightPane = $j("#outer_1");

  leftPane.height(height);
  leftPane.find(".paneInner").height(height);

  rightPane.height(height);
  rightPane.find(".paneInner").height(height);
};

$j(document).ready(function() {
  DB.doResize();
  DB.listModules();
});

$j(window).resize(_.throttle(DB.doResize, 50));

</script>
